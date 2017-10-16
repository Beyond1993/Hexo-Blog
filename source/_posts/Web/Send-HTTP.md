---
title: Send-HTTP
date: 2017-10-16 06:53:48
categories: Web
tags:
---

send an HTTP requests with mock a browser.



bing_search_url = 'https://www.bing.com/search?q=fly+ticket'

payload = {'q' : 'fly ticket'}     

headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}

r = requests.get(bing_search_url, params=payload, headers=headers)

print(r.text)

https://docs.python.org/2/library/htmlparser.html#htmlparser-methods

一开始想用Python内置的HTMLParser来解析HTML，发现他自动调用的handle函数简直反人类。。

想找一个特定的tag的兄弟节点，很难处理复杂的HTML。



用beautifulsoup 吧








