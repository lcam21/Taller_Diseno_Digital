`timescale 1ns / 1ps


/*
multiplexor para seleccionar el dato actual
que se ira a mostrar en el 7segmentos. Segun la
seleccion de entrada.
*/
module MUX_MensajeActual(
    input [0:6] msj_1,
	 input [0:6] msj_2,
	 input [0:6] msj_3,
	 input [0:6] msj_4,
    input [1:0] seleccion,
    output [0:6] msj_seleccionado
    );	 
	
	reg [0:6] msjIntermediario;

	always @(*) begin
		case(seleccion)
			0:
				msjIntermediario <= msj_1;
			1:
				msjIntermediario <= msj_2;
			2:
				msjIntermediario <= msj_3;
			3:
				msjIntermediario <= msj_4;
		endcase
	end
	assign msj_seleccionado = msjIntermediario;
endmodule
