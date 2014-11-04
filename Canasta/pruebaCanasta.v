`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:24 10/30/2014 
// Design Name: 
// Module Name:    pruebaCanasta 
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
module pruebaCanasta(
	input clk,
	input reset,
	input wire rx,
	output hsync, vsync,
	output [7:0] rgb,
	output [9:0] pos_x_actual
   );
	 
	wire [9:0] pixel_vga_x;
	wire[9:0] pixel_vga_y;
	wire [9:0] pos_x_mano;
	wire [0:7] rx_byte;
	 
	Canasta canasta (
	 .clk(clk), 
	 .reset(reset), 
	 .pixel_x(pixel_vga_x), 
	 .pixel_y(pixel_vga_y), 
	 .pos_x_mano(pos_x_mano), 
	 .pos_x_actual(pos_x_actual), 
	 .pintar_canasta(pintar_canasta)
	);
	
	vga_sync vga (
		.clk(clk),
		.reset(reset),
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(),
		.pixel_x(pixel_vga_x),
		.pixel_y(pixel_vga_y)
	);
	 
	MUX_RGB colores (
    .clk(clk), 
    .video_on(video_on), 
    .cubo_verde(pintar_canasta), 
    .rgb_salida(rgb)
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
	 


endmodule
