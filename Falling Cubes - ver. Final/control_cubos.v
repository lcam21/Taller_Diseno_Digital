`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module control_cubos(
    input clk,
    input reset,
	 input start, 
	 input finalizado_tiempo_juego,
	 output activar_timer1,
	 output habilitar_cubos,
	 output pulsoFinalJuego
    );

	localparam		E_INICIO				= 0,
						E_PRIMER_LAPSO 	= 1,
						E_FINAL				= 2;
						
	reg [1:0] e_actual, e_siguiente;
	
	reg activar_timer1_reg, activar_timer1_buff;
	
	always @(posedge clk)
		begin
			if(reset)
				begin
					e_actual <= E_INICIO;
					activar_timer1_reg <= 0;
				end
			else
				begin
					e_actual <= e_siguiente;
					activar_timer1_reg <= activar_timer1_buff;
				end
		end
		
	always @(*)
		begin
			e_siguiente = e_actual;
			activar_timer1_buff = 0;
			case(e_actual)
				
				E_INICIO:
					begin
						if(start)
							begin
								e_siguiente = E_PRIMER_LAPSO;
								activar_timer1_buff = 1;
							end
					end
				
				E_PRIMER_LAPSO:
					begin	
						if(finalizado_tiempo_juego)
							begin
								e_siguiente = E_FINAL;
							end
					end
				E_FINAL:
					begin
						e_siguiente = E_INICIO;
					end				
				default:
					begin
						e_siguiente = E_INICIO;
					end
			endcase
		end
		

	assign activar_timer1 = activar_timer1_reg;
	assign habilitar_cubos = e_actual == E_PRIMER_LAPSO;
	assign pulsoFinalJuego = e_actual == E_FINAL;

endmodule
