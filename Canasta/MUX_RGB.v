`timescale 1ns / 1ps

module MUX_RGB(
	input clk,
	input video_on,
	input canasta,
	input [4:0] valores_cubos,
	input [7:0] color_cubo,	
	output [7:0] rgb_salida	
    );
	 
	 reg [7:0] RGB_temporal;
	 
	 always @(posedge clk) 
		begin
			if(~video_on)
				RGB_temporal <= 8'b0;
			else
				begin
					if(valores_cubos > 1'b0)
						RGB_temporal <= color_cubo;
					else if(canasta)
						RGB_temporal <= 8'b00111111;
					else 
						RGB_temporal <= 8'b11111111;
				end
		 end
	 assign rgb_salida = RGB_temporal;

endmodule
