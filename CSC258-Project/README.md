# CSC258-Project - Whack-A-LED

## Description
-> This is a game where users attempt to "whack" a mole when the mole appears on the screen. When SW[0] is turned to 1, the game starts. 
Randomly, one of three moles will appear on screen (left, center, right). You must click the corresponding keyboard button before the
mole disappears to get the point. Left arrow button for left mole. Down arrow for center mole. Right arrow button for right mole. 
This process is repeated. Once a certain score is reached the moles will appear and disappear much faster. The goal is to get as many 
points as possible. This uses keyboard and VGA. 

## Top-Level Module
project.v

## project design
This project is a game. The game will fire LED¡¯s (Now it is a box on the screen) at random times each level and the user must click the corresponding button to ¡°whack the LED¡±. The game will feature a fixed speed and a fixed number of moles. The goal is to whack as many LED¡¯s as you can. If you take to long, then you will not receive the point. Your score is then displayed on a HEX-display and represents the amount of LED¡¯s you ¡°whacked¡±.

### modules created by us
```
paint: draws a mole (a 4*4 box) at the indicated coordinate
randomnumber: gets a random number between 0 and 7
ratecounter: to count a certain amount so mole only flashes for a certain amount of time
display_controller: turns on or off mole depending on ratecounter signal
player: determines player score
milestone3: top level module that calls everything
levelcontroller: changes ratecounter rate depending on a players score
key: initializes the keyboard files and checks whether a user has clicked the required keys. 
seven_segment_decoder: to display score to HEX
```

### modules not created by us
```
oneshot
VGA
Most of the keyboard module
```

### external resources
```
VGA files provided by professor
keyboard files from: John Loomis website - http://www.johnloomis.org/digitallab/ps2lab1/ps2lab1.html
```