---
title: STL
date: 2017-10-16 06:36:42
categories: C/C++
tags:
---

## vector
vector 是STL最常见的数据结构了。
std::vector is a template class that encapsulated a dynamic array, stored in the heap 

增删改查

## array
STL 里的array， 就是对C++ 普通array 的一种封装。 它是fixed size, more efficiect for small size, alloecated in stack.
## list

## map

## multimap



## set

## multiset

## queue

## priority_queue

## stack  

## deque

C++ STL中的remove和erase函数曾经让我迷惑，同样都是删除，两者有什么区别呢？



vector中的remove的作用是将等于value的元素放到vector的尾部，但并不减少vector的size

vector中erase的作用是删除掉某个位置position或一段区域（begin, end)中的元素，减少其size



list容器中的remove 成员函数，原型是void remove (const value_type& val);

他的作用是删除list中值与val相同的节点，释放该节点的资源。



而list容器中的erase成员函数，原型是iterator erase (iterator position);

作用是删除position位置的节点。这也是与remove不同的地方。

考虑到list::erase是与位置有关，故erase还存在API:   iterator erase (iterator first, iterator last);

对于list 来说，什么时候用 remove 什么时候用 erase ?

erase 删除指定地址上的单个元素，remove 可以删除多个相同元素



对于set来说，只有erase API，没有remove API。 erase 的作用是把符合要求的元素都删掉。

(1) void erase (iterator position);
(2) size_type erase (const value_type& val);
(3) void erase (iterator first, iterator last);





综上所述，erase一般是要释放资源，真正删除元素的，

而remove主要用在vector中，用于将不符合要求的元素移到容器尾部，而并不删除不符合要求的元素


multiset multimap
```C++
#include <map>
#include <string>
#include <utility>
using namespace std;

int main()
{
    //定义作者名数组
    string authors[] = {"Stanley B.Lippman", "Scott Meyers"};
    //定义作者名-书名multimap
    multimap<string, string> auth_books;

    //向auth_books中插入信息
    auth_books.insert(make_pair(authors[0], string("c++ primer")));
    auth_books.insert(make_pair(authors[0], string("essential c++")));
    auth_books.insert(make_pair(authors[1], string("effective c++")));
    auth_books.insert(make_pair(authors[1], string("more effective c++")));
    auth_books.insert(make_pair(authors[1], string("effective stl")));
    
    /****************************************************/
    //第一种方式，使用find和count查找作者对应的书名信息并输出
    cout << "========================" << endl;
    typedef multimap<string, string>::size_type sz_type;
    sz_type num = auth_books.count(authors[0]);
    multimap<string, string>::iterator it = auth_books.find(authors[0]);

    //因为在multimap和multiset中具有相同键的元素相邻存放，所以可通过迭代器依次访问
    //输出查找结果
    for (sz_type cnt = 0; cnt != num; ++cnt, ++it)
        cout << it->second << endl;
    cout << "========================" << endl;

    /***************************************************/
    //第二种方式，lower_bound和upper_bound
    typedef multimap<string, string>::iterator auth_it;
    auth_it beg = auth_books.lower_bound(authors[1]);
    auth_it end = auth_books.upper_bound(authors[1]);
    while (beg != end){
        cout << beg->second << endl;
        ++beg;
    }
    cout << "========================" << endl;

    /***************************************************/
    //第三种方式，equal_range
    pair<auth_it, auth_it> pos = auth_books.equal_range(authors[0]);
    while (pos.first != pos.second){//pos.first等价于lower_bound()，pos.second等价于upper_bound()
        cout << pos.first->second << endl;
        ++pos.first;
    }
    cout << "========================" << endl;

    return 0;
}
```
