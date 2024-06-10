# Pandefense

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/assets/92650724/c6522945-8da6-43c0-a3d9-e649df1aed65" height="380">
</p>

### Short description
***Help the animals save the pandas from greedy humans. Build strong fortifications that will become a nightmare for your enemies. Face the lumberjacks, the medics, the bulldozers, and even the army as humanity becomes ever so obsessed with razing your home to the ground!
Discover all kinds of animal warriors and their towers, upgrade your base for passive bonuses, and defend the bamboo forest!***

_______________________________________________________________________________________________________________________________

Pandefense is a tower-defense 2.5D game written in a Godot engine. Its main aim is to stop the attacking mobs from reaching the panda asylum by building towers from which animals will attack the humans. The enemy comes in waves during and between which you can build towers, buy base upgrades for passive bonuses, or heal your base. 
The longer you defy humanity the better your score is.

_______________________________________________________________________________________________________________________________

### Details

At the beginning of the project, we created a plan for the implementation and divided the functionalities into three sections based on their importance:

* **MUST**
  * The main object of the game is a plane with a marked-out path for the mobs, places for the towers, and a base with a certain amount of health points ✅
  * The mobs only move on the path and don't attack towers, damaging only the base when they reach it ✅
  * The towers can be placed anywhere on the map besides on the path and the base ✅
  * The towers cost gold which is obtained by killing the mobs ✅
  * The mobs come in waves separated by a certain period and differentiating in the number of mobs - the game gets harder with time ✅
  * The player must be able to stop the game and resume it, see how much gold they have, and spend it on towers ✅
  * The towers are resided by animals that attack the mobs - it has to be visible and distinguishable
  * The score is counted with the killed mobs and displayed on the screen ✅
      
* **SHOULD**
  * The player should be able to input their nickname before the game begins and see it during the gameplay
  * There should be different types of towers differing in the animal that resides it, its range, damage, and cost ✅
  * There should be different types of mobs differing in their health points, the amount of damage they deal to the base and their movement speed ✅
  * The player can spend gold on passive bonuses, lasting all game, that help them in the game, ex. the base has more maximum HP, the bonus gives the player a passive income, the bonus strengthens some specific type of animal, etc.
  * Different types of mobs are valued differently in the gamescore ✅
    
* **COULD**
  * The graphics are of great quality - the game is pretty
  * The towers can be upgraded, ex. more DMG, lesser cost, etc.
  * The player can choose between a few maps before the game begins
  * The player can see their score on the leaderboard
  * The player can spend gold to heal the base throughout the game
  * The player can buy periodical bonuses that affect the game, ex. all towers deal more DMG, the mobs move slower etc.

*Note: If any of the objectives change, get deleted, or are added they will be archived here*

_______________________________________________________________________________________________________________________________

### Authors

The authors and their responsibilities:
* **Barbara Doncer** - game graphics
* **Nikodem Korohoda** - repository management & basic integration
* **Jędrzej Ziebura** - the roadmap and the logo

All the other tasks that weren't listed had been performed by all of the crew

_______________________________________________________________________________________________________________________________

### Technologies

* [Godot game engine](https://godotengine.org/)
* [Blender](https://www.blender.org/)

_______________________________________________________________________________________________________________________________

### Final results
At the beginning of the game, the start screen appears. To start the game, users need to press the "Start Game" button.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/start%20screen.png" height="250">
</p>


Once the game starts, the player's task is to defend pandas. This can be accomplished by strategically placing towers with animals that will attack the approaching enemies. Every enemy has its own HP. Once it reaches zero, it vanishes from the screen.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_start.png" height="250">
</p>


Each tower has its own price - the higher the price, the more effective its attack. In Pandefense, the tower with the lowest price and effectiveness is the monkey throwing bananas. Next is the penguin throwing fish, and the most effective is the bear throwing honey.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/towers.png" height="150">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/towers_cost.png" height="150">
</p>


Money is earned by killing enemies. The current amount is displayed at the top of the screen.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/money.png" height="250">
</p>


Waves can be triggered by pressing the "Spawn Wave" button. Each wave is progressively more difficult with more enemies appearing, moving faster and having more HP.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_start.png" height="180">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_middle.png" height="180">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_end.png" height="180">
</p>


The game ends in two scenarios: success, when a certain number of levels are completed or failure, if all the pandas are defeated and disappear from the screen.

<p align="center">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_won.png" height="200">
    <img src="https://github.com/Loloxon/Pandefense/blob/d5f53f97fb3106eebac56d619b6ea4c3fa10b316/images/game_over.png" height="200">
</p>
