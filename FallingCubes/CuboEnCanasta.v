`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:51:54 10/28/2014 
// Design Name: 
// Module Name:    CuboEnCanasta 
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
module CuboEnCanasta(
	input clk,
	input posicion_x_cubo,//esquina inferior izquierda
	input posicion_y_cubo,
	input posicion_x_canasta,//esquina superior izquierda
	output entro_en_canasta
    );
	 
	 localparam ancho_cubo = 64;
	 localparam ancho_canasta = 96;
	 localparam posicion_y_canasta = 436;
	 
	 reg dentro_de_canasta;
	 
	 
	 always@(posedge clk)begin 
		if((posicion_x_canasta <= posicion_x_cubo ) &&
			((posicion_x_cubo + ancho_cubo)<=posicion_x_canasta + ancho_canasta) &&
			(posicion_y_canasta <= posicion_y_cubo))begin 
			dentro_de_canasta <= 1;
		end
		else begin
			dentro_de_canasta <= 0;
		end
	 end
	 
	 assign entro_en_canasta = dentro_de_canasta;


endmodule

