# migrate_csdn_images.py
import os
import re
import requests
import base64
import hashlib
import time

# 从 GitHub Actions 环境变量读取 token
GH_TOKEN = os.getenv("PERSONAL_TOKEN")
if not GH_TOKEN:
    raise ValueError("PERSONAL_TOKEN 未在 GitHub Secrets 中设置！")

REPO = "iamxurulin/HugoBlog"  # 你的源码仓库
BRANCH = "main"
IMAGES_DIR = "static/images"  # Hugo 静态资源目录

HEADERS = {
    "Authorization": f"token {GH_TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}

# 更强的正则：匹配所有 CSDN 图片链接（支持 #pic_center、参数等）
CSDN_PATTERN = r'!\[([^\]]*)\]\((https?://i-blog\.csdnimg\.cn/[^\)\s]+)\)'


def get_image_name(url):
    """生成唯一且安全的文件名，保留原始扩展名"""
    # 提取路径最后一部分，去掉查询参数
    filename = url.split('/')[-1].split('?')[0].split('#')[0]
    
    # 如果没有扩展名，尝试根据内容推断（后面下载后再确认），默认 png
    if not os.path.splitext(filename)[1].lower() in ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg']:
        filename += ".png"
    
    # 加 hash 前缀避免重名
    hash_prefix = hashlib.md5(url.encode()).hexdigest()[:8]
    name, ext = os.path.splitext(filename)
    return f"{name}-{hash_prefix}{ext}"


def upload_image(content, path):
    """上传图片到 GitHub（已存在则跳过）"""
    api_url = f"https://api.github.com/repos/{REPO}/contents/{path}"
    
    # 检查是否已存在
    resp = requests.get(api_url, headers=HEADERS)
    if resp.status_code == 200:
        print(f"✓ 图片已存在，跳过上传: {path}")
        return True
    
    if resp.status_code != 404:
        print(f"检查图片存在时出错: {resp.status_code} {resp.text}")
        return False
    
    # 上传新图片
    data = {
        # 重点：加上 [skip ci]，告诉 GitHub Actions 别因为这次提交而再次启动
        "message": f"Add image: {os.path.basename(path)} (CSDN migration) [skip ci]",
        "content": base64.b64encode(content).decode('utf-8'),
        "branch": BRANCH
    }
    
    put_resp = requests.put(api_url, json=data, headers=HEADERS)
    if put_resp.status_code in [200, 201]:
        print(f"✓ 上传成功: {path}")
        return True
    else:
        print(f"✗ 上传失败: {put_resp.status_code} {put_resp.text}")
        return False


def process_md_file(file_path):
    """处理单个 Markdown 文件中的所有 CSDN 图片"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 查找所有图片匹配
    matches = re.findall(CSDN_PATTERN, content)
    if not matches:
        return False  # 没有 CSDN 图片
    
    print(f"正在处理文章: {file_path}，发现 {len(matches)} 张 CSDN 图片")
    
    changed = False
    new_content = content
    
    for alt_text, img_url in matches:
        print(f"  → 处理: {img_url}")
        
        try:
            # 下载图片（加 Referer 防盗链）
            img_resp = requests.get(
                img_url,
                headers={'Referer': 'https://blog.csdn.net/'},
                timeout=30
            )
            if img_resp.status_code != 200:
                print(f"  ✗ 下载失败 (HTTP {img_resp.status_code})")
                continue
            
            # 生成新文件名
            img_name = get_image_name(img_url)
            img_path = f"{IMAGES_DIR}/{img_name}"
            
            # 上传到 GitHub
            if upload_image(img_resp.content, img_path):
                # 替换为 Hugo 正确的本地路径
                new_url = f"/images/{img_name}"
                new_markdown = f"![{alt_text}]({new_url})"
                
                # 替换完整匹配项（保留 alt 文本）
                new_content = new_content.replace(f"![{alt_text}]({img_url})", new_markdown)
                
                # 也替换可能存在的裸 URL 或带参数的
                new_content = new_content.replace(img_url, new_url)
                
                changed = True
                print(f"  ✓ 已替换为: {new_url}")
        
        except Exception as e:
            print(f"  ✗ 处理出错: {e}")
        
        time.sleep(0.8)  # 防 GitHub API 限流
    
    # 写回文件
    if changed:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"✓ 已更新文章: {file_path}\n")
    
    return changed


def main():
    print("开始迁移 CSDN 图片到本地 static/images...\n")
    
    changed_files = 0
    for root, _, files in os.walk("content"):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                if process_md_file(file_path):
                    changed_files += 1
    
    print("="*50)
    if changed_files > 0:
        print(f"🎉 迁移完成！共更新 {changed_files} 篇文章")
        print("所有 CSDN 图片已搬家到 static/images/，链接已替换为本地路径")
    else:
        print("未发现需要迁移的 CSDN 图片（可能已全部处理完毕）")


if __name__ == "__main__":
    main()