`timescale 1ns / 1ps
/*
Genera numeros aleatorios hasta 255(8bits). Referencia
http://simplefpga.blogspot.com/2013/02/random-number-generator-in-verilog-fpga.html
*/
module LFSR (		
		input clk,  
		input reset,
		//input cambio,
		output [8:0] out
		);
		
	//------------Internal Variables--------
	wire linear_feedback;
	reg [8:0] salida;

	//-------------Code Starts Here-------
	assign linear_feedback = !(salida[8] ^ salida[4]);

	always @(posedge clk)
		begin
			if (reset) 
				begin 
					salida = 9'b1111;
				end 
			else 
				begin
					salida = {salida[7:0], linear_feedback};						
					if (salida == 0)
						salida = out + 1;
				end 
		end
	assign out = salida; //(salida < 410) ? salida : salida - 64;
	
endmodule 



module LFSR_3bits (		
		input clk,  
		input reset,		
		output reg [2:0] out
		);
		
	//------------Internal Variables--------
	wire linear_feedback;

	//-------------Code Starts Here-------
	assign linear_feedback = !(out[2] ^ out[1]);

	always @(posedge clk)
		begin
			if (reset) 
				begin 
					out <= 3'b001;
				end 
			else 
				begin
					out <= {out[1:0], linear_feedback};
					if (out == 0)
						out <= out + 1;
				end 
		end
endmodule 



module LFSR_5bits (		
		input clk,  
		input reset,		
		output reg [4:0] out
		);
		
	//------------Internal Variables--------
	wire linear_feedback;

	//-------------Code Starts Here-------
	assign linear_feedback = !(out[4] ^ out[2]);

	always @(posedge clk)
		begin
			if (reset) 
				begin 
					out <= 5'b1;
				end 
			else 
				begin
					out <= {out[3:0], linear_feedback};
					if (out == 0)
						out <= out + 1;
				end 
		end
endmodule 



