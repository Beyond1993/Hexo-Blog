---
title: Interview-DoorDash
date: 2025-01-21 07:47:42
categories: Interview
tags:
---
sddscdscds
给一个数组[1,3,2,...]和一个字符串比如FW?FF??W，数组里的每个数代表连续的F的个数（比如1可以对标FWW或者WFW或者），字符串中的每个问号可以代替一个F或一个W。问这个字符串一共可以组成多少种有效的FW组合。

比如数组是[1,2]而字符串是?W??FW，那valid pattern就只有有FWWFFW一种（不可以是WWFFFW因为中间的1+2已经是连续的3了）。
但如果数组是[1,1]那么?WW??就可以有FWWWF和FWWFW两种。
而数组[1,1]和字符串WW??W应该返回0，因为没有valid pattern（没有两个分开的长度为1的F）

https://leetcode.com/discuss/interview-question/6308692/valid-fw-patterns/2819126

https://leetcode.com/discuss/interview-question/1367130/doordash-phone-interview


```python
class Menu:
    class Node:
        def __init__(self, key, value, is_active):
            self.key = key
            self.value = value
            self.is_active = is_active
            self.children = []

        def __eq__(self, node):
            if node is None:
                return False
            return self.key == node.key and self.value == node.value and self.is_active == node.is_active

        def __str__(self):
            return self.key

    @staticmethod
    def get_modified_items(old_menu, new_menu):
        if old_menu is None and new_menu is None:
            return 0
        
        count = 0
        if old_menu is None or new_menu is None or old_menu != new_menu:
            print(f"{old_menu} {new_menu}")
            count += 1
        
        children1 = Menu.get_child_nodes(old_menu)
        children2 = Menu.get_child_nodes(new_menu)

        # Compare children of the old and new menus
        for key in children1:
            count += Menu.get_modified_items(children1[key], children2.get(key))

        for key in children2:
            if key not in children1:
                count += Menu.get_modified_items(None, children2[key])

        return count

    @staticmethod
    def get_child_nodes(menu):
        node_map = {}
        if menu is None:
            return node_map
        for node in menu.children:
            node_map[node.key] = node
        return node_map


# 示例使用
if __name__ == "__main__":
    # 创建旧菜单
    a = Menu.Node("a", 1, True)
    b = Menu.Node("b", 2, True)
    c = Menu.Node("c", 3, True)
    d = Menu.Node("d", 4, True)
    e = Menu.Node("e", 5, True)
    g = Menu.Node("g", 7, True)

    a.children.append(b)
    a.children.append(c)
    b.children.append(d)
    b.children.append(e)

    # 创建新菜单
    a1 = Menu.Node("a", 1, True)
    b1 = Menu.Node("b", 2, True)
    c1 = Menu.Node("c", 3, True)
    d1 = Menu.Node("d", 4, True)
    e1 = Menu.Node("e", 5, True)
    f1 = Menu.Node("f", 6, True)
    g1 = Menu.Node("g", 7, False)

    a1.children.append(b1)
    a1.children.append(c1)
    b1.children.append(d1)
    c1.children.append(e1)

    # 计算变化的节点数量
    count = Menu.get_modified_items(a, a1)
    print(f"Changed Items are: {count}")
```




