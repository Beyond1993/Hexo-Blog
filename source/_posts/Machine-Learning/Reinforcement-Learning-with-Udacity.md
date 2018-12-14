---
title: Reinforcement-Learning-with-Udacity
date: 2018-12-05 20:31:55
categories: Machine-Learning
mathjax: true
---


强化学习三要素

Reward, State, Action

Sparse Reward 问题。

关于模拟国际象棋的问题.

教机器人走路的模型

$$ r = min(V_x, V_{max}) - 0.005(V_y^2 + V_z^2) - 0.05y^2 - 0.02||u||^2 + 0.02$$

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


原有的 return value:

$$ G_t = R_{t+1} + R_{t+2} + R_{t+3} + R_{t+4} + .... $$

discount value
$$ G_t = R_{t+1} + (.9)R_{t+2} + (.81)R_{t+3} + (.73)R_{t+4} + ... $$

那怎么定义discount rate 呢？$ \gamma \in [0,1] $

$$ G_t = R_{t+1} + \gamma R_{t+2} + \gamma^2R_{t+3} + \gamma^3R_{t+4} + ... $$

$\gamma$ 不是由agent 自己算出来的，而是由人工设置，以便优化目标。

$\gamma$ 是 1 就是non discount return value
$\gamma$ 是 0 就只关注于当前回报。

$\gamma$ 越高说明越注重未来的值，$\gamma$ 越低越注重现在的值。

discounting is particularly relevant to continuing tasks. continuing task 没有end。 如果连续性任务因为没有结束而显得时间太长，我们可以尝试使用discounting value 来忽略以后很久之后的回报.

如果agent 在 任意时间里选择action, 这种情况我们也需要discount rate 来更加专注于当前的reward.
