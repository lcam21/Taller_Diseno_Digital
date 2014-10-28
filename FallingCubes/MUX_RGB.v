`timescale 1ns / 1ps

module MUX_RGB(
	input clk,
	input video_on,
	input cubo_verde,
	//input cubo_rojo,
	//input cubo_azul,
	output [7:0] rgb_salida	
    );
	 
	 reg [7:0] RGB_temporal;
	 
	 always @(posedge clk) 
		begin
		
			if(~video_on)
				RGB_temporal <= 8'b0;
			else
				begin
					if(cubo_verde)
						RGB_temporal <= 8'b00111000;
//					else if(cubo_rojo)
//						RGB_temporal <= 8'b00000111;
//					else if(cubo_azul)
//						RGB_temporal <= 8'b11000000;
					else 
						RGB_temporal <= 8'b11111111;
				end
				
		 end
		 
	 assign rgb_salida = RGB_temporal;



	 
	 
	 


endmodule
