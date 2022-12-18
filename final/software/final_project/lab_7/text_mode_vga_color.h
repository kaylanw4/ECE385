/*
 *  text_mode_vga.h
 *	Minimal driver for text mode VGA support, ECE 385 Summer 2021 Lab 6
 *  You may wish to extend this driver for your final project/extra credit project
 * 
 *  Created on: Jul 17, 2021
 *      Author: zuofu
 */

#ifndef TEXT_MODE_VGA_COLOR_H_
#define TEXT_MODE_VGA_COLOR_H_

#define COLUMNS 80
#define ROWS 30

#include <system.h>
#include <alt_types.h>


/*struct TEXT_VGA_STRUCT {

	alt_u16 VRAM [16]; //Week 2 - extended VRAM
	//modify this by adding const bytes to skip to palette, or manually compute palette
	const alt_u16 UNUSED [16];
};*/



//you may have to change this line depending on your platform designer
//static volatile struct TEXT_VGA_STRUCT* vga_ctrl = VGA_TEXT_MODE_CONTROLLER_0_BASE;


void start();
void gridClr();

int moveLeft();
int moveRight();
int moveDown();
int moveUp();
int moveLeftNew();
void spawnTile();

int legalMoveCheck();
int winCheck();


#endif /* TEXT_MODE_VGA_COLOR_H_ */
