---
title: Sort Colors
date: 2024-08-12 06:51:13
categories: LeetCode
tags:
---


双向指针，但是两边不是同步移动的，对于左指针遇到2，放到最后一位，然后把最后一位交换到左指针位置，右指针左移，因为我们不知道把2移到最后一位，交换过来的是啥，然后再判断左右指针。同理右指针遇到0，要是换到左指针位置，再继续判断  