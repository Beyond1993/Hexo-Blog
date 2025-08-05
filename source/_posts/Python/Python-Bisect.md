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


| 方法                   | 作用                                     | 适合谁        |
| -------------------- | -------------------------------------- | ---------- |
| `bisect_right` → i-1 | 找到第一个 > key 的位置，再往前一格就是 **≤ key 的最大值** | floor\_key |
| `bisect_left` → i    | 找到第一个 ≥ key 的位置，就是 **≥ key 的最小值**      | ceil\_key  |

