`timescale 1ns / 1ps

module seleccionador_color_cubo(    
	 input [4:0]estado_cubos,
    input [7:0] color_cubo_1,
    input [7:0] color_cubo_2,
    input [7:0] color_cubo_3,
    input [7:0] color_cubo_4,
    input [7:0] color_cubo_5,
    output reg [7:0] color_seleccionado
    );
	 

	always @(*)
		begin
			case(estado_cubos)
				0:
					begin
						color_seleccionado = 8'b11111111;
					end
				1:
					begin
						color_seleccionado = color_cubo_1;
					end
				2:
					begin
						color_seleccionado = color_cubo_2;
					end
				4:
					begin
						color_seleccionado = color_cubo_3;
					end
				8:
					begin
						color_seleccionado = color_cubo_4;
					end
				16:
					begin
						color_seleccionado = color_cubo_5;
					end					
				default:
					color_seleccionado = 8'b11111111;
			endcase
		end


endmodule
