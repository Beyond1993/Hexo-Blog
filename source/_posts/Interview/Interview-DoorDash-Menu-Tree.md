---
title: Menu-Tree
date: 2025-02-12 13:13:43
categories: Interview
tags:
---


https://leetcode.com/discuss/interview-question/1367130/doordash-phone-interview

```python
class Node:
    def __init__(self, key, value, is_active):
        self.key = key
        self.value = value
        self.is_active = is_active
        self.children = []
    
    def equals(self, node):
        if node is None:
            return False
        return self.key == node.key and self.value == node.value and self.is_active == node.is_active
    
    def __str__(self):
        return self.key

def get_modified_items(old_menu, new_menu):
    if old_menu is None and new_menu is None:
        return 0
    
    count = 0
    if old_menu is None or new_menu is None or not old_menu.equals(new_menu):
        print(old_menu, new_menu)
        count += 1
    
    children1 = get_child_nodes(old_menu)
    children2 = get_child_nodes(new_menu)
    
    # 这个包含了两种情况，key 同时再 children1,2 里，key in children1, not in 2
    for key in children1:
        count += get_modified_items(children1[key], children2.get(key))
    
    ## key is i children 2, not in 1
    for key in children2:
        if key not in children1:
            count += get_modified_items(None, children2[key])
    
    return count

def get_child_nodes(menu):
    return {node.key: node for node in menu.children} if menu else {}

# Creating the existing tree
a = Node("a", 1, True)
b = Node("b", 2, True)
c = Node("c", 3, True)
d = Node("d", 4, True)
e = Node("e", 5, True)
g = Node("g", 7, True)

a.children.extend([b, c])
b.children.extend([d, e])

# Creating the new tree
a1 = Node("a", 1, True)
b1 = Node("b", 2, True)
c1 = Node("c", 3, True)
d1 = Node("d", 4, True)
e1 = Node("e", 5, True)
f1 = Node("f", 6, True)
g1 = Node("g", 7, False)

a1.children.extend([b1, c1])
b1.children.append(d1)
c1.children.append(e1)

count = get_modified_items(a, a1)
print("Changed Items are:", count)
```
