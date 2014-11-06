`timescale 1ns / 1ps
/*
	modulo que se activa cuando el pulso de entrada cambia de 
	0 a 1. Cuando el pulso es 1 se mantiene de esa forma durante
	medio segundo, luego vuelve a cero.
*/
module continuadorPeriodo(
    input clk,	 
	 input reset,
    input pulsoEntrada,
    output pulsoSalida
    );

	//cantidad de ciclo de reloj de 10ns para alcanzar medio segundo
	parameter CICLOS_PARA_TIEMPO = 25_000_000;
	//cantidad de bits necesarios para llevar el conteo
	parameter N_BITS = 25;
	reg [N_BITS - 1:0] conteoActual;
	reg pulsoParcial;
	
	initial begin
		//se define inicialmente el pulso de salida igual a cero
		pulsoParcial = 0;
	end
	
	always @(posedge clk) begin
	
		if(reset) begin
			conteoActual = 0;
			pulsoParcial = 0;
		end
	
		if(pulsoEntrada) begin
			conteoActual = 0;			
			pulsoParcial = 1;
		end		
		
		if(pulsoParcial)
			conteoActual = conteoActual + 1;		
		
		if(conteoActual == CICLOS_PARA_TIEMPO)
			pulsoParcial = 0;			
	end
	
	assign pulsoSalida = pulsoParcial;

endmodule
