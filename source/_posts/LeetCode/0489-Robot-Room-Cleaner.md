---
title: 0489 Robot Room Cleaner
date: 2019-08-05 01:25:34
categories: LeetCode
tags:
---

```java
public class Pair<F, S> {
  public F first;
  public S second;

  public Pair(F first, S second) {
    this.first = first;
    this.second = second;
  }

  @Override
  public boolean equals(Object o) {
    Pair<F, S> p = (Pair<F, S>) o;
    return Objects.equals(p.first, first) && Objects.equals(p.second, second);
  }

  @Override
  public int hashCode() {
    return first.hashCode() ^ second.hashCode();
  }
}

class Solution {
  // going clockwise : 0: 'up', 1: 'right', 2: 'down', 3: 'left'
  int[][] directions = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
  Set<Pair<Integer, Integer>> visited = new HashSet();
  Robot robot;

  public void goBack() {
    robot.turnRight();
    robot.turnRight();
    robot.move();
    robot.turnRight();
    robot.turnRight();
  }

  public void backtrack(int row, int col, int d) {
    visited.add(new Pair(row, col));
    robot.clean();
    // going clockwise : 0: 'up', 1: 'right', 2: 'down', 3: 'left'
    for (int i = 0; i < 4; ++i) {
      int newD = (d + i) % 4;
      int newRow = row + directions[newD][0];
      int newCol = col + directions[newD][1];

      if (!visited.contains(new Pair(newRow, newCol)) && robot.move()) {
        backtrack(newRow, newCol, newD);
        goBack();
      }
      // turn the robot following chosen direction : clockwise
      robot.turnRight();
    }
  }

  public void cleanRoom(Robot robot) {
    this.robot = robot;
    backtrack(0, 0, 0);
  }
}
```


```java
class Solution {
    int[] dx = {-1, 0, 1, 0};
    int[] dy = {0, 1, 0, -1};
    public void cleanRoom(Robot robot) {
        HashSet<String> visited = new HashSet<String>();
        dfsClean(visited, robot, 0, 0, 0);
    }
    
    public void dfsClean(HashSet<String> visited, Robot robot, int x, int y, int direction){
        String tmp = x + "." + y;
        if(visited.contains(tmp)){
            return;
        }
        robot.clean();
        visited.add(tmp);
        for(int i = 0; i < 4; i++){
            int curDirection = (direction + i) % 4;
            int nextX = x + dx[curDirection];
            int nextY = y + dy[curDirection];
            if(robot.move()){
                dfsClean(visited, robot, nextX, nextY, curDirection);
                robot.turnLeft();
                robot.turnLeft();
                robot.move();
                robot.turnRight();
                robot.turnRight();
            }
            robot.turnRight();
        }
        
    }
}
```
