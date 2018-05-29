---
title: Normalization
date: 2018-05-28 21:42:54
categories: Python
tags:
---

def normalization(maps):
    level1_map = {}
    level2_map = {}
    level3_map = {}

    for k1, v1 in maps.iteritems():
        for k2, v2 in v1.iteritems():
            for index in xrange(len(v2)):
                for k4, v4 in v2[index].iteritems():
                    if index == 0:
                       key = v4
                    else:
                       value = v4
                       level3_map[key] = value
                level2_map[k2] = level3_map
                level1_map[k1] = level2_map

    return level1_map



test1_map = {'b' :
              {'a':
                  [{'key':'key1'}, {'value' : 'value1'}]
              }
            }

print normalization(test1_map)

