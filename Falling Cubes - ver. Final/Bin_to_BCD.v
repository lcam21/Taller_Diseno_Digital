`timescale 1ns / 1ps
/*
	modulo que obtiene el BCD de un numero.
	sirve para 999.
*/
module Bin_to_BCD(
	input [9:0] numBin,
	output reg [3:0] centenas,
	output reg [3:0] decenas,
	output reg [3:0] unidades
);

	integer i;
	always @(numBin) begin
		centenas = 4'd0;
		decenas = 4'd0;
		unidades = 4'd0;
		
		for(i = 9; i >= 0; i = i -1) begin
			if(centenas >= 5)
				centenas = centenas + 3;
			if(decenas >= 5)
				decenas = decenas + 3;
			if(unidades >= 5)
				unidades = unidades + 3;
				
			centenas = centenas << 1;
			centenas[0] = decenas[3];
			decenas = decenas << 1;
			decenas[0] = unidades[3];
			unidades = unidades << 1;
			unidades[0] = numBin[i];
		end
		
		
	end
endmodule
