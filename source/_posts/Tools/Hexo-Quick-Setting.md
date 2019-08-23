---
title: Hexo-Quick-Setting
date: 2017-09-20 20:01:31
categories: Tools
tags:
---

安装 Next 主题

git clone https://github.com/theme-next themes/next

update blog/_config.yml theme : next


1. 配置目录
修改
blog/scaffolds/post.md

```text
---
title: {{ title }}
date: {{ date }}
categories:
tags:
---
```

2. 增加本地图片

在 source/ 目录下增减 images/ 修改images/ 权限
```text
![](/images/rpc.png)
```

3. 更换主题
只要把相应的主题放到 theme/ 下面就可以了。再修改根目录下的 _config.yml

git clone https://github.com/iissnan/hexo-theme-next themes/next

4. 添加音频/视频

5. 添加公式
Mathjax

blog/  npm install hexo-math --save

在全局的 _config.yml 里

```txt
math:
  engine: 'mathjax' # or 'katex'
  mathjax:
    src: custom_mathjax_source
    config:
      # MathJax config
  katex:
    css: custom_css_source
    js: custom_js_source # not used
    config:
      # KaTeX config
```

在 Next/theme/ 里
```txt
mathjax: true
per-page: true
```
