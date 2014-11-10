`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:20 11/08/2014 
// Design Name: 
// Module Name:    MuxSonido 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MuxSonido(
	
	input sonidoCubo,
	input sonidoFinal,
	output sonidoEscogido
    );
	 
	 reg sonido;
	 
	 always @(*)begin
		if(sonidoCubo)begin 
			sonido <= sonidoCubo;
		end
		if(sonidoFinal)begin
			sonido <= sonidoFinal;
		end
		else begin
			sonido <=0;
		end
	 end
	 
	 
	 assign sonidoEscogido = sonido;
	 
	 


endmodule
