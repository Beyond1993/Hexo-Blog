---
title: Python-Bisect
date: 2025-04-15 12:33:29
categories: Python
tags:
---

方法	作用
bisect_left	找到第一个 ≥ x 的位置
bisect_right	找到第一个 > x 的位置（也叫 bisect）

考虑重复元素

插入 left 说明 找到第一个 >=x 的位置，然后往左移一位就是要插入的位置
插入 right, 说明 找到第一个 > x 的位置， 就是必须比x 大
