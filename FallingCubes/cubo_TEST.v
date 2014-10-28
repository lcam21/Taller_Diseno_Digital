`timescale 1ns / 1ps

module cubo_TEST;

	// Inputs
	reg clk;
	reg start;
	reg reset;
	reg [9:0] pixel_x;
	reg [9:0] pixel_y;
	reg [8:0] posicion_x_inicial_aleatoria;
	reg [1:0] velocidad_cubo_in;

	// Outputs
	wire [8:0] posicion_y_actual;
	wire terminadoCubo;
	wire pintar_cubo;

	// Instantiate the Unit Under Test (UUT)
	Cubo uut (
		.clk(clk), 
		.start(start), 
		.reset(reset), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y), 
		.posicion_x_inicial_aleatoria(posicion_x_inicial_aleatoria), 
		.velocidad_cubo_in(velocidad_cubo_in), 
		.posicion_y_actual(posicion_y_actual), 
		.terminadoCubo(terminadoCubo), 
		.pintar_cubo(pintar_cubo)
	);

	localparam T = 10;

	always
		begin
			clk = 1;
			#(T/2);
			clk = 0;
			#(T/2);
		end

	initial begin
		start = 0;
		reset = 0;
		pixel_x = 0;
		pixel_y = 0;
		posicion_x_inicial_aleatoria = 0;
		velocidad_cubo_in = 0;

		repeat (3) @(posedge clk);
		reset = 1;
		@(posedge clk);
		reset = 0;
		
		repeat (2) @(posedge clk);
		velocidad_cubo_in = 2;
		posicion_x_inicial_aleatoria = 200;
		start = 1;
		@(posedge clk);
		start = 0;
		
		repeat (2) @(posedge clk);
		pixel_y = 481;
		repeat (4) @(posedge clk);
		
	
	end
      
endmodule

