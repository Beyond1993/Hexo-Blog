---
title: Interview-Wish
date: 2019-10-09 03:00:50
categories: Interview
tags:
---


https://www.1point3acres.com/bbs/tag-48-2.html

https://www.1point3acres.com/bbs/forum.php?mod=collection&action=view&ctid=229044&page=4

https://www.1point3acres.com/bbs/collection/229044

https://www.1point3acres.com/bbs/forum.php?mod=viewthread&tid=556842&ctid=229044

https://www.1point3acres.com/bbs/forum.php?mod=viewthread&tid=556358&ctid=229044

https://www.1point3acres.com/bbs/forum.php?mod=viewthread&tid=556211&ctid=229044

https://www.1point3acres.com/bbs/interview/wish-software-engineer-508158.html

https://www.1point3acres.com/bbs/interview/software-engineer-283244.html

https://www.1point3acres.com/bbs/tag-48-7.html

https://www.1point3acres.com/bbs/thread-464716-1-1.html

https://www.1point3acres.com/bbs/thread-523424-1-1.html

https://www.1point3acres.com/bbs/thread-527421-1-1.html

https://www.1point3acres.com/bbs/thread-548749-1-1.html

https://www.1point3acres.com/bbs/thread-553236-1-1.html

https://www.1point3acres.com/bbs/thread-543567-1-1.html

https://www.1point3acres.com/bbs/thread-539063-1-1.html

找亲戚关系

```java
// "static void main" must be defined in a public class.
public class Main {
    static Map<String, List<String> > graph = new HashMap<>();
    static List<String> result = new ArrayList<>();

    public static void main(String[] args) {
        String[][] relationships = {{"bart", "brother", "lisa"},
                                            {"bart", "son", "homer"},
                                            {"marge", "wife", "homer"},
                                            {"lisa", "daughter","homer"}
                                            };
        
        buildGraph(relationships);
        
        // for (Map.Entry<String, List<String>> e : graph.entrySet()) {
        //     System.out.print(e.getKey() + " ");
        //     System.out.println(e.getValue());
        // }
        List<String> temp = new ArrayList<>();
        getRelationShip(temp, "bart", "homer");
        for (int i = 0; i < result.size(); i++) {
            System.out.println(result.get(i));
        }
}

private static void buildGraph(String[][] relationships)
{
    for (int i = 0; i < relationships.length; i++) {
        String name1 = relationships[i][0];
        String relationship = relationships[i][1];
        String name2 = relationships[i][2];

        if (graph.containsKey(name1)) 
        {
            graph.get(name1).add(name2 + " " + relationship);
        } 
        else 
        {
            List<String> list = new ArrayList<String>();
            list.add(name2 + " " + relationship);
            graph.put(name1, list);
        }

    }
}

private static void getRelationShip(List<String> temp, String person1, String person2) {
    
    if (person1.equals(person2)) {
        String str = "";
        for (String s : temp) {
            str += s + " ";
        }
        str += person1;
        //System.out.println(str);
        result.add(str.trim());
        return;
    }
    if (!graph.containsKey(person1)) {
        return;
    }
    
    
    List<String> neighbors = graph.get(person1);
    temp.add(person1);
    for (String value : neighbors) {
        String name2 = value.split(" ")[0];
        String relationship = value.split(" ")[1];
        List<String> temp2 = temp;
        temp2.add(relationship);
        //temp2.add(name2);
        getRelationShip(temp2, name2, person2);
        temp.remove(name2);
        temp.remove(relationship);
    }
}
    
}

//有人辞官归故乡 有人雪夜赶考场


/*
{"bart", "brother", "lisa"}
{"bart", "son", "homer"}
{"Marge", "wife", "homer"}
{"Lisa", "daughter""Homer"}
*/
```

Random Pick with Weight
```java


```

简历介绍 + 经典面经, 判定是不是bot. 这个题我说了地里面的lazy deletion解法, 面试官要求进一步优化空间(handle很多人一天只登录了一次的情况).
没做出来, 代码也没写.
面试官直接说答案是存 Map<user id, count of login event in timeframe> + Queue<Event(user id, timestamp)>.
只存一个timeframe(比如60s)里面的所有event. 每当有新的timestamp扫描进来的时候, 移除queue里面所有超时的event, 同时更新map里面userid对应的count




A bot is an id that visit the site m times in the last nseconds,
given a list of logs with id and time sorted by time, returnall the bots's id


```java
// "static void main" must be defined in a public class.
public class Main {
    public static void main(String[] args) {
        int[][] events = {{1, 5}, {2,6}, {2,8}, {1,12}, {2,13}, {1,14}, {2,34},{3,40}}; 
        System.out.println(getBots(3,10,events));
    }
    
    public static List<Integer> getBots(int m, int n, int[][] events)
    {
        
        Map<Integer, Integer> map = new HashMap<>();
        Deque<int[]> queue = new LinkedList<>();
        List<Integer> result = new ArrayList<Integer>();
        queue.addLast(events[0]);
        map.put(events[0][0], 1); // {1,5} <1,1>
        for (int i = 1; i < events.length; i++) {
            int id = events[i][0];
            int timestamp = events[i][1]; //6
            
            map.put(id, map.getOrDefault(id, 0) + 1); // <2,1>
            queue.addLast(events[i]); // {1,5}, {2,6}
           
            while(!queue.isEmpty()) {
                int[] event = queue.peekFirst();
                if (event[1] <= timestamp - n) { //34 - 10 = 24
                    queue.poll();
                    map.put(event[0], map.get(event[0]) - 1);
                } else {
                    break;
                }
            }
            if (map.get(id) >= m) {
                result.add(id);
            }          
        }
        return result;
    }
}
```


https:://docs.google.com/document/d/1iaydfHhZ6NWgNq7kv6lDg11kusfXF51EDE-Y00WHNBY/edit


设计一个Object，记录库存有多少，售出了多少与购买纪录
如果有进货，要满足之前没有满足的购买纪录
每一笔存货有进货价钱，售出价钱大于进货价钱才能卖出


design  先是一个API 一个类似message app,  然后加上各种 高并发情况怎么处理，怎么保证信息一定送到 DB怎么design  然后是OOD design 21点
