`timescale 1ns / 1ps
/*
Para desplegar elementos en los 4 7segmentos se necesitan
4 distintos buses con los valores para cada anodo. Se utiliza 
un formato como el siguiente
	32'h34_34_32_39
Cada 8 bits de los 32 del mensaje entrante son puestos en 4 distintos
buses, segun su valor en hexadecimal ascii. h34 en ascii es el numero 4.
Los buses de salida contienen la representacion del elemento en un 7segmentos.
*/
module separadorMensajes(
    input [31:0] mensaje,
    output reg [0:6] parte_0,
	 output reg [0:6] parte_1,
	 output reg [0:6] parte_2,
	 output reg [0:6] parte_3
    );
	 

	always @(mensaje)begin
		case(mensaje[7:0])				
				8'h30: //numero cero en ascii, hexadecimal
					parte_0 <= 7'b0000001;
				8'h31:
					parte_0 <= 7'b1001111;
				8'h32:
					parte_0 <= 7'b0010010;
				8'h33:
					parte_0 <= 7'b0000110;
				8'h34:
					parte_0 <= 7'b1001100;
				8'h35:
					parte_0 <= 7'b0100100;
				8'h36:
					parte_0 <= 7'b0100000;
				8'h37:
					parte_0 <= 7'b0001111;
				8'h38:
					parte_0 <= 7'b0000000;
				8'h39:
					parte_0 <= 7'b0000100;
				8'h48: //Uppercase H en ascii, hexadecimal
					parte_0 <= 7'b1001000;
				8'h49: //uppercase I en ascii, hexadecimal
					parte_0 <= 7'b1001111;
				default: 
					parte_0 <= 7'b1111111;								
		endcase
		case(mensaje[15:8])				
				8'h30: //numero cero en ascii, hexadecimal
					parte_1 <= 7'b0000001;
				8'h31:
					parte_1 <= 7'b1001111;
				8'h32:
					parte_1 <= 7'b0010010;
				8'h33:
					parte_1 <= 7'b0000110;
				8'h34:
					parte_1 <= 7'b1001100;
				8'h35:
					parte_1 <= 7'b0100100;
				8'h36:
					parte_1 <= 7'b0100000;
				8'h37:
					parte_1 <= 7'b0001111;
				8'h38:
					parte_1 <= 7'b0000000;
				8'h39:
					parte_1 <= 7'b0000100;
				8'h48: //Uppercase H en ascii, hexadecimal
					parte_1 <= 7'b1001000;
				8'h49: //uppercase I en ascii, hexadecimal
					parte_1 <= 7'b1001111;
				default: 
					parte_1 <= 7'b1111111;								
		endcase
		case(mensaje[23:16])				
				8'h30: //numero cero en ascii, hexadecimal
					parte_2 <= 7'b0000001;
				8'h31:
					parte_2 <= 7'b1001111;
				8'h32:
					parte_2 <= 7'b0010010;
				8'h33:
					parte_2 <= 7'b0000110;
				8'h34:
					parte_2 <= 7'b1001100;
				8'h35:
					parte_2 <= 7'b0100100;
				8'h36:
					parte_2 <= 7'b0100000;
				8'h37:
					parte_2 <= 7'b0001111;
				8'h38:
					parte_2 <= 7'b0000000;
				8'h39:
					parte_2 <= 7'b0000100;
				8'h48: //Uppercase H en ascii, hexadecimal
					parte_2 <= 7'b1001000;
				8'h49: //uppercase I en ascii, hexadecimal
					parte_2 <= 7'b1001111;
				default: 
					parte_2 <= 7'b1111111;								
		endcase
		case(mensaje[31:24])				
				8'h30: //numero cero en ascii, hexadecimal
					parte_3 <= 7'b0000001;
				8'h31:
					parte_3 <= 7'b1001111;
				8'h32:
					parte_3 <= 7'b0010010;
				8'h33:
					parte_3 <= 7'b0000110;
				8'h34:
					parte_3 <= 7'b1001100;
				8'h35:
					parte_3 <= 7'b0100100;
				8'h36:
					parte_3 <= 7'b0100000;
				8'h37:
					parte_3 <= 7'b0001111;
				8'h38:
					parte_3 <= 7'b0000000;
				8'h39:
					parte_3 <= 7'b0000100;
				8'h48: //Uppercase H en ascii, hexadecimal
					parte_3 <= 7'b1001000;
				8'h49: //uppercase I en ascii, hexadecimal
					parte_3 <= 7'b1001111;
				default: 
					parte_3 <= 7'b1111111;								
		endcase
	end

endmodule
