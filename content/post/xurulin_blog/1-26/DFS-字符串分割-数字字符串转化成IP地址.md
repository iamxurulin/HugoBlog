---
title: "DFS-字符串分割-数字字符串转化成IP地址"
date: 2026-01-23 00:25:31
categories:
  - 算法
tags:
  - 搜索
draft: false
---


<!-- 这是一张图片，ocr 内容为： -->
![](/images/e1e7f23e3f07b68cf0387165853920ba-39e8018c.jpeg)

### 求解代码
```java
ArrayList<String> ans = new ArrayList<>();
    public ArrayList<String> restoreIpAddresses (String s) {

        if(s==null||s.length()<4||s.length()>12){
            return ans;
        }
        StringBuilder sb = new StringBuilder();
        dfs(s,sb,0,0);
        return ans;
    }

    private void dfs(String s,StringBuilder sb,int step,int index){
        if(step==4){
            if(index==s.length()){
                ans.add(sb.toString());
            }
            return;
        }else{
            for(int i=index;i<index+3&&i<s.length();i++){
                String cur = s.substring(index,i+1);
                
                if(Integer.parseInt(cur)>255||(cur.length()>1&&cur.charAt(0)=='0')){
                    continue;
                }
                sb.append(cur);
                if(step<3){
                    sb.append('.');
                }
                dfs(s,sb,step+1,i+1);
                if(step<3){
                    sb.deleteCharAt(sb.length()-1);
                }
                sb.delete(sb.length()-cur.length(), sb.length());


            }
        }
    }
```

### 小贴士
`sb.delete(sb.length()-cur.length(), sb.length())`这行代码是删除字符串中「从`sb.length()-cur.length()`索引（包含）到`sb.length()`索引（不包含）」的所有字符，是一个**左闭右开**区间。

说人话就是：

删除 StringBuilder 中最后面的、长度等于 cur 的所有字符，也就是是把之前拼接的当前 IP 段 cur 从 sb 中删掉，恢复 sb 到拼接 cur 前的状态。




