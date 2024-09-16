# Alien Catcher

Alien Catcher is a simple but exciting game where the player catches as many falling aliens (represented by viruses) as possible within a limited time. The challenge is to avoid falling bombs that reduce your score, while collecting diamonds that freeze time and give you an edge to collect more aliens.

## Game Details

- **Objective**: Catch falling aliens to gain points.
- **Sprites**: Viruses for aliens, bombs as obstacles, and diamonds for power-ups.
- **Timer**: The game starts with a countdown timer that runs out after 60 seconds.
- **Power-ups**: Collect diamonds to freeze time for 3 seconds.

## Features

- **Scoring**:
  - Gain 1 point for catching each alien (virus).
  - Lose 10 points if you hit a bomb.
- **Restart Game**: When the timer ends, a button will appear to restart the game.
- **Visual Feedback**: Colors change as feedback when bombs are hit or diamonds are collected.

## Installation

To run the game, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/alien-catcher.git
    ```

2. Install [Love2D](https://love2d.org/).

3. Run the game:
    ```bash
    love .
    ```

## Controls

- **Mouse Click**: Catch aliens by clicking on them.
- **Bombs**: Avoid clicking on bombs or you will lose 10 points.
- **Diamonds**: Clicking on diamonds freezes time for a 3 seconds.
