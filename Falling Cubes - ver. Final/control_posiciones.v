`timescale 1ns / 1ps

module control_posiciones(
    input clk,
    input reset,
    input pulso_tiempo,
    input [8:0] posicion_x_aleatoria,
    input [8:0] pos_x_c1,
    input [8:0] pos_x_c2,
    input [8:0] pos_x_c3,
    input [8:0] pos_x_c4,
    input [8:0] pos_x_c5,
    output [8:0] pos_seleccionada,
    output pulso_habilitar
    );

	localparam E_ESPERA = 0,
					E_VERIFICACION = 1,
					E_HABILITADO = 2;
					
	reg [1:0] e_actual, e_siguiente;
	reg [8:0] posicion_x_reg, posicion_x_buff;
	
	always @(posedge clk)
		begin
			if(reset)
				begin
					e_actual <= E_ESPERA;
					posicion_x_reg <= 9'b0;
				end
			else
				begin
					e_actual <= e_siguiente;
					posicion_x_reg <= posicion_x_buff;
				end
		end
		
	always @(*)
		begin
			e_siguiente = e_actual;
			posicion_x_buff = posicion_x_reg;
			
			case(e_actual)
				E_ESPERA:
					begin
						if(pulso_tiempo)
							begin
								e_siguiente = E_VERIFICACION;
								posicion_x_buff = posicion_x_aleatoria;
							end
					end
				E_VERIFICACION:
					begin
						if(posicion_x_reg == pos_x_c1 ||
							posicion_x_reg == pos_x_c2 ||
							posicion_x_reg == pos_x_c4 ||
							posicion_x_reg == pos_x_c5 ||
							posicion_x_reg == pos_x_c3)
							begin
								posicion_x_buff = posicion_x_aleatoria;								
							end
						else
							begin
								e_siguiente = E_HABILITADO;
							end
					end
				E_HABILITADO:
					begin
						e_siguiente = E_ESPERA;
					end
				default:
					e_siguiente = E_ESPERA;
			endcase
		end

	assign pos_seleccionada = posicion_x_reg;
	assign pulso_habilitar = e_actual == E_HABILITADO;

endmodule
