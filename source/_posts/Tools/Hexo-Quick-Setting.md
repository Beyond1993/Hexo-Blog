---
title: Hexo-Quick-Setting
date: 2017-09-20 20:01:31
categories: Tools
tags:
---

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
