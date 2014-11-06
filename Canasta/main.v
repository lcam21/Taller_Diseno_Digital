`timescale 1ns / 1ps

module main(
	
	input clk,
	input reset,
	input start,
	input wire rx,
	output hsync, vsync,
	output led,
	output [7:0] rgb
	);


	wire video_on;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;
	
	//wire pulso_pintar_cubo;
	wire [2:0] aleatorio_tipo_cubo;
	wire [7:0] color_nuevo_cubo;
	wire [7:0] color_cubo_1;
	wire [7:0] color_cubo_2;
	wire [7:0] color_cubo_3;
	wire [7:0] color_cubo_4;
	wire [7:0] color_cubo_5;
	wire [1:0] velocidad_nuevo_cubo;
	wire [8:0] posicion_x_aleatoria;
	wire [8:0] posicion_x_permitida;
	wire [4:0] estado_cubos;
	wire [7:0] color_final;
	
	wire [4:0] valores_cubos_registro;
	wire [4:0] valores_cubos;
	
	wire [4:0] aleatorio_5_bits;
	
	wire pulso_habilitar_timer1;
	wire pulso_habilitar_cubos;
	wire tiempo_1_s_finalizado;
	
	wire [8:0] posicion_x_c1;
	wire [8:0] posicion_x_c2;
	wire [8:0] posicion_x_c3;
	wire [8:0] posicion_x_c4;
	wire [8:0] posicion_x_c5;

	wire [9:0] pos_x_mano;
	wire [0:7] rx_byte;
	
	wire pintar_canasta;
	
	wire [9:0] posicion_x_canasta;
	wire [8:0] posicion_y_canasta;
	
	wire [4:0] pulsos_cubos_en_canasta;
	
	wire encender_led;
	 
	Canasta canasta (
	 .clk(clk), 
	 .reset(reset), 
	 .pixel_x(pixel_x), 
	 .pixel_y(pixel_y), 
	 .pos_x_mano(pos_x_mano), 
	 .pos_x_actual(posicion_x_canasta), 
	 .pos_y_actual(posicion_y_canasta),
	 .pintar_canasta(pintar_canasta)
	);


	 UART UART (
    .clk(clk), 
    .rst(reset), 
    .rx(rx), 
    .received(), 
    .rx_byte(rx_byte), 
    .is_receiving(), 
    .recv_error()
    );
	 
	 Convertidor Convertidor (
    .clk(clk), 
    .datoEntrada(rx_byte), 
    .datoSalida(pos_x_mano)
    );
	 
	control_cubos controlCubos(
		.clk(clk),
		.reset(reset),
		.start(start), 
		.activar_timer1(pulso_habilitar_timer1),
		.habilitar_cubos(pulso_habilitar_cubos)	
	 );
	
	timer tiempo_1_s(	
		.clk(clk),
		.reset(pulso_habilitar_timer1),
		//.habilitado(pulso_habilitar_timer1),
		.pulsoTiempo(tiempo_1_s_finalizado)
    );

	LFSR_5bits lfsr_5bits (
		.clk(clk), 
		.reset(reset), 
		.out(aleatorio_5_bits)
	);	
	
	selector_posicion_x selector_posiciones(
		.aleatorio(aleatorio_5_bits),
		.posicion(posicion_x_aleatoria)
    );	
	
	control_posiciones controlPosiciones (
		.clk(clk), 
		.reset(reset), 
		.pulso_tiempo(tiempo_1_s_finalizado), 
		.posicion_x_aleatoria(posicion_x_aleatoria), 
		.pos_x_c1(posicion_x_c1), 
		.pos_x_c2(posicion_x_c2), 
		.pos_x_c3(posicion_x_c3), 
		.pos_x_c4(posicion_x_c4), 
		.pos_x_c5(posicion_x_c5), 
		.pos_seleccionada(posicion_x_permitida), 
		.pulso_habilitar(pulso_habilitar_siguiente_cubo)
	);


	registro_siguiente_cubo registroSiguienteCubo (
		.clk(clk), 
		.reset(reset), 
		.pulso_siguiente(pulso_habilitar_siguiente_cubo), 
		.cubos(valores_cubos_registro)
	);
	
	
	habilitador_cubos habilitador(
			.cubos_entrada(valores_cubos_registro),
			.pulso_habilitador(pulso_habilitar_cubos),
			.bandera_habilitar_cubos(pulso_habilitar_siguiente_cubo),
			.cubos(valores_cubos)
		 );
	
	LFSR_3bits lfsr_tipo_cubo(
		.clk(clk), 
		.reset(reset), 
		.out(aleatorio_tipo_cubo)
	);
	
	deco_configuracion_cubos deco_configuracion(
		.tipo_cubo(aleatorio_tipo_cubo),
		.color(color_nuevo_cubo),
		.velocidad(velocidad_nuevo_cubo)
    );

	vga_sync controlador_vga(
		.clk(clk), 
		.reset(reset),
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(), //borrar
		.pixel_x(pixel_x),
		.pixel_y(pixel_y)
	);


	Cubo cubo1(
		.clk(clk),
		.start(valores_cubos[0]),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.color_cubo_in(color_nuevo_cubo),
		.posicion_x_inicial_aleatoria(posicion_x_permitida),
		.velocidad_cubo_in(velocidad_nuevo_cubo),
		.pos_x_canasta(posicion_x_canasta),
		.pos_y_canasta(posicion_y_canasta),
		//.posicion_y_actual(),
		.posicion_x_actual(posicion_x_c1),
		//.terminadoCubo(),
		.color_cubo_out(color_cubo_1),
		.recogido_en_canasta(pulsos_cubos_en_canasta[0]),
		.pintar_cubo(estado_cubos[0])
	 );	
	 
	 Cubo cubo2(
		.clk(clk),
		.start(valores_cubos[1]),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.color_cubo_in(color_nuevo_cubo),
		.posicion_x_inicial_aleatoria(posicion_x_permitida),
		.velocidad_cubo_in(velocidad_nuevo_cubo),
		.pos_x_canasta(posicion_x_canasta),
		.pos_y_canasta(posicion_y_canasta),
		//.posicion_y_actual(),
		.posicion_x_actual(posicion_x_c2),
		//.terminadoCubo(),
		.color_cubo_out(color_cubo_2),
		.recogido_en_canasta(pulsos_cubos_en_canasta[1]),
		.pintar_cubo(estado_cubos[1])
	 );


	 Cubo cubo3(
		.clk(clk),
		.start(valores_cubos[2]),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.color_cubo_in(color_nuevo_cubo),
		.posicion_x_inicial_aleatoria(posicion_x_permitida),
		.velocidad_cubo_in(velocidad_nuevo_cubo),
		.pos_x_canasta(posicion_x_canasta),
		.pos_y_canasta(posicion_y_canasta),
		//.posicion_y_actual(),
		.posicion_x_actual(posicion_x_c3),
		//.terminadoCubo(),
		.color_cubo_out(color_cubo_3),
		.recogido_en_canasta(pulsos_cubos_en_canasta[2]),
		.pintar_cubo(estado_cubos[2])
	 );

	 Cubo cubo4(
		.clk(clk),
		.start(valores_cubos[3]),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.color_cubo_in(color_nuevo_cubo),
		.posicion_x_inicial_aleatoria(posicion_x_permitida),
		.velocidad_cubo_in(velocidad_nuevo_cubo),
		.pos_x_canasta(posicion_x_canasta),
		.pos_y_canasta(posicion_y_canasta),
		//.posicion_y_actual(),
		.posicion_x_actual(posicion_x_c4),
		//.terminadoCubo(),
		.color_cubo_out(color_cubo_4),
		.recogido_en_canasta(pulsos_cubos_en_canasta[3]),
		.pintar_cubo(estado_cubos[3])
	 );
	 
	 Cubo cubo5(
		.clk(clk),
		.start(valores_cubos[4]),
		.reset(reset),		
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y),
		.color_cubo_in(color_nuevo_cubo),
		.posicion_x_inicial_aleatoria(posicion_x_permitida),
		.velocidad_cubo_in(velocidad_nuevo_cubo),
		.pos_x_canasta(posicion_x_canasta),
		.pos_y_canasta(posicion_y_canasta),
		//.posicion_y_actual(),
		.posicion_x_actual(posicion_x_c5),
		//.terminadoCubo(),
		.color_cubo_out(color_cubo_5),
		.recogido_en_canasta(pulsos_cubos_en_canasta[4]),
		.pintar_cubo(estado_cubos[4])
	 );	 
	 
	seleccionador_color_cubo seleccionador(
		.estado_cubos(estado_cubos),
		.color_cubo_1(color_cubo_1),
		.color_cubo_2(color_cubo_2),
		.color_cubo_3(color_cubo_3),
		.color_cubo_4(color_cubo_4),
		.color_cubo_5(color_cubo_5),
		.color_seleccionado(color_final)
    ); 
	
	MUX_RGB mux_colores(
		.clk(clk),
		.video_on(video_on),
		.canasta(pintar_canasta),
		.valores_cubos(estado_cubos),
		.color_cubo(color_final),
		.rgb_salida(rgb)
	);

	registro_puntaje(
			.clk(clk),
			.reset(reset),
			.pulsos_cubos_canasta(pulsos_cubos_en_canasta),
			.pulso_sonido(encender_led)
		 );
		 
	continuadorPeriodo(
		.clk(clk),	 
		.reset(reset),
		.pulsoEntrada(encender_led),
		.pulsoSalida(led)
    );


endmodule
