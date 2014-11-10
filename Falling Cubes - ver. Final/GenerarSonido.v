`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:09 11/06/2014 
// Design Name: 
// Module Name:    GenerarSonido 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module GenerarSonido(
	input clk,
	input reset,
	input wire pulsoSonar,
	input wire finJuego,
	output [3:0] JA		// Digilent socket JA - I2S DAC
    );
	 
	// Clock divider
	reg clk2;
	always @(posedge clk)
		clk2 <= ~clk2;
	
	
	// Instance of I2S test module
	i2s_tst
		ui2stst(.clk(clk2), .reset(reset), //este reset no se ocupa, ahorita lo quito
			.btn(pulsoSonar),
			.fin(finJuego),
			.mclk(JA[0]),
			.sclk(JA[2]),
			.lrck(JA[1]),
			.sdout(JA[3])
		);	 
endmodule
