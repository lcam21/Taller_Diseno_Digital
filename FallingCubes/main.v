`timescale 1ns / 1ps

module main(
	
	input clk,
	input reset,
	input start,
	output hsync, vsync,
	output [7:0] rgb
	
	);


	wire video_on;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;
	
	wire pulso_pintar_cubo;
	//wire [8:0] posicion_y_actual_cubo;
	
	localparam POSICION_X_INICIAL_ALAMBRADA = 9'b100010110;
	localparam VELOCIDAD_ALAMBRADA = 2'b10;
	


	vga_sync controlador_vga(
		.clk(clk), 
		.reset(reset),
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y)
	);


	Cubo cubo_prueba(
		.clk(clk),
		.start(start),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.posicion_x_inicial_aleatoria(POSICION_X_INICIAL_ALAMBRADA),
		.velocidad_cubo_in(VELOCIDAD_ALAMBRADA),
		.posicion_y_actual(),
		.terminadoCubo(),
		.pintar_cubo(pulso_pintar_cubo)
	 );
	 
	MUX_RGB mux_colores(
		.clk(clk),
		.video_on(video_on),
		.cubo_verde(pulso_pintar_cubo),
		//.cubo_rojo(),
		//.cubo_azul(),
		.rgb_salida(rgb)
	);




endmodule
