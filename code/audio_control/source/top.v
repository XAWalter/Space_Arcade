module top
	(
		input CLK,
		input P2_3,
		output P1A4,
		output LEDG_N
	);

	// Module Instantiation
	audio_control ac01(
		.i_clk(CLK),
		.i_data(P2_3),
		.o_pulse(P1A4),
		.o_g(LEDG_N)
	);
endmodule
