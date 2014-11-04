`timescale 1ns / 1ps

module deco_configuracion_cubos(
    input [2:0] tipo_cubo,
    output reg [7:0] color,
    output reg [1:0] velocidad
    );
	 

/*
0-2 es color rojo, el mas lento, vel = 1
3-4 es color verde, el medio, vel = 2
5-6 es color azul, el rapido vel = 3
*/	 
	 
	always @(*)
		begin
			case(tipo_cubo)
				0:
					begin
						velocidad = 2'b01;
						color = 8'b00000111;
					end
				1:
					begin
						velocidad = 2'b01;
						color = 8'b00000111;
					end
				2:
					begin
						velocidad = 2'b01;
						color = 8'b00000111;
					end
				3:
					begin
						velocidad = 2'b10;
						color = 8'b00111000;
					end
				4:
					begin
						velocidad = 2'b10;
						color = 8'b00111000;
					end
				5:
					begin
						velocidad = 2'b11;
						color = 8'b11000000;
					end
				6:
					begin
						velocidad = 2'b11;
						color = 8'b11000000;
					end
				default:
					begin
						color = 8'b0;
						velocidad = 2'b0;
					end
			endcase
		end


endmodule
