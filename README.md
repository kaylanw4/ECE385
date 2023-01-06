# ECE385

Contains labs and final project for ECE 385 @ UIUC FA 2022

Final Project Video:

[![IMAGE ALT TEXT](http://img.youtube.com/vi/ImR0m11yOk4/0.jpg)](http://www.youtube.com/watch?v=ImR0m11yOk4 "Video Title")

Notes for final project:
* The game is designed to be played on the MAX10 FPGA with the USB shield (both provided by the University of Illinois)
  * VGA display and sprites were programmed in System Verilog using Intel Quartus Prime software, game logic and I/O (usb keyboard input) were handled in C using Eclipse for NIOS II, and software and hardware were integrated using the platform designer in Quartus
* Keyboard inputs/controls 
  * R resets the game board (regardless if you have already won or lost)
  * Enter starts a new game 
  * WASD for up, down, left, right 
  * Video shows the game finishing at 256 for the sake of being concise given that it would be trivial to copy and paste code to extend the game to the full 2048

