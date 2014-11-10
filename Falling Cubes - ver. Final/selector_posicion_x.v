`timescale 1ns / 1ps

module selector_posicion_x(
    input [4:0] aleatorio,
    output reg [8:0] posicion
    );
	 
	 
	always @(*)
		begin
			if((aleatorio >= 0) && (aleatorio <= 3)) //1
				begin
					posicion = 9'b0;
				end
			else if((aleatorio >= 4) && (aleatorio <= 6)) //2
				begin
					posicion = 9'b001000000;
				end
			else if((aleatorio >= 7) && (aleatorio <= 9)) //3
				begin
					posicion = 9'b010000000;
				end
			else if((aleatorio >= 10) && (aleatorio <= 12)) //4
				begin
					posicion = 9'b011000000;
				end
			else if((aleatorio >= 13) && (aleatorio <= 15)) //5
				begin
					posicion = 9'b100000000;
				end
			else if((aleatorio >= 16) && (aleatorio <= 19)) //6
				begin
					posicion = 9'b101000000;
				end
			else if((aleatorio >= 20) && (aleatorio <= 23)) //7
				begin
					posicion = 9'b110000000;
				end
			else if((aleatorio >= 24) && (aleatorio <= 27)) //8
				begin
					posicion = 9'b111000000;
				end
			else if((aleatorio >= 28) && (aleatorio <= 30)) //9
				begin
					posicion = 9'b111111111;
				end
			else 
				posicion = 9'b0;
		end


endmodule
