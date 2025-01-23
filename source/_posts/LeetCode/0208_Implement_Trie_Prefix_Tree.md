---
title: 0208 Implement Trie Prefix Tree
date: 2025-01-23 07:08:10
categories: LeetCode
tags:
---

实现字典树

```python
class TrieNode:
    def __init__(self):
        self.chars = [None] * 26  # 存储26个字母的子节点
        self.is_end = False  # 标记是否是一个完整单词的结束


class Trie:
    def __init__(self):
        self.root = TrieNode()  # 初始化 Trie 树的根节点

    # 插入单词
    def insert(self, word: str) -> None:
        node = self.root
        for c in word:
            index = ord(c) - ord('a')  # 计算字符 'a' 到 'z' 的索引位置
            if not node.chars[index]:
                node.chars[index] = TrieNode()  # 如果当前字符不存在，创建新节点
            node = node.chars[index]
        node.is_end = True  # 标记单词的结尾

    # 查找单词
    def search(self, word: str) -> bool:
        node = self.root
        for c in word:
            index = ord(c) - ord('a')  # 计算字符 'a' 到 'z' 的索引位置
            if not node.chars[index]:
                return False  # 如果某个字符不存在，返回 False
            node = node.chars[index]
        return node.is_end  # 返回是否是一个完整单词

    # 查找前缀是否存在
    def startsWith(self, prefix: str) -> bool:
        node = self.root
        for c in prefix:
            index = ord(c) - ord('a')  # 计算字符 'a' 到 'z' 的索引位置
            if not node.chars[index]:
                return False  # 如果某个字符不存在，返回 False
            node = node.chars[index]
        return True  # 如果走到这里，表示前缀存在

```
