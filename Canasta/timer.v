`timescale 1ns / 1ps


/*
	contador generico: se deben de sobreescribir los parametros para su 
	utilizacion. Su funcionamiento es para generar un pulso en alto cada cierto
	tiempo. Por ej, para un pulso cada 3ms, los valores seran 
		BITS_NECESARIOS = 18
		CANTIDAD_UNIDADES_TIEMPO = 3
		CANTIDAD_PULSOS_CUENTA	= 50000
	Se quiere contar 3 milisegundos, por lo que se ocupan 50000 pulsoCuenta (a 20ns Nexys 2)
	para hacer un milisegundo. Como se van a contar 3 ms, se calcula que se necesitan
	18 bits
*/
module timer(	
    input clk,
	 //en alto habilita una cuenta
	 //input habilitado,
    input reset,
    output pulsoTiempo
    );
	
	//cantidad de bits que se ocupan para llevar la cuenta
	//parameter BITS_NECESARIOS = 4;
	parameter CANTIDAD_UNIDADES_TIEMPO = 1;
	parameter CANTIDAD_PULSOS_CUENTA = 50000000; //medio segundo
	
	
	reg [29:0] conteo;
	reg [29:0] limite;

	
	always @(posedge clk) 
		 begin
				if(reset)
					begin					
						limite <= CANTIDAD_UNIDADES_TIEMPO*CANTIDAD_PULSOS_CUENTA;
						conteo <= 0;
					end
				else 
					begin
						//if(habilitado)
							//begin
								conteo <= conteo + 1; // cuente
								if(conteo == limite)
									conteo <= 0;
							//end
					end
		  end

	assign pulsoTiempo = (conteo == limite);
endmodule
