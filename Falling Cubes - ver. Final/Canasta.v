`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:52 10/28/2014 
// Design Name: 
// Module Name:    Canasta 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Canasta(
	input clk, 
	input reset,
	input [9:0] pixel_x, pixel_y,
	input [9:0] pos_x_mano,
	output reg [9:0] pos_x_actual,
	output [8:0] pos_y_actual,
	output pintar_canasta
   );
	
	// Limites de la pantalla
	localparam MAX_Y = 480;
	localparam MAX_X = 640;
	
	// valores de la canasta
	localparam POS_X_INICIAL = 272;
	localparam TAMANIO_CANASTA = 90;
	localparam TAMANIO_CANASTA_Y = 32;
	localparam TAMANIO_CANASTA_CENTRO = 60;
	localparam [1:0] VELOCIDAD = 1;
	// estados
	localparam 	E_SIN_MOVIMIENTO		= 0,
					E_MOVIMIENTO_IZQ		= 1,
					E_MOVIMIENTO_DERECH	= 2;
					
	reg [1:0] 	E_ACTUAL, 
					E_SIGUIENTE;
	// para realizar el movimiento
	reg [9:0] pos_x_siguiente;
	// para indicar que tiene q pintar la canasta
	wire pulso_refrescar; 
	
	 
					
	always @(posedge clk) begin
		if(reset) begin
			E_ACTUAL <= E_SIN_MOVIMIENTO;
			pos_x_actual <= POS_X_INICIAL;
		end
		else begin
			E_ACTUAL <= E_SIGUIENTE;
			pos_x_actual <= pos_x_siguiente;
		end
	end
	
	always @(*) begin
		E_SIGUIENTE = E_ACTUAL;
		pos_x_siguiente = pos_x_actual;
		case(E_ACTUAL)
			E_MOVIMIENTO_IZQ: begin
				if ((pos_x_actual < pos_x_mano) && ((pos_x_actual + TAMANIO_CANASTA) < MAX_X)) begin
					E_SIGUIENTE = E_MOVIMIENTO_DERECH;
				end
				else if ((pos_x_actual > pos_x_mano) && (pos_x_actual >= 0) && (pulso_refrescar)) begin
					pos_x_siguiente = pos_x_actual - VELOCIDAD;
				end
				else begin
					E_SIGUIENTE = E_SIN_MOVIMIENTO;
				end
			end
			E_MOVIMIENTO_DERECH: begin
				if ((pos_x_actual > pos_x_mano) && (pos_x_actual >= 0)) begin
					E_SIGUIENTE = E_MOVIMIENTO_IZQ;
				end
				else if ((pos_x_actual < pos_x_mano) && ((pos_x_actual + TAMANIO_CANASTA) < MAX_X) && (pulso_refrescar)) begin
					pos_x_siguiente = pos_x_actual + VELOCIDAD;
				end
				else begin
					E_SIGUIENTE = E_SIN_MOVIMIENTO;
				end
			end
			E_SIN_MOVIMIENTO: begin
				if ((pos_x_actual > pos_x_mano) && (pos_x_actual >= 0)) begin
					E_SIGUIENTE = E_MOVIMIENTO_IZQ;
				end
				else if ((pos_x_actual < pos_x_mano) && ((pos_x_actual + TAMANIO_CANASTA) < MAX_X)) begin
					E_SIGUIENTE = E_MOVIMIENTO_DERECH;
				end
				else if (pulso_refrescar) begin
					pos_x_siguiente = pos_x_actual;
				end
			end
			default:
				begin
					E_SIGUIENTE = E_SIN_MOVIMIENTO;
				end	
		endcase
	end
	
	assign pulso_refrescar = (pixel_y == 481) && (pixel_x == 0);
	
	assign pos_y_actual = (MAX_Y - TAMANIO_CANASTA_Y - 1);
	
	assign pintar_canasta = (pixel_x >= pos_x_actual) && 
									(pixel_x <= pos_x_actual + TAMANIO_CANASTA) && 
									(pixel_y >= pos_y_actual) && (pixel_y < MAX_Y); 
		
endmodule
