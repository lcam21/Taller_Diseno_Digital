`timescale 1ns / 1ps

/*
modulo que guarda el pulso que habilita el siguiente
cubo para pintarse. Si hay 5 cubos, se ocupan 5 bits
00001
00010
00100
01000
10000
Con cada entrada "pulso_siguiente" en alto, cambia al proximo valor
*/
module registro_siguiente_cubo(
    input clk,
    input reset,
    input pulso_siguiente,
    output reg [4:0] cubos
    );

	wire [4:0] cubos_buffer;
	
	
	assign cubos_buffer = cubos * 2;
	
	
	always @(posedge clk)
		begin
			if(reset)
				cubos <= 5'b1;
			else
				begin
					if(pulso_siguiente)
						begin
							if(cubos_buffer == 0)
								cubos <= 5'b1;
							else
								cubos <= cubos_buffer;
						end
				end
		end


endmodule
