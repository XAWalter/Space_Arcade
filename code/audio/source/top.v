module top
	(
		input CLK,
		output P1A4
	);

	reg [15:0] freq = 500;

	audio_note an02(
		.i_clk(CLK),
		.i_freq(freq),
		.i_enable(1),
		.o_pulse(P1A4)
	);

endmodule
