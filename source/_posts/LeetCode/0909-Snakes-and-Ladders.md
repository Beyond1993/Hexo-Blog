---
title: 0909 Snakes and Ladders
date: 2020-06-29 02:04:53
categories: LeetCode
tags:
---


在N x N板上，从1到N * N的数字是从板的左下角开始按字母顺序写的，并交替显示每一行的方向。例如，对于6 x 6的板，数字如下所示：

您从木板的正方形1开始（始终在最后一行和第一列）。从平方x开始的每一步都包括以下内容：

您可以选择数字为x + 1，x + 2，x + 3，x + 4，x + 5或x + 6的目标正方形S，前提是此数字<= N * N。
（此选择模拟了标准的6面压模辊的结果：即，不管板的尺寸如何，始终最多有6个目的地。）
如果S有蛇或梯子，则移至该蛇或梯子的目的地。否则，您移至S。
如果board [r] [c]！= -1，则在r行和c列上的木板正方形具有“蛇形或阶梯形”。那条蛇或梯子的目的地是木板[r] [c]。

请注意，每条动作最多只能带一条蛇或梯子：如果蛇或梯子的目的地是另一条蛇或梯子的起点，则不要继续移动。 （例如，如果棋盘为`[[[4，-1]，[-1,3]]`，并且在第一步移动时，目标方块为`2`，那么您在第一步移至`3`，因为您不会继续移动到“ 4”。）


广度优先搜索BFS。最直接的应用是找到迷宫遍历问题中从起点到终点的最小步数。它也可以在更一般的情况下使用。只要存在一定的状态转换，也可以使用它。 。这个问题基本上是一个类似于迷宫穿越的问题。可以采取的步骤1至6可以假定六个方向，因此您可以选择一个迷宫。唯一的特殊处理是遇到梯子并跳到另一个位置。 。这个问题还有另一个困难，那就是数字标记和阵列的二维坐标的转换。此处的起点在二维排列的左下角，它是1，代码中定义的二维数组（0，0）该点在左上角，您需要转换它，并且这个问题的编号被蛇包围，也就是说，当行号为奇数时，它从右到左遍历，转换时要注意。


```python
class Solution {
    public int snakesAndLadders(int[][] board) {
        if (board == null || board.length == 0 || board[0].length == 0) {
            return -1;
        }
        int rows = board.length;
        int cols = board[0].length;
        int dest = rows * cols;
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        Set<Integer> set = new HashSet<>();
        set.add(1);
        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                if (curr == dest) {
                    return steps;
                }
                for (int diff = 1; diff <= 6 && curr + diff <= dest; diff++) {
                    int[] pos = getCoordinate(curr + diff, rows, cols);
                    int next = board[pos[0]][pos[1]] == -1 ? curr + diff : board[pos[0]][pos[1]];
                    if (!set.contains(next)) {
                        queue.offer(next);
                        set.add(next);
                    }
                }
            }
            steps++;
        }
        return -1;
    }
    
    public int[] getCoordinate(int n, int rows, int cols) {
        int r = rows - 1 - (n - 1) / cols;
        int c = (n - 1) % cols;
        if (r % 2 == rows % 2) {
            return new int[]{r, cols - 1 - c};
        } else {
            return new int[]{r, c};
        }
    }
}
```
