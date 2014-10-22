`timescale 1ns / 1ps

module Cubo(
	input clk, 
	input start,
	input reset,
	//input stop,
	input [9:0] pixel_x, pixel_y,
	input [8:0] posicion_x_inicial_aleatoria,
	input [1:0] velocidad_cubo_in,
	output reg [8:0] posicion_y_actual,
	output reg terminadoCubo,
	output pintar_cubo
    );

	localparam CUBO_SIZE = 64;
	
	//tamanio de la pantalla
	localparam Max_Y = 480;
	localparam Max_X = 640;
	 
	localparam 
			E_SIN_MOVIMIENTO 			= 0,
			E_EN_MOVIMIENTO 			= 1,
			E_FINALIZADO_RECORRIDO 	= 2;

	reg [1:0] e_actual, e_siguiente;
	reg [8:0] posicion_x_buffer;
	reg [8:0] posicion_x;
	
	wire habilitador_cubo;
	wire [1:0] velocidad_cubo_reg;
	reg [8:0] posicion_y_siguiente;
	wire pulso_refrescar;
	
	
	always @(posedge clk)
		begin
			if(reset)
				begin
					posicion_y_actual <= 0;
					e_actual <= E_SIN_MOVIMIENTO;
				end
			else 
				begin
					e_actual <= e_siguiente;
					posicion_x <= posicion_x_buffer;
					posicion_y_actual <= posicion_y_siguiente;
				end
		end

	always @(*)
		begin
			e_siguiente = e_actual;
			posicion_x_buffer = posicion_x;
			posicion_y_siguiente = posicion_y_actual;
			case(e_actual)
				E_SIN_MOVIMIENTO:
					begin
						
						if (start) 
						begin
							posicion_x_buffer = posicion_x_inicial_aleatoria;
							e_siguiente = E_EN_MOVIMIENTO;
						end
					end
				E_EN_MOVIMIENTO:
					begin
						if (posicion_y_actual == Max_Y)
						begin
							e_siguiente = E_FINALIZADO_RECORRIDO;
						end
						else if (pulso_refrescar && habilitador_cubo)
						begin
							posicion_y_siguiente = posicion_y_actual + velocidad_cubo_reg;
						end
					end
				E_FINALIZADO_RECORRIDO:
					begin
						terminadoCubo = 1;
						e_siguiente = E_SIN_MOVIMIENTO;
					end
				default:
					begin
						e_siguiente = E_SIN_MOVIMIENTO;
					end					
			endcase
		end
		

	assign velocidad_cubo_reg = velocidad_cubo_in;
	
	//Refresca con una frecuencia de 60Hz
	assign pulso_refrescar = (pixel_y == 481) && (pixel_x == 0);

	//condicion para determinar si el valor de los pixeles esta dentro del cubo
	assign pintar_cubo = (pixel_x >= posicion_x) && 
								(pixel_x <= posicion_x + CUBO_SIZE) && 
								(pixel_y >= posicion_y_actual - CUBO_SIZE) && 
								(pixel_y <= posicion_y_actual); 
								
	assign habilitador_cubo = (e_actual == E_EN_MOVIMIENTO);

endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

