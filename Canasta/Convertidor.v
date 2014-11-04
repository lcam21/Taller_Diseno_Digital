`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:45 10/30/2014 
// Design Name: 
// Module Name:    Convertidor 
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
module Convertidor(
		input clk,
		input [7:0] datoEntrada,
		output reg [9:0] datoSalida
    );

	always @* begin 
		datoSalida = datoEntrada *5/2;
	end
	
endmodule
