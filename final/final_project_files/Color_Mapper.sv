//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [10:0][15:0][9:0] BallX, 
							  input 			[10:0][15:0][9:0] BallY, 
							  input			[9:0] DrawX, DrawY,
							  input 			[3:0] palette_red[14], 
							  input 			[3:0] palette_green[14], 
							  input			[3:0] palette_blue[14],
							  input 			[1:0] win_lose,
                       output logic [3:0]  Red, Green, Blue );
    
logic [12:0]ball_on;
int SizeX, SizeY, SizeX_win_lose, SizeY_win_lose;
assign SizeX = 48;
assign SizeY = 64;
assign SizeX_win_lose = 300;
assign SizeY_win_lose = 100;
 
always_comb
    begin:Ball_on_proc
	 ball_on = 0;
		for (int i = 0; i < 16; i++) begin
			for (int j = 0; j < 11; j++) begin
			  if ((DrawX >= BallX[j][i]) && (DrawX <= (BallX[j][i] + SizeX)) && 
					(DrawY >= BallY[j][i]) && (DrawY <= (BallY[j][i] + SizeY)))
					ball_on[j] = 1'b1;
				
			end
		end
	if (win_lose == 1) begin
		if ((DrawX >= 170) && (DrawX <= (170 + SizeX_win_lose)) && 
			 (DrawY >= 190) && (DrawY <= (190 + SizeY_win_lose)))
			 ball_on[11] = 1'b1;
	end
	else if (win_lose == 2) begin
		if ((DrawX >= 170) && (DrawX <= (170 + SizeX_win_lose)) && 
			 (DrawY >= 190) && (DrawY <= (190 + SizeY_win_lose)))
			 ball_on[12] = 1'b1;
	end
	

