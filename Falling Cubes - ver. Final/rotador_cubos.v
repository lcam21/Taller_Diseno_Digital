`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module rotador_cubos(
    input clk,
    input reset,
	 input rotar,
	 output [1:0] activaciones_cubos
    );


	reg [1:0] cubos;
	
	always @(posedge clk)
		begin
			if(reset)
				begin
					cubos <= 2'b00;
				end
			else
				begin
					if(rotar)
						begin
							cubos <= cubos + 1;
						end
				end
		end

	assign activaciones_cubos = cubos;


endmodule
