/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
//`define NUM_REGS 601 //80*30 characters / 4 characters per register
//`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [4:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [15:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [15:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

//put other local variables here
logic [9:0] drawxsig, drawysig;
logic [3:0] Red, Blue, Green;
logic blank, pixel_clk;
logic [15:0] temp;
logic [15:0] grid [16];

logic [3:0] grid_addr;

assign grid_addr = AVL_ADDR[3:0];
//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller vga (.*, .Clk(CLK), .Reset(RESET), .hs(hs), .vs(vs), .pixel_clk(pixel_clk), 
						  .blank(blank), .DrawX(drawxsig), .DrawY(drawysig), .sync());	

game_image_mapper mapper (.*, .DrawX(drawxsig), .DrawY(drawysig), .vga_clk(pixel_clk), .vs(vs), 
								  .blank(blank), .grid(grid), .red(Red), .green(Green), .blue(Blue));

always_ff @ (posedge pixel_clk)
begin	
	if (AVL_WRITE)
		grid[grid_addr] <= AVL_WRITEDATA;
end


always_ff @ (posedge pixel_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= Red[3:0];
		green <= Green[3:0];
		blue <= Blue[3:0];
	end
end



endmodule 
