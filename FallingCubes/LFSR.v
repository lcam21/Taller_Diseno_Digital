`timescale 1ns / 1ps
/*
Genera numeros aleatorios hasta 255(8bits). Referencia
http://simplefpga.blogspot.com/2013/02/random-number-generator-in-verilog-fpga.html
*/
module LFSR (		
		input clk,  
		input reset,
		//input cambio,
		output reg [8:0] out
		);
		
	//------------Internal Variables--------
	wire linear_feedback;

	//-------------Code Starts Here-------
	assign linear_feedback = !(out[8] ^ out[4]);

	always @(posedge clk)
		begin
			if (reset) 
				begin 
					out <= 9'b1111;
				end 
			else 
				begin
					//if(cambio)
						//begin
							out <= {out[7:0], linear_feedback};
						//end							 
					if (out == 0)
						out <= out + 1;
				end 
		end
endmodule 







