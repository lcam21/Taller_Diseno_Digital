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
	output terminadoCubo,
	output pintar_cubo
    );

	localparam CUBO_SIZE = 64;
	
	//tamanio de la pantalla
	localparam Max_Y = 480;
	localparam Max_X = 640;
	
	//constantes para los estados
	localparam 
			E_SIN_MOVIMIENTO 			= 0,
			E_EN_MOVIMIENTO 			= 1,
			E_FINALIZADO_RECORRIDO 	= 2;

	reg [1:0] e_actual, e_siguiente;
	
	//se utilizan buffers para evitar los latches y para
	//generar la logica secuencial
	reg [8:0] posicion_x_buffer;
	reg [8:0] posicion_x;
	reg [1:0] velocidad_cubo_buffer;
	reg [1:0] velocidad_cubo;
	reg [8:0] posicion_y_siguiente;
	
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
				end
		end

	always @(*)
		begin
			
			e_siguiente = e_actual;
			posicion_x_buffer = posicion_x;
			velocidad_cubo_buffer = velocidad_cubo;
			posicion_y_siguiente = posicion_y_actual;
			
			case(e_actual)
				E_SIN_MOVIMIENTO:
					begin
						if (start) 
						begin
							posicion_x_buffer = posicion_x_inicial_aleatoria;
							velocidad_cubo_buffer = velocidad_cubo_in;
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
	assign terminadoCubo = (e_actual == E_FINALIZADO_RECORRIDO);
	
	
endmodule





