`timescale 1ns / 1ps


/*
modulo que en cada ciclo de reloj cambia
el valor de la salida. Se utiliza para hacer el
cambio entre los 4 7segmentos. 
00 anodo0
01 anodo1
10 anodo2
11	anodo3
Cuando llega a 11, vuelve a 00
*/

module rotadorDisplays(
    input clk,
	 input pulsoRotar,
    output [1:0] displayActual
    );
	 
	reg [1:0] registroSalida;
	
	always @(posedge clk) begin
		if(pulsoRotar)
			registroSalida <= registroSalida + 1;		
	end
	
	assign displayActual = registroSalida;

endmodule
