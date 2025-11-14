# Guessing Game on DE1-SoC

Alvaro Balbin (ab4647)

## Overview
This project implements a 4-bit guessing game on the DE1-SoC FPGA using SystemVerilog.  
A secret value is stored from switches, a separate guess is entered, and the system compares the two, giving feedback through LEDs and HEX displays. On a correct guess, an LED animation is shown.

## Features
- 4-bit secret value stored using KEY0  
- 4-bit live guess using SW[7:4]  
- Comparison outputs:  
  - LEDR0: equal  
  - LEDR1: guess greater than secret  
  - LEDR2: guess less than secret  
- Reveal mode (KEY1) to show the stored secret on HEX1  
- HEX0 always displays the current guess in hex  
- Win animation across LEDR[9:3]

## Hardware Usage
- SW[3:0]: secret  
- SW[7:4]: guess  
- KEY0: store secret on falling edge  
- KEY1: toggle reveal mode  
- HEX0: guess  
- HEX1: secret (only when revealed)  
- LEDR[0:2]: comparison outputs  
- LEDR[9:3]: animated win pattern

## How It Works
1. Set SW[3:0] and press KEY0 to store the secret.  
2. Change SW[7:4] to make guesses.  
3. LEDs indicate whether the guess is higher, lower, or equal.  
4. Press KEY1 to reveal or hide the stored secret on HEX1.  
5. If the guess matches the secret, LEDR[9:3] shows a timed animation.

   
## Demonstration

Click the thumbnail below to watch the demonstration video on YouTube:

<a href="https://youtu.be/tVx_ap2fxnU">
  <img src="https://i.ytimg.com/vi/tVx_ap2fxnU/hqdefault.jpg" width="800">
</a>


## Credits
All SystemVerilog code, design work, debugging, and hardware implementation were created by Alvaro Balbin.  
ChatGPT assisted only with writing and formatting this README.  
The project idea and implementation details are entirely original.
