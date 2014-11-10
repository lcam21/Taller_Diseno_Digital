`timescale 1ns / 1ps

module registro_puntaje(
    input clk,
    input reset,
	 input start,
	 input [1:0] puntos_c1,
	 input [1:0] puntos_c2,
	 input [1:0] puntos_c3,
	 input [1:0] puntos_c4,
	 input [1:0] puntos_c5,
	 output reg [9:0] puntaje,
    output reg pulso_sonido
    );	

	always @(posedge clk)
		begin
			if(reset || start)
				begin
					puntaje <= 0;
					pulso_sonido <= 0;
				end
			else
				begin
					if(puntos_c1 != 0)
						begin
							pulso_sonido <= 1;
							puntaje <= puntaje + puntos_c1;
						end
					else if(puntos_c2 != 0)
						begin
							pulso_sonido <= 1;
							puntaje <= puntaje + puntos_c2;
						end
					else if(puntos_c3 != 0)
						begin
							pulso_sonido <= 1;
							puntaje <= puntaje + puntos_c3;
						end
					else if(puntos_c4 != 0)
						begin
							pulso_sonido <= 1;
							puntaje <= puntaje + puntos_c4;
						end
					else if(puntos_c5 != 0)
						begin
							pulso_sonido <= 1;
							puntaje <= puntaje + puntos_c5;
						end					
					else
						begin
							pulso_sonido <= 0;
							puntaje <= puntaje;
						end
				end
		end


endmodule
