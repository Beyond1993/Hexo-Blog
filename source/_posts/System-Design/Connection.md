---
title: Connection
date: 2021-03-15 04:43:35
categories: System Design 
tags:
---


Long-Polling vs WebSockets vs Server-Sent Events


Ajax Polling: Client pull, many retries with empty message
HTTP Long-Polling: Client pull
WebSockets: Server push, 双向连接
Server-Sent Event(SSEs) ==> Server push, 单向连接

我们应该如何选择 SSE, WebSocket and polling
按照上面的例子来看， 我们似乎可以认为SSE是最适合的，但是SSE也存在一些问题等待我们解决。

以下是我们可以使用SSE的几个例子

流媒体股票价格实时图表
实时重要新闻的报道（发布链接，推送文和图片）
由twitter或者是github的流媒体推送的实时仪表盘
各种系统监控

也有一些SSE不适合的场景， 比如像MMO（大型多人在线）游戏这样的场景， 它需要来自链接两端大量的消息（全双工）这时 websocket 则占据完全优势。

如果你的使用场景是 实时显示市场新闻，股市数据，聊天记录之类的， 那么 HTTP/2 + SSE 将会给你提供非常高效的数据传输方式


