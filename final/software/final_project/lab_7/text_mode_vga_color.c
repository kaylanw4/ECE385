/*
 * text_mode_vga_color.c
 * Minimal driver for text mode VGA support
 * This is for Week 2, with color support
 *
 *  Created on: Oct 25, 2021
 *      Author: zuofu
 */

#include <system.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alt_types.h>
#include "text_mode_vga_color.h"


void gridClr(int* grid)
{
	int i, j;

	for (i = 0; i < 4 ; i++){
		for (j = 0; j < 4 ; j++)
		{
			*(grid +i*4+j) = 0;

		}
	}
}

void start(int* grid){
	//int i, j;
	gridClr(grid);

	int r1 = rand() %15;


	*(grid+r1) = 2;

	//printf("*(grid + 1*4+2) = %d \n", *(grid+1*4+2));

	/*for (i = 0; i < 4 ; i++){
		for (j = 0; j < 4; j++){
			printf("grid[%d] = %d \n", i*4+j, *(grid+i*4+j));
		}

	}*/

}



int moveLeft(int* grid)
{
	// A
	int j, r, c;
	int change = 0; //tracks changes within the game
	int edge = 0; //tracks if the row/col variables are within the scope (boundary)
	for (r = 0; r < 4; r++) {
		edge = -1;
		for (c = 0; c < 4; c++) {
			if (*(grid + r*4+c) != 0) //if current cell isn't empty
			{
				for(j = 0; j < c; j++) {
					if (*(grid + r*4+j) == 0) break;
				}
				if (j < c) {
					*(grid + r*4+j) = *(grid + r*4+c);
					*(grid + r*4+c) = 0;
					change = 1;
				}
				if (j-1 != edge) {
					if (*(grid + r*4+(j-1)) == *(grid + r*4+j)) {
						*(grid + r*4+(j-1)) = 2 * *(grid + r*4+j);
						*(grid + r*4+j) = 0;
						//cur_game->score += 2 * *(grid + r*4+j);
						change = 1;
						edge = j-1;
					}
				}
			}
		}
	}
	if (change == 1) {
		return 1;
	}
	return 0;

}

int moveRight(int* grid)
{
/*
	 int i, j, k;
	 int change;
	    for (i = 0; i < 4; i++)
	    {
	        for (j = 3; j > 0; j--)
	        {
	            // Move all non-zero elements to the rightmost position
	            if (*(grid + i*4+j) == 0)
	            {
	                for (k = j - 1; k >= 0; k--)
	                {
	                    if (*(grid + i*4+k) != 0)
	                    {
	                        *(grid + i*4+j) = *(grid + i*4+k);
	                        *(grid + i*4+k) = 0;
	                        change = 1;
	                        break;
	                    }
	                }
	            }
	        }

	        for (j = 3; j > 0; j--)
	        {
	            // Combine adjacent elements if they are equal
	            if (*(grid + i*4+j) != 0 && *(grid + i*4+j) == *(grid + i*4+(j-1)))
	            {
	                *(grid + i*4+j) *= 2;
	                *(grid + i*4+(j-1)) = 0;
	                change = 1;

	                // Move all elements to the rightmost position again
	                for (k = j - 1; k >= 0; k--)
	                {
	                    if (*(grid + i*4+k) != 0)
	                    {
	                        *(grid + i*4+(j-1)) = *(grid + i*4+k);
	                        *(grid + i*4+k) = 0;
	                        change = 1;
	                    }
	                }
	            }
	        }
	    }*/
	int j, r, c;
	int change = 0; //tracks changes within the game
	int edge = 0; //tracks if the row/col variables are within the scope (boundary)
	for (r = 0; r < 4; r++) {
		edge = -1;
		for (c = 3; c >= 0; c--) {
			if (*(grid + r*4+c) != 0) //if current cell isn't empty
			{
				for(j = 3; j > c; j--) {
					if (*(grid + r*4+j) == 0) break;
				}
				if (j > c) {
					*(grid + r*4+j) = *(grid + r*4+c);
					*(grid + r*4+c) = 0;
					change = 1;
				}
				if (j+1 != edge) {
					if (*(grid + r*4+(j+1)) == *(grid + r*4+j)) {
						*(grid + r*4+(j+1)) = 2 * *(grid + r*4+j);
						*(grid + r*4+j) = 0;
						//cur_game->score += 2 * *(grid + r*4+j);
						change = 1;
						edge = j+1;
					}
				}
			}
		}
	}
	spawnTile(grid);
	if (change == 1) return 1;
	return 0;

}

