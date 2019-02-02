---
title: Use Mente Carlo Methods to Play Blackjack
date: 2019-01-15 02:42:36
categories: Machine-Learning
tags:
---

Monte Carlo Methods
In this notebook, you will write your own implementations of many Monte Carlo (MC) algorithms.

While we have provided some starter code, you are welcome to erase these hints and write your code from scratch.

**Part 0: Explore BlackjackEnv**
We begin by importing the necessary packages.

```python
import sys
import gym
import numpy as np
from collections import defaultdict

from plot_utils import plot_blackjack_values, plot_policy
```

Use the code cell below to create an instance of the [Blackjack](https://github.com/openai/gym/blob/master/gym/envs/toy_text/blackjack.py) environment.

```python
env = gym.make('Blackjack-v0')
```

Each state is a 3-tuple of:

the player's current sum  ∈{0,1,…,31} ,
the dealer's face up card  ∈{1,…,10} , and
whether or not the player has a usable ace (no  =0 , yes  =1 ).
The agent has two potential actions:

    STICK = 0
    HIT = 1
Verify this by running the code cell below.

```python
print(env.observation_space)
print(env.action_space)
```

Tuple(Discrete(32), Discrete(11), Discrete(2))
Discrete(2)
Execute the code cell below to play Blackjack with a random policy.

(The code currently plays Blackjack three times - feel free to change this number, or to run the cell multiple times. The cell is designed for you to get some experience with the output that is returned as the agent interacts with the environment.)

```python
for i_episode in range(3):
    state = env.reset()
    while True:
        print(state)
        action = env.action_space.sample()
        state, reward, done, info = env.step(action)
        if done:
            print('End game! Reward: ', reward)
            print('You won :)\n') if reward > 0 else print('You lost :(\n')
            break
```

```txt
(20, 7, False)
(21, 7, False)
End game! Reward:  0.0
You lost :(

(21, 1, True)
End game! Reward:  1.0
You won :)

(16, 9, False)
End game! Reward:  -1.0
You lost :(
```
Part 1: MC Prediction
In this section, you will write your own implementation of MC prediction (for estimating the action-value function).

We will begin by investigating a policy where the player almost always sticks if the sum of her cards exceeds 18. In particular, she selects action STICK with 80% probability if the sum is greater than 18; and, if the sum is 18 or below, she selects action HIT with 80% probability. The function generate_episode_from_limit_stochastic samples an episode using this policy.

The function accepts as input:

bj_env: This is an instance of OpenAI Gym's Blackjack environment.
It returns as output:

episode: This is a list of (state, action, reward) tuples (of tuples) and corresponds to  (𝑆0,𝐴0,𝑅1,…,𝑆𝑇−1,𝐴𝑇−1,𝑅𝑇) , where  𝑇  is the final time step. In particular, episode[i] returns  (𝑆𝑖,𝐴𝑖,𝑅𝑖+1) , and episode[i][0], episode[i][1], and episode[i][2] return  𝑆𝑖 ,  𝐴𝑖 , and  𝑅𝑖+1 , respectively.

```python
def generate_episode_from_limit_stochastic(bj_env):
    episode = []
    state = bj_env.reset()
    while True:
        probs = [0.8, 0.2] if state[0] > 18 else [0.2, 0.8]
        action = np.random.choice(np.arange(2), p=probs)
        next_state, reward, done, info = bj_env.step(action)
        episode.append((state, action, reward))
        state = next_state
        if done:
            break
    return episode
```

Execute the code cell below to play Blackjack with the policy.

(The code currently plays Blackjack three times - feel free to change this number, or to run the cell multiple times. The cell is designed for you to gain some familiarity with the output of the generate_episode_from_limit_stochastic function.)

```python
for i in range(5):
    print(generate_episode_from_limit_stochastic(env))
```

```txt
[((21, 10, True), 1, 0), ((16, 10, False), 1, 0), ((19, 10, False), 0, 1.0)]
[((19, 7, False), 1, -1)]
[((19, 5, False), 0, 0.0)]
[((15, 7, False), 1, -1)]
[((17, 9, False), 1, -1)]
```

Now, you are ready to write your own implementation of MC prediction. Feel free to implement either first-visit or every-visit MC prediction; in the case of the Blackjack environment, the techniques are equivalent.

Your algorithm has three arguments:

env: This is an instance of an OpenAI Gym environment.
num_episodes: This is the number of episodes that are generated through agent-environment interaction.
generate_episode: This is a function that returns an episode of interaction.
gamma: This is the discount rate. It must be a value between 0 and 1, inclusive (default value: 1).
The algorithm returns as output:

Q: This is a dictionary (of one-dimensional arrays) where Q[s][a] is the estimated action value corresponding to state s and action a.


```python
def mc_prediction_q(env, num_episodes, generate_episode, gamma=1.0):
    # initialize empty dictionaries of arrays
    returns_sum = defaultdict(lambda: np.zeros(env.action_space.n))
    N = defaultdict(lambda: np.zeros(env.action_space.n))
    Q = defaultdict(lambda: np.zeros(env.action_space.n))
    # loop over episodes
    for i_episode in range(1, num_episodes+1):
        # monitor progress
        if i_episode % 1000 == 0:
            print("\rEpisode {}/{}.".format(i_episode, num_episodes), end="")
            sys.stdout.flush()
        
        ## TODO: complete the function
        # generate an episode
        episode = generate_episode(env)
        # obtain the states, actions, and rewards
        states, actions, rewards = zip(*episode)
        # prepare for discounting
        discounts = np.array([gamma**i for i in range(len(rewards)+1)])
        # update the sum of the returns, number of visits, and action-value 
        # function estimates for each state-action pair in the episode
        for i, state in enumerate(states):
            returns_sum[state][actions[i]] += sum(rewards[i:]*discounts[:-(1+i)])
            N[state][actions[i]] += 1.0
            Q[state][actions[i]] = returns_sum[state][actions[i]] / N[state][actions[i]]
      
    return Q
```

Use the cell below to obtain the action-value function estimate  𝑄 . We have also plotted the corresponding state-value function.

To check the accuracy of your implementation, compare the plot below to the corresponding plot in the solutions notebook Monte_Carlo_Solution.ipynb.


# obtain the action-value function
Q = mc_prediction_q(env, 500000, generate_episode_from_limit_stochastic)

for k,v in Q.items():
    print(k,v)
# obtain the corresponding state-value function
V_to_plot = dict((k,(k[0]>18)*(np.dot([0.8, 0.2],v)) + (k[0]<=18)*(np.dot([0.2, 0.8],v))) \
         for k, v in Q.items())

# plot the state-value function
plot_blackjack_values(V_to_plot)

这里很巧妙的用 lenght = 2 的数组，下标 0, 1 来表示 stick or hit
```txt
Episode 500000/500000.
(5, 10, False) [-0.61357702 -0.53730273]
(12, 10, False) [-0.58035455 -0.55633854]
(14, 10, False) [-0.57443182 -0.63039453]
(20, 10, False) [ 0.4363191  -0.88258628]
(19, 9, False) [ 0.2737174  -0.73653396]
(15, 10, False) [-0.56907334 -0.65209231]
```

## Part 2: MC Control
In this section, you will write your own implementation of constant- 𝛼  MC control.

Your algorithm has four arguments:

env: This is an instance of an OpenAI Gym environment.
num_episodes: This is the number of episodes that are generated through agent-environment interaction.
alpha: This is the step-size parameter for the update step.
gamma: This is the discount rate. It must be a value between 0 and 1, inclusive (default value:  1).
The algorithm returns as output:

Q: This is a dictionary (of one-dimensional arrays) where Q[s][a] is the estimated action value corresponding to state s and action a.
policy: This is a dictionary where policy[s] returns the action that the agent chooses after observing state s.
(Feel free to define additional functions to help you to organize your code.)

```python
def generate_episode_from_Q(env, Q, epsilon, nA):
    """ generates an episode from following the epsilon-greedy policy """
    episode = []
    state = env.reset()
    while True:
        action = np.random.choice(np.arange(nA), p=get_probs(Q[state], epsilon, nA)) \
                                    if state in Q else env.action_space.sample()
        next_state, reward, done, info = env.step(action)
        episode.append((state, action, reward))
        state = next_state
        if done:
            break
    return episode

def get_probs(Q_s, epsilon, nA):
    """ obtains the action probabilities corresponding to epsilon-greedy policy """
    policy_s = np.ones(nA) * epsilon / nA
    best_a = np.argmax(Q_s)
    policy_s[best_a] = 1 - epsilon + (epsilon / nA)
    return policy_s

def update_Q(env, episode, Q, alpha, gamma):
    """ updates the action-value function estimate using the most recent episode """
    states, actions, rewards = zip(*episode)
    # prepare for discounting
    discounts = np.array([gamma**i for i in range(len(rewards)+1)])
    for i, state in enumerate(states):
        old_Q = Q[state][actions[i]] 
        Q[state][actions[i]] = old_Q + alpha*(sum(rewards[i:]*discounts[:-(1+i)]) - old_Q)
    return Q
```

```python
def mc_control(env, num_episodes, alpha, gamma=1.0, eps_start=1.0, eps_decay=.99999, eps_min=0.05):
    nA = env.action_space.n
    # initialize empty dictionary of arrays
    Q = defaultdict(lambda: np.zeros(nA))
    epsilon = eps_start
    # loop over episodes
    for i_episode in range(1, num_episodes+1):
        # monitor progress
        if i_episode % 1000 == 0:
            print("\rEpisode {}/{}.".format(i_episode, num_episodes), end="")
            sys.stdout.flush()
        # set the value of epsilon
        epsilon = max(epsilon*eps_decay, eps_min)
        # generate an episode by following epsilon-greedy policy
        episode = generate_episode_from_Q(env, Q, epsilon, nA)
        # update the action-value function estimate using the episode
        Q = update_Q(env, episode, Q, alpha, gamma)
    # determine the policy corresponding to the final action-value function estimate
    policy = dict((k,np.argmax(v)) for k, v in Q.items())
    return policy, Q
```

Use the cell below to obtain the estimated optimal policy and action-value function. Note that you should fill in your own values for the num_episodes and alpha parameters.

```python
# obtain the estimated optimal policy and action-value function
policy, Q = mc_control(env, 500000, 0.02)
```

Next, we plot the corresponding state-value function.

```python
# obtain the corresponding state-value function
V = dict((k,np.max(v)) for k, v in Q.items())

# plot the state-value function
plot_blackjack_values(V)
```

Graph

Finally, we visualize the policy that is estimated to be optimal.

```python
# plot the policy
plot_policy(policy)
```

The true optimal policy  𝜋∗  can be found in Figure 5.2 of the textbook (and appears below). Compare your final estimate to the optimal policy - how close are you able to get? If you are not happy with the performance of your algorithm, take the time to tweak the decay rate of  𝜖 , change the value of  𝛼 , and/or run the algorithm for more episodes to attain better results.


Graph
