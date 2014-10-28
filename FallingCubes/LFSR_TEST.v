`timescale 1ns / 1ps


module LFSR_TEST;

	localparam T = 20;
	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [8:0] out;

	// Instantiate the Unit Under Test (UUT)
	LFSR uut (
		.clk(clk), 
		.reset(reset), 
		.out(out)
	);
	
	always
		begin
			clk = 1;
			#(T/2);
			clk = 0;
			#(T/2);
		end

	initial begin
	
		repeat(2) @(posedge clk);
		reset = 1;
		@(posedge clk);
		reset = 0;

	end
      
endmodule

