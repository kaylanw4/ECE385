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


module  color_mapper ( input        [9:0] DrawX, DrawY,
							  input 			[31:0] Data, 
							  input 			[31:0] CTRL_REG [16],
                       output logic [3:0]  Red, Green, Blue );
    
	logic shape_on;
	//logic shape2_on;
	logic[9:0] shape_x;
	logic[9:0] shape_y;
	logic[9:0] shape_size_x = 8;
	logic[9:0] shape_size_y = 16;

	assign shape_x = (DrawX[9:3] << 3);
	assign shape_y = (DrawY[9:4] << 4);
	/*logic[10:0] shape2_x = 312;
	logic[10:0] shape2_y = 300;
	logic[10:0] shape2_size_x = 8;
	logic[10:0] shape2_size_y = 16;*/

	logic [10:0] sprite_addr;
	logic [7:0] sprite_data;
	font_rom (.addr(sprite_addr), .data(sprite_data));


	logic[4:0] temp, temp1, temp2;

	assign temp = ({DrawX[3], 1'b1} << 3);
	assign temp1 = temp - 4;
	assign temp2 = ({DrawX[3], 1'b0} << 3);

	logic[10:0] hex_code;
	assign hex_code = (Data[temp +: 7] << 4);

	always_comb
	begin:Ball_on_proc
		shape_on = 1'b1;
		sprite_addr = (DrawY -shape_y + hex_code);
	end 
	 
	logic[3:0] fg_R, fg_G, fg_B; 
	logic[3:0] bg_R, bg_G, bg_B;
	logic[31:0] fg_RGB, bg_RGB;
	
	always_comb begin
		fg_RGB = CTRL_REG[Data[temp1 +: 4]];
		bg_RGB = CTRL_REG[Data[temp2 +: 4]];
	end
	//decode and assign foregound colors
	always_comb
	begin
	
		fg_R = fg_RGB[12:9];
		fg_G = fg_RGB[8:5];
		fg_B = fg_RGB[4:1];
		
		bg_R = bg_RGB[12:9];
		bg_G = bg_RGB[8:5];
		bg_B = bg_RGB[4:1];
		
	end
	// decode and assign background colors
	/*always_comb
	begin
		if (Data[temp2 - 1] == 1'b1)
			begin
				bg_R = bg_RGB[24:21];
				bg_G = bg_RGB[20:17];
				bg_B = bg_RGB[16:13];
			end
		else
			begin
				bg_R = bg_RGB[12:9];
				bg_G = bg_RGB[8:5];
				bg_B = bg_RGB[4:1];
			end
		
	end*/
	 
		 

   always_comb
    begin:RGB_Display
        if (sprite_data[7 - DrawX - shape_x] == 1'b1) 
			  begin 
					Red = fg_R;
					Green = fg_G;
					Blue = fg_B;
			  end       
        /*else if ((Data[temp - 1] == 1) && sprite_data[7 - DrawX - shape_x] == 1'b1)
			  begin 
					Red = CTRL_REG[12:9];
					Green = CTRL_REG[8:5];
					Blue = CTRL_REG[4:1];
			  end  
		  else if ((Data[temp - 1] == 1) && sprite_data[7 - DrawX - shape_x] == 1'b0)
			  begin 
					Red = CTRL_REG[24:21];
					Green = CTRL_REG[20:17];
					Blue = CTRL_REG[16:13];
			  end 	*/	  
		  else
			  begin 
					Red = bg_R;
					Green = bg_G;
					Blue = bg_B;
			  end 
    end 
    
endmodule
