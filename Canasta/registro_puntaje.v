`timescale 1ns / 1ps

module registro_puntaje(
    input clk,
    input reset,
    input [4:0] pulsos_cubos_canasta,
    output reg pulso_sonido
    );

	//reg [8:0] puntaje;

	always @(posedge clk)
		begin
			if(reset)
				begin
					//puntaje <= 0;
					pulso_sonido <= 0;
				end
			else
				begin
					if(pulsos_cubos_canasta != 0)
						pulso_sonido <= 1;
					else
						pulso_sonido <= 0;	
				end
		end


endmodule
