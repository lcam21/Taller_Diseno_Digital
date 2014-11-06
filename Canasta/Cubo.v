`timescale 1ns / 1ps

module Cubo(
	input clk, 
	input start,
	input reset,
	//input stop,
	input [9:0] pixel_x, pixel_y,
	input [8:0] posicion_x_inicial_aleatoria,
	input [1:0] velocidad_cubo_in,
	input [7:0] color_cubo_in,
	input [9:0] pos_x_canasta,
	input [8:0] pos_y_canasta,
	//output reg [8:0] posicion_y_actual,
	//output terminadoCubo,
	output [7:0] color_cubo_out,
	output [8:0] posicion_x_actual,
	output [1:0] puntos_en_canasta,
	output pintar_cubo
    );

	localparam CUBO_SIZE = 60;
	
	//tamanio de la pantalla
	localparam Max_Y = 480;
	localparam Max_X = 640;
	
	//constantes para los estados
	localparam 
			E_SIN_MOVIMIENTO 			= 0,
			E_EN_MOVIMIENTO 			= 1,
			E_FINALIZADO_RECORRIDO 	= 2,
			E_SUMA_DE_PUNTOS			= 3;

	reg [1:0] e_actual, e_siguiente;
	
	//se utilizan buffers para evitar los latches y para
	//generar la logica secuencial
	reg [8:0] posicion_x_buffer;
	reg [8:0] posicion_x;
	reg [1:0] velocidad_cubo_buffer;
	reg [1:0] velocidad_cubo;
	reg [8:0] posicion_y_siguiente;
	reg [8:0] posicion_y_actual;
	reg [7:0] color_cubo;
	reg [7:0] color_cubo_buffer;
	
	//pulso que se activa cuando el cubo cambia al estado de "en movimiento"
	wire habilitador_cubo;
	//pulso que se activa cuando las posicion x,y del controlador de pantalla
	//han salido del area de pintado (0,481). Se utiliza para actualizar la posicion
	//del cubo en el eje y.
	wire pulso_refrescar;
	
	//asignaciones INTERNAS
	assign pulso_refrescar = (pixel_y == 481) && (pixel_x == 0);
	assign habilitador_cubo = (e_actual == E_EN_MOVIMIENTO);
	
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
					velocidad_cubo <= velocidad_cubo_buffer;
					posicion_y_actual <= posicion_y_siguiente;
					color_cubo <= color_cubo_buffer;
				end
		end

	always @(*)
		begin
			
			e_siguiente = e_actual;
			posicion_x_buffer = posicion_x;
			velocidad_cubo_buffer = velocidad_cubo;
			posicion_y_siguiente = posicion_y_actual;
			color_cubo_buffer = color_cubo;
			
			case(e_actual)
				E_SIN_MOVIMIENTO:
					begin
						if (start) 
						begin
							posicion_x_buffer = posicion_x_inicial_aleatoria;
							velocidad_cubo_buffer = velocidad_cubo_in;
							color_cubo_buffer = color_cubo_in;
							e_siguiente = E_EN_MOVIMIENTO;
						end
					end
				E_EN_MOVIMIENTO:
					begin
						if (posicion_y_actual == Max_Y)
							begin
								posicion_y_siguiente = 0;
								//se saca de la pantalla
								posicion_x_buffer = 0;
								e_siguiente = E_FINALIZADO_RECORRIDO;
							end
						else if (pulso_refrescar && habilitador_cubo)
							begin
								posicion_y_siguiente = posicion_y_actual + velocidad_cubo;
							end
						else if((posicion_y_actual > pos_y_canasta) &&
								  (pos_x_canasta <= posicion_x) &&
								  ((pos_x_canasta + 79) >= (posicion_x + CUBO_SIZE)))
							begin
								posicion_y_siguiente = 0;
								//se saca de la pantalla
								posicion_x_buffer = 0;
								e_siguiente = E_SUMA_DE_PUNTOS;
							end						
					end
				E_SUMA_DE_PUNTOS:
					begin
						e_siguiente = E_SIN_MOVIMIENTO;
					end
				E_FINALIZADO_RECORRIDO:
					begin
						e_siguiente = E_SIN_MOVIMIENTO;
					end
				default:
					begin
						e_siguiente = E_SIN_MOVIMIENTO;
					end					
			endcase
		end
	
	//asignaciones EXTERNAS

	//condicion para determinar si el valor de los pixeles esta dentro del cubo
	assign pintar_cubo = (pixel_x >= posicion_x) && 
								(pixel_x <= posicion_x + CUBO_SIZE) && 
								(pixel_y >= posicion_y_actual - CUBO_SIZE) && 
								(pixel_y <= posicion_y_actual) && habilitador_cubo; 
	
	//pulso que es alto cuando el cubo llega al fondo de la pantalla
	//assign terminadoCubo = (e_actual == E_FINALIZADO_RECORRIDO);
	
	assign color_cubo_out = color_cubo;
	
	assign posicion_x_actual = e_actual == E_EN_MOVIMIENTO ? posicion_x : 9'b1;
	
	assign puntos_en_canasta = e_actual == E_SUMA_DE_PUNTOS ? velocidad_cubo : 0;
	
endmodule





