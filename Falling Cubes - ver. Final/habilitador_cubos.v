`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*
modulo que permite pasar el valor de entrada "cubos_entrada"
a la salida "cubos" unicamente cuando la entrada "bandera_habilitar_cubos" es alta.
Ademas si ocupa la entrada "pulso_habilitador" para que sea distinto de cero la salida
*/
module habilitador_cubos(
	input [4:0] cubos_entrada,
	input pulso_habilitador,
	input bandera_habilitar_cubos,
	output [4:0] cubos
    );

	reg [4:0] valor_cubos;

	always @(*)
		begin
			valor_cubos = 5'b0;
			if(bandera_habilitar_cubos)
				valor_cubos = cubos_entrada;
		end
		
	assign cubos = pulso_habilitador ? valor_cubos : 0;

endmodule
