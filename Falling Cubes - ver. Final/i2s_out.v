// i2s_out.v:
// 2008-08-26 E. Brombaugh

module i2s_out(clk, reset,
				l_data, r_data,
				sdout, sclk, lrclk,
				load);
	
	input clk;									// System clock
	input reset;								// System POR
	input signed [23:0] l_data, r_data;			// inputs
	output sdout;								// I2S serial data
	output sclk;								// I2S serial clock
	output lrclk;								// I2S Left/Right clock
	output load;								// Sample rate enable output
	
	// Sample rate generation
	clkgen
		uclk(.clk(clk), .reset(reset), .rate(load));
	
	// Serial Clock divider
	reg [2:0] scnt;		// serial clock divide register
	always @(posedge clk)
		if(reset)
			scnt <= 0;
		else if(load)
			scnt <= 0;
		else
			scnt <= scnt + 1;
	
	// generate serial clock pulse
	reg p_sclk;			// 1 cycle wide copy of serial clock
	always @(posedge clk)
		p_sclk <= ~|scnt;
	
	// Shift register advances on serial clock
	reg [47:0] sreg;
	always @(posedge clk)
		if(load)
			sreg <= {l_data,r_data};
		else if(p_sclk)
			sreg <= {sreg[46:0],1'b0};
	
	// 1 serial clock cycle delay on data relative to LRCLK
	reg sdout;
	always @(posedge clk)
		if(p_sclk)
			sdout <= sreg[47];
	
	// Generate LR clock
	reg [4:0] lrcnt;
	reg lrclk;
	always @(posedge clk)
		if(reset | load)
		begin
			lrcnt <= 0;
			lrclk <= 0;
		end
		else if(p_sclk)
		begin
			if(lrcnt == 5'd23)
			begin
				lrcnt <= 0;
				lrclk <= ~lrclk;
			end
			else
				lrcnt <= lrcnt + 1;
		end
	
	// align everything
	reg sclk_p0, sclk;
	always @(posedge clk)
	begin
		sclk_p0 <= scnt[2];
		sclk <= sclk_p0;
	end
endmodule