end	




		
 always_comb
 begin:RGB_Display
		Red = palette_red[0]; 
		Green = palette_green[0];
		Blue = palette_blue[0];
		for (int i = 0; i < 13; i++) begin
		  if ((ball_on[i] == 1'b1)) 
		  begin 
				Red = palette_red[i+1];
				Green = palette_green[i+1];
				Blue = palette_blue[i+1];
		  end   
		end
			 
end 


    
endmodule


/*else if ((DrawX >= BallX[0][1]) && (DrawX <= (BallX[0][1] + Size)) && 
				(DrawY >= BallY[0][1]) && (DrawY <= (BallY[0][1] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][2]) && (DrawX <= (BallX[0][2] + Size)) && 
				(DrawY >= BallY[0][2]) && (DrawY <= (BallY[0][2] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][3]) && (DrawX <= (BallX[0][3] + Size)) && 
				(DrawY >= BallY[0][3]) && (DrawY <= (BallY[0][3] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][4]) && (DrawX <= (BallX[0][4] + Size)) && 
				(DrawY >= BallY[0][4]) && (DrawY <= (BallY[0][4] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][5]) && (DrawX <= (BallX[0][5] + Size)) && 
				(DrawY >= BallY[0][5]) && (DrawY <= (BallY[0][5] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][6]) && (DrawX <= (BallX[0][6] + Size)) && 
				(DrawY >= BallY[0][6]) && (DrawY <= (BallY[0][6] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][7]) && (DrawX <= (BallX[0][7] + Size)) && 
				(DrawY >= BallY[0][7]) && (DrawY <= (BallY[0][7] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][8]) && (DrawX <= (BallX[0][8] + Size)) && 
				(DrawY >= BallY[0][8]) && (DrawY <= (BallY[0][8] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][9]) && (DrawX <= (BallX[0][9] + Size)) && 
				(DrawY >= BallY[0][9]) && (DrawY <= (BallY[0][9] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][10]) && (DrawX <= (BallX[0][10] + Size)) && 
				(DrawY >= BallY[0][10]) && (DrawY <= (BallY[0][10] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][11]) && (DrawX <= (BallX[0][11] + Size)) && 
				(DrawY >= BallY[0][11]) && (DrawY <= (BallY[0][11] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][12]) && (DrawX <= (BallX[0][12] + Size)) && 
				(DrawY >= BallY[0][12]) && (DrawY <= (BallY[0][12] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][13]) && (DrawX <= (BallX[0][13] + Size)) && 
				(DrawY >= BallY[0][13]) && (DrawY <= (BallY[0][13] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][14]) && (DrawX <= (BallX[0][14] + Size)) && 
				(DrawY >= BallY[0][14]) && (DrawY <= (BallY[0][14] + Size)))
				ball_on[0] = 1'b1;
			else if ((DrawX >= BallX[0][15]) && (DrawX <= (BallX[0][15] + Size)) && 
				(DrawY >= BallY[0][15]) && (DrawY <= (BallY[0][15] + Size)))
				ball_on[0] = 1'b1;
				
		  else 
				ball_on[0] = 1'b0;
		

	end
	  
always_comb
    begin:Ball_on_proc_4
		  if ((DrawX >= BallX[1][0]) && (DrawX <= (BallX[1][0] + Size)) && 
				(DrawY >= BallY[1][0]) && (DrawY <= (BallY[1][0] + Size)))
				ball_on[1] = 1'b1;
		  else if ((DrawX >= BallX[1][1]) && (DrawX <= (BallX[1][1] + Size)) && 
				(DrawY >= BallY[1][1]) && (DrawY <= (BallY[1][1] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][2]) && (DrawX <= (BallX[1][2] + Size)) && 
				(DrawY >= BallY[1][2]) && (DrawY <= (BallY[1][2] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][3]) && (DrawX <= (BallX[1][3] + Size)) && 
				(DrawY >= BallY[1][3]) && (DrawY <= (BallY[1][3] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][4]) && (DrawX <= (BallX[1][4] + Size)) && 
				(DrawY >= BallY[1][4]) && (DrawY <= (BallY[1][4] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][5]) && (DrawX <= (BallX[1][5] + Size)) && 
				(DrawY >= BallY[1][5]) && (DrawY <= (BallY[1][5] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][6]) && (DrawX <= (BallX[1][6] + Size)) && 
				(DrawY >= BallY[1][6]) && (DrawY <= (BallY[1][6] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][7]) && (DrawX <= (BallX[1][7] + Size)) && 
				(DrawY >= BallY[1][7]) && (DrawY <= (BallY[1][7] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][8]) && (DrawX <= (BallX[1][8] + Size)) && 
				(DrawY >= BallY[1][8]) && (DrawY <= (BallY[1][8] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][9]) && (DrawX <= (BallX[1][9] + Size)) && 
				(DrawY >= BallY[1][9]) && (DrawY <= (BallY[1][9] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][10]) && (DrawX <= (BallX[1][10] + Size)) && 
				(DrawY >= BallY[1][10]) && (DrawY <= (BallY[1][10] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][11]) && (DrawX <= (BallX[1][11] + Size)) && 
				(DrawY >= BallY[1][11]) && (DrawY <= (BallY[1][11] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][12]) && (DrawX <= (BallX[1][12] + Size)) && 
				(DrawY >= BallY[1][12]) && (DrawY <= (BallY[1][12] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][13]) && (DrawX <= (BallX[1][13] + Size)) && 
				(DrawY >= BallY[1][13]) && (DrawY <= (BallY[1][13] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][14]) && (DrawX <= (BallX[1][14] + Size)) && 
				(DrawY >= BallY[1][14]) && (DrawY <= (BallY[1][14] + Size)))
				ball_on[1] = 1'b1;
			else if ((DrawX >= BallX[1][15]) && (DrawX <= (BallX[1][15] + Size)) && 
				(DrawY >= BallY[1][15]) && (DrawY <= (BallY[1][15] + Size)))
				ball_on[1] = 1'b1;
				
		  else 
				ball_on[1] = 1'b0;
end*/