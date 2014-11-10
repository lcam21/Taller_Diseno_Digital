`timescale 1ns / 1ps

/*
modulo que genera un pulso cada cierta cantidad de 
ciclos de reloj, es decir puede verse como un reloj
con una frecuencia mas baja. Inicialmente esta configurado
para generar un pulso cada 10ms. Puede modificarse
sobreescribiendo los parametros segun la frecuencia que se
requiera
*/
module retardadorReloj(
    input clk,
    output reg clk_retardado
    );
	 
	 /*
		constante para determinar la cantidad de ciclos
		de reloj necesarios para simular una cierta cantidad de 
		tiempo. Predeterminadamente se definen 250mil, con este
		valor, podemos simular un reloj de 10ms de periodo, 5ms en 
		alto y 5ms en bajo
	 */
	 parameter CICLOS_PARA_MEDIO_PERIODO = 250000;
	 /*
		constante para definir la variable que guardara el conteo.
		Predefinidamente se ocupan 25 bits para almacenar 250mil 
	 */
	 parameter N = 25;
	 
	 reg [N-1:0] registroConteos;
	 
	 always @(posedge clk) begin
		if(registroConteos != CICLOS_PARA_MEDIO_PERIODO) begin
			registroConteos <= registroConteos + 1;
			clk_retardado <= 0;
		end
		else begin
			registroConteos <= 0;
			clk_retardado <= 1;
		end
	 end
endmodule
