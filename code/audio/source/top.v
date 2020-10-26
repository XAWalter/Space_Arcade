module top
	(
		input CLK,
		output P1A4
	);

	reg [23:0] freq = 100;
	wire w_clk;
	parameter CLK_DIV_FREQ = 24'h0000FF;

	audio_note an02(
		.i_clk(CLK),
		.i_freq(freq),
		.o_pulse(P1A4)
	);

	clk_divider cd01(
		.i_clk(CLK),
		.i_freq(CLK_DIV_FREQ),
		.o_clk(w_clk)
	);

	always @(posedge w_clk) begin
		if ( freq < 700 ) begin
			freq = freq + 1;
		end
		else begin
			freq = 0;
		end
	end

endmodule
