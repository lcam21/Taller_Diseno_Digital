`timescale 1ns / 1ps

/*
Cada numero en decimal tiene una representacion en hexadecimal en ascii, 
0 = h30,
1 = h31,
etc
El modulo recibe 3 numeros de 0-9, los cuales los convierte en hex codigo ascii.
por ej para el numero 123, la salida en hexAscii seria
xx313233, donde xx es para los millares, pero no son implementados en el modulo, por
lo que son indeffinidos.
*/

module convertidorDecToHexAscii(
    input [3:0] unidades,
    input [3:0] decenas,
    input [3:0] centenas,
    output [31:0] salidaHexAscii
    );

	reg [7:0] contenedorUnidades;
	reg [7:0] contenedorDecenas;
	reg [7:0] contenedorCentenas;
	reg [7:0] contenedorMillares;
	
	always @(unidades, decenas, centenas) begin
	
		//siempre se deshabilita el de millares porque no es necesario
		//ascii indefinidso
		contenedorMillares <= 8'h00;		
		case(unidades)
			0:
				contenedorUnidades <= 8'h30;
			1:
				contenedorUnidades <= 8'h31;	
			2:
				contenedorUnidades <= 8'h32;
			3:
				contenedorUnidades <= 8'h33;
			4:
				contenedorUnidades <= 8'h34;
			5:
				contenedorUnidades <= 8'h35;
			6:
				contenedorUnidades <= 8'h36;
			7:
				contenedorUnidades <= 8'h37;
			8:
				contenedorUnidades <= 8'h38;
			9:
				contenedorUnidades <= 8'h39;
			default:
				contenedorUnidades <= 8'h00;
		endcase
		
		case(decenas)
			0:
				if(centenas == 0)
					contenedorDecenas <= 8'h00;
				else
					contenedorDecenas <= 8'h30;
			1:
				contenedorDecenas <= 8'h31;	
			2:
				contenedorDecenas <= 8'h32;
			3:
				contenedorDecenas <= 8'h33;
			4:
				contenedorDecenas <= 8'h34;
			5:
				contenedorDecenas <= 8'h35;
			6:
				contenedorDecenas <= 8'h36;
			7:
				contenedorDecenas <= 8'h37;
			8:
				contenedorDecenas <= 8'h38;
			9:
				contenedorDecenas <= 8'h39;
			default:
				contenedorDecenas <= 8'h00;
		endcase
		
		case(centenas)
			0:
				contenedorCentenas <= 8'h00;
			1:
				contenedorCentenas <= 8'h31;	
			2:
				contenedorCentenas <= 8'h32;
			3:
				contenedorCentenas <= 8'h33;
			4:
				contenedorCentenas <= 8'h34;
			5:
				contenedorCentenas <= 8'h35;
			6:
				contenedorCentenas <= 8'h36;
			7:
				contenedorCentenas <= 8'h37;
			8:
				contenedorCentenas <= 8'h38;
			9:
				contenedorCentenas <= 8'h39;
			default:
				contenedorCentenas <= 8'h00;
		endcase

	end

	assign salidaHexAscii = {contenedorMillares, contenedorCentenas, contenedorDecenas, contenedorUnidades};

endmodule
