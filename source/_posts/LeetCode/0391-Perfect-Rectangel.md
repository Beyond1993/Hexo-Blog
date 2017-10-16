---
title: 0391-Perfect-Rectangel
date: 2017-10-16 06:29:39
categories: LeetCode
tags:
---

完美三角形．给出若干个矩形的左下和右上角坐标．判断这些矩形能不能刚好组成一个大的矩形．不能有重叠，不能有空隙．



这题的思路是：

１．最外面的四个点只出现一次，　其余点均出现两个．

２．最外面四个点构成的矩形面积刚好是所有小矩形的面积之和．

class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        int len = rectangles.size();
        int x1 = INT_MAX;//left_buttom_x
        int x2 = INT_MIN;//right_top_x
        int y1 = INT_MAX;//left_button_y
        int y2 = INT_MIN;//right_top_y
        set<pair<int, int>> points;
        int area = 0;
        for (int i = 0; i < len; i++) {
            vector<int> v = rectangles[i];
           
            x1 = min(x1,v[0]);
            y1 = min(y1,v[1]);
            x2 = max(x2,v[2]);
            y2 = max(y2,v[3]);
            area += (v[2] - v[0]) * (v[3] - v[1]);
            
            if(!points.insert(make_pair(v[0],v[1])).second == true) points.erase(make_pair(v[0],v[1]));
            
            if(!points.insert(make_pair(v[0],v[3])).second) points.erase(make_pair(v[0],v[3]));
            
            if(!points.insert(make_pair(v[2],v[3])).second) points.erase(make_pair(v[2],v[3]));
            
            if(!points.insert(make_pair(v[2],v[1])).second) points.erase(make_pair(v[2],v[1]));
            
        }
        if (points.size()!= 4 || !points.count(make_pair(x1,y1)) ||!points.count(make_pair(x1,y2)) || 
            !points.count(make_pair(x2,y1)) || !points.count(make_pair(x2,y1))) {
            
            return false;
        }
        return area == (x2 - x1) * (y2 -y1);
    }
};


在set insert 后，　返回一个pair< set<>::iterator, bool> 插入成功则为true, 插入失败则为false.








