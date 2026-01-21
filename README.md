# Coder_Studio - 个人技术博客

**网站地址**：<https://iamxurulin.github.io>

采用 Hugo 静态站点生成器 + GitHub Pages 托管，实现零服务器成本、全自动部署。

## 🚀 主要特性

- **全自动 CI/CD**：代码 Push 即触发 GitHub Actions 自动构建与部署，支持并发控制与强制覆盖，避免部署冲突
- **文章图片自托管**：Python 脚本自动迁移 CSDN 图床图片到本地仓库，彻底解决外链失效问题
- **Live2D 看板娘**：集成 Natori 模型，支持拖拽，提升趣味性
- **用户体验优化**：
  - 响应式布局 + 暗色模式
  - 长代码自动折叠（点击展开）
  - 页面加载动画 + 音乐播放器（切换页面不中断）
  - 自定义鼠标光标、时钟组件
  - 浏览量统计（busuanzi）

## 🛠️ 技术栈

- **静态站点生成**：Hugo (Go)
- **主题**：hugo-theme-stack
- **部署**：GitHub Actions + peaceiris/actions-gh-pages@v4
- **脚本**：Python（requests + BeautifulSoup 迁移 CSDN 图片）
- **前端**：SCSS、JavaScript、Live2D、APlayer
- **版本控制**：Git + GitHub

## 📝 开发与部署流程

1. 开发 Python 脚本按需从 CSDN 批量导出文章为标准 Markdown 格式
2. `git push` 到源码仓库
3. GitHub Actions 自动触发：
   - 执行 Python 脚本下载并上传图片到仓库
   - Hugo 构建静态站点
   - 强制部署到 `iamxurulin.github.io` 仓库的 main 分支
4. GitHub Pages 自动更新，几分钟内新文章上线

---

**维护者**：[@iamxurulin](https://github.com/iamxurulin)

感谢每一位读者与支持者！

## 博客首页

![alt text](/static/image.png)

## 博客分类

![alt text](/static/image-1.png)

## 博客标签

![alt text](/static/image-2.png)
