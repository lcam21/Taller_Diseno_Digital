`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module control_cubos(
    input clk,
    input reset,
	 input start, 
	 output activar_timer1,
	 output habilitar_cubos
    );

	localparam		E_INICIO				= 0,
						E_PRIMER_LAPSO 	= 1,
						E_SEGUNDO_LAPSO	= 2,
						E_TERCER_LAPSO 	= 3,
						E_CUARTO_LAPSO 	= 4;
						
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
					end
					
				E_SEGUNDO_LAPSO:
					begin
					end
				
				E_TERCER_LAPSO:
					begin
					end
				
				E_CUARTO_LAPSO:
					begin
					end
				
				default:
					begin
						e_siguiente = E_INICIO;
					end
			endcase
		end
		
		
//	always @(*)
//		begin
//			activar_timer1_buff = 0;
//			case(e_siguiente)
//			
//				E_PRIMER_LAPSO:
//					begin
//						activar_timer1_buff = 1;
//					end
//					
//				E_SEGUNDO_LAPSO:
//					begin
//					end
//				
//				E_TERCER_LAPSO:
//					begin
//					end
//				
//				E_CUARTO_LAPSO:
//					begin
//					end
//					
//			endcase
//		end

	assign activar_timer1 = activar_timer1_reg;
	assign habilitar_cubos = e_actual != E_INICIO;

endmodule
