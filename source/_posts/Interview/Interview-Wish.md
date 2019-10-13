---
title: Interview-Wish
date: 2019-10-09 03:00:50
categories: Interview
tags:
---


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




