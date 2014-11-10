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
	 input pulsoFinalizar,
    output pulsoSalida,
	 output pulsoSonidoSalida,
	 output pulsoFinJuego
    );

	//cantidad de ciclo de reloj de 10ns para alcanzar medio segundo
	parameter CICLOS_PARA_TIEMPO = 25_000_000;
	//cantidad de bits necesarios para llevar el conteo
	parameter N_BITS = 25;
	reg [N_BITS - 1:0] conteoActual;
	reg pulsoParcial;
	reg pulsoSonidoParcial;
	reg pulsoFinParcial;
	
	initial begin
		//se define inicialmente el pulso de salida igual a cero
		pulsoParcial = 0;
		pulsoSonidoParcial = 0;
		pulsoFinParcial = 0;
	end
	
	always @(posedge clk) begin
	
		if(reset) begin
			conteoActual = 0;
			pulsoParcial = 0;
			pulsoSonidoParcial = 0;
			pulsoFinParcial = 0;
		end
	
		if(pulsoEntrada) begin
			conteoActual = 0;			
			pulsoParcial = 1;
			pulsoSonidoParcial = 1;
		end
		
		if(pulsoFinalizar)begin
			conteoActual = 0;	
			pulsoFinParcial = 1;
		end
		
		if(pulsoParcial || pulsoFinParcial)
			conteoActual = conteoActual + 1;		
		
		if(conteoActual == CICLOS_PARA_TIEMPO)begin
			pulsoParcial = 0;	
			pulsoSonidoParcial = 0;
			pulsoFinParcial = 0;			
		end
	end
	
	assign pulsoSalida = pulsoParcial;
	assign pulsoSonidoSalida = pulsoSonidoParcial;
	assign pulsoFinJuego = pulsoFinParcial;

endmodule