int moveDown(int* grid)
{
	int i, r, c;
	int change = 0; //tracks changes within the game
	int edge = 0; //tracks if the row/col variables are within the scope (boundary)
	for (c = 0; c < 4; c++) {
		edge = -1;
		for (r = 3; r >= 0; r--) {
			if (*(grid + r*4+c) != 0) //if current cell isn't empty
			{
				for(i = 3; i > r; i--) {
					if (*(grid + i*4+c) == 0) break;
				}
				if (i > r) {
					*(grid + i*4+c) = *(grid + r*4+c);
					*(grid + r*4+c) = 0;
					change = 1;
				}
				if (i+1 != edge) {
					if (*(grid + (i+1)*4+c) == *(grid + i*4+c)) {
						*(grid + (i+1)*4+c) = 2 * *(grid + i*4+c);
						*(grid + i*4+c) = 0;
						//cur_game->score += 2 * *(grid + r*4+j);
						change = 1;
						edge = i+1;
					}
				}
			}
		}
	}
	spawnTile(grid);
	if (change == 1) {
		return 1;
	}
	return 0;
}

int moveUp(int* grid)
{
	int i, r, c;
	int change = 0; //tracks changes within the game
	int edge = 0; //tracks if the row/col variables are within the scope (boundary)
	for (c = 0; c < 4; c++) {
		edge = -1;
		for (r = 0; r < 4; r++) {
			if (*(grid + r*4+c) != 0) //if current cell isn't empty
			{
				for(i = 0; i < r; i++) {
					if (*(grid + i*4+c) == 0) break;
				}
				if (i < r) {
					*(grid + i*4+c) = *(grid + r*4+c);
					*(grid + r*4+c) = 0;
					change = 1;
				}
				if (i-1 != edge) {
					if (*(grid + (i-1)*4+c) == *(grid + i*4+c)) {
						*(grid + (i-1)*4+c) = 2 * *(grid + i*4+c);
						*(grid + i*4+c) = 0;
						//cur_game->score += 2 * *(grid + r*4+j);
						change = 1;
						edge = i-1;
					}
				}
			}
		}
	}
	spawnTile(grid);
	if (change == 1) return 1;
	return 0;
}

int moveLeftNew(int* grid){
	int j, r, c;
	int change = 0; //tracks changes within the game
	int edge = 0; //tracks if the row/col variables are within the scope (boundary)
	for (r = 0; r < 4; r++) {
		edge = -1;
		for (c = 0; c < 4; c++) {
			if (*(grid + r*4+c) != 0) //if current cell isn't empty
			{
				for(j = 0; j < c; j++) {
					if (*(grid + r*4+j) == 0) break;
				}
				if (j < c) {
					*(grid + r*4+j) = *(grid + r*4+c);
					*(grid + r*4+c) = 0;
					change = 1;
				}
				if (j-1 != edge) {
					if (*(grid + r*4+(j-1)) == *(grid + r*4+j)) {
						*(grid + r*4+(j-1)) = 2 * *(grid + r*4+j);
						*(grid + r*4+j) = 0;
						//cur_game->score += 2 * *(grid + r*4+j);
						change = 1;
						edge = j-1;
					}
				}
			}
		}
	}
	spawnTile(grid);
	if (change == 1) {
		return 1;
	}
	return 0;
}


void spawnTile(int* grid)
{
  // First, we will create a list of all of the empty tiles on the grid
  int empty_tiles[16][2];
  int num_empty = 0;

  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      if (*(grid + i*4+j) == 0)
      {
        empty_tiles[num_empty][0] = i;
        empty_tiles[num_empty][1] = j;
        num_empty++;
      }
    }
  }

  // If there are no empty tiles, we cannot spawn a new tile
  if (num_empty == 0)
  {
    return;
  }

  // Next, we will randomly choose one of the empty tiles to spawn the new tile on
  int index = rand() % num_empty;
  int row = empty_tiles[index][0];
  int col = empty_tiles[index][1];

  // Finally, we will randomly choose the value of the new tile (either 2 or 4) and spawn it on the chosen empty tile
  int value = (rand() % 100);
  if (value < 10){
	  *(grid + row*4+col) = 4;
  }	else {
	  *(grid + row*4+col) = 2;
  }

}


int legalMoveCheck(int* grid)
{
	int i, j;
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			if(*(grid + i*4+j) == 0) return 1;
			}
		}
	for (i = 0; i < 4; i++) {
			for (j = 1; j < 4; j++) {
				if(*(grid + i*4+j) == *(grid + i*4+(j-1))) return 1;
			}
		}
	for (j = 0; j < 4; j++) {
			for (i = 1; i < 4; i++) {
				if(*(grid + i*4+j) == *(grid + (i-1)*4+j)) return 1;
			}
		}
	return 0;

}

int winCheck(int* grid){
	int i, j;
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			if (*(grid + i*4+j) >= 250) return 1;
		}
	}
	return 0;
}




