---
title: Normalization
date: 2018-05-28 21:42:54
categories: Python
tags:
---

normalization for nested list and maps:

```python
def normalize(collections):
    if type(collections) is list:
        new_map = {}
        for e in collections:
            temp_map = normalize(e)
            for k,v in temp_map.iteritems():
                new_map[k] = v
        return new_map

    maps = collections
    result = {}
    for k,v in maps.iteritems():
        if type(v)  is dict or type(v) is list:
            normalize(v)
        else:
            result[k] = v
    return result
```

compare two maps

```python
def diffMap(d1,d2):
    message = ['']
    diffMapHelper(d1, d2, message)
    return message[0]

def diffMapHelper(d1, d2, message, path = ''):
    for k in d1.keys():
        if not d2.has_key():
            path = path + '\n'
            path = path + 'as key not in d2\n'
        else:
            if type(d1[k]) is dict:
                if path == ''
                    path = k
                else:
                    path = path + '->' + k
                diffMapHelper(d1[k], d2[k], path)
                length = len(k) + 2
                path = path[:-length]
            else：
                if d1[k] != d2[k]:
                    message[0] += path + '\n'
                    message[0] += '-' + k + ' : ' + str(d1[k]) + '\n'
                    message[0] += '-' + k + ' : ' + str(d2[k]) + '\n'

```
