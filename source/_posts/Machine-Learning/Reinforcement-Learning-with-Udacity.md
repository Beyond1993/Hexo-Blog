---
title: Reinforcement-Learning-with-Udacity
date: 2018-12-05 20:31:55
categories: Machine-Learning
tags:
---

$$x = 100 * y + z - 10 / 33 + 10 % 3$$

强化学习三要素

Reward, State, Action

Sparse Reward 问题。

关于模拟国际象棋的问题.

错题集
Say you just started playing chess against your opponent, and it seems to be going great - you have played 20 moves and already taken five pieces from your opponent. The game hasn't ended yet, so you're not 100% sure you'll win, but it seems likely. What cumulative reward have you received so far?

the reward is 0.

你已经走了20步，吃掉了对方的五个棋子，虽然你有很大概率要赢了，但是还是没有赢。所以奖励依然是0.

Continuing tasks are tasks that continue forever, without end.
Episodic tasks are tasks with a well-defined starting and ending point.

问题:
Consider an agent who would like to learn to escape a maze. Which reward signals will encourage the agent to escape the maze as quickly as possible? Select all that apply.

A. The reward is -1 for every time step that the agent spends inside the maze. Once the agent escapes, the episode terminates.

B. The reward is +1 for every time step that the agent spends inside the maze. Once the agent escapes, the episode terminates.

C. The reward is -1 for every time step that the agent spends inside the maze. Once the agent escapes, it receives a reward of +10, and the episode terminates.

D. The reward is 0 for every time step that the agent spends inside the maze. Once the agent escapes, it receives a reward of +1, and the episode termiantes.

答案是A, C. 对于反馈的设定，一定要有正负反馈两种，情况，才能更快的加速。

$E = mc^2$

