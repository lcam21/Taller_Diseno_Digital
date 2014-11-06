`timescale 1ns / 1ps

/*
decodificador para seleccionar un anodo para el 
7segmentos, la seleccion depende de la posicion
00 anodo0 activado => 1110
01 anodo1 activado => 1101
10 anodo2 activad0 => 1011
11	anodo3 activado => 0111
*/


module decoAnodosDisplay(
    input [1:0] posicion,
	 output reg punto,
    output reg [3:0] anodo	 
    );
	 
	always @(posicion) begin
		punto <= 1;
		case(posicion)
			0:
				anodo = 4'b1110;
			1:
				anodo = 4'b1101;
			2:
				anodo = 4'b1011;
			3:
				anodo = 4'b0111;
		endcase
	end	
endmodule
