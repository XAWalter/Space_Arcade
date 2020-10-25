module top
	(
		input CLK,
		output P1A4
	);

	audio_note an02(
		.i_clk(CLK),
		.o_pulse(P1A4)
	);

endmodule

	
	
