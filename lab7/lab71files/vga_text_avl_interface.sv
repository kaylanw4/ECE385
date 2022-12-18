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
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] PALETTE [16]; // Registers
//put other local variables here
logic [9:0] drawxsig, drawysig;
logic [3:0] Red, Blue, Green;
logic blank, pixel_clk;
logic [11:0] temp1;
logic [9:0] avl_addr;
logic [31:0] temp2, temp3;
logic [3:0] PAL_ADDR;

assign PAL_ADDR = AVL_ADDR[3:0];


assign temp1 = ((drawysig[9:4] * 40) + drawxsig[9:4]);

//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller vga (.*, .Clk(CLK), .Reset(RESET), .hs(hs), .vs(vs), .pixel_clk(pixel_clk), .blank(blank), .DrawX(drawxsig), .DrawY(drawysig), .sync());	

color_mapper cm (.*, .DrawX(drawxsig), .DrawY(drawysig), .Data(temp2), .CTRL_REG(PALETTE), .Red(Red), .Green(Green), .Blue(Blue));


// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
/*always_ff @(posedge CLK) begin
	if(AVL_CS)
		begin
			if(AVL_WRITE)
				case (AVL_BYTE_EN) 
					4b'1111: LOCAL_REG[AVL_ADDR] <= AVL_WRITEDATA;
					4b'1100: [31:16]LOCAL_REG[AVL_ADDR] <= [31:16]AVL_WRITEDATA;
					4b'0011: [15:0]LOCAL_REG[AVL_ADDR] <= [15:0]AVL_WRITEDATA;
					4b'1000: [31:24]LOCAL_REG[AVL_ADDR] <= [31:24]AVL_WRITEDATA;
					4b'0100: [23:16]LOCAL_REG[AVL_ADDR] <= [23:16]AVL_WRITEDATA;
					4b'0010: [15:8]LOCAL_REG[AVL_ADDR] <= [15:0]AVL_WRITEDATA;
					4b'0001: [7:0]LOCAL_REG[AVL_ADDR] <= [7:0]AVL_WRITEDATA;
					default: ;
				endcase
			else if(AVL_READ)
				AVL_READDATA <= LOCAL_REG[AVL_ADDR];
		end
end*/
ram ram0 (.address_a(AVL_ADDR), .address_b(temp1), .clock(CLK), .data_a(AVL_WRITEDATA), .data_b(), 
			 .rden_a(AVL_READ), .rden_b(pixel_clk), .wren_a(AVL_WRITE), .wren_b(), .q_a(temp3), .q_b(temp2),  .byteena_a(AVL_BYTE_EN));

always_ff @ (posedge CLK)
begin
	if ((AVL_ADDR[11] == 1) && (AVL_ADDR[10:4] == 0)) // not sure if the last part is necessary
		PALETTE[PAL_ADDR] <= AVL_WRITEDATA;
end


//handle drawing (may either be combinational or sequential - or both).
always_ff @ (posedge pixel_clk)
begin
	if (blank == 1'b1)
		begin
			red <= Red;
			blue <= Blue;
			green <= Green;
		end
	else
		begin
			red <= 4'h0;
			blue <= 4'h0;
			green <= 4'h0;
		end
end	
	/*begin
		red <= 4'h0;
		blue <= 4'h0;
		green <= 4'h0;
	end*/

	

endmodule

