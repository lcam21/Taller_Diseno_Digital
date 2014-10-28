`timescale 1ns / 1ps

module vga_sync_TEST;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);
	
	localparam T = 10;

	always
		begin
			clk = 1;
			#(T/2);
			clk = 0;
			#(T/2);
		end

	initial begin

		reset = 0;
		repeat (3) @(posedge clk);
		reset = 1;
		@(posedge clk);
		reset = 0;
	end
      
endmodule

