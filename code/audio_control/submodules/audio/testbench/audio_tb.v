`timescale 1ns/1ps
module audio_tb;
	
	// Inputs
	reg clk;
	reg [15:0] freq;
	wire pulse;


	music m02(
		.i_clk(clk),
		.o_pulse(pulse)
	);

	//clk_divider cd03(
	//	.i_clk(clk),
	//	.i_freq(50),
	//	.o_clk(pulse)
	//);

	initial begin
		clk = 0; #50;
		forever begin
			clk = ~clk; #50;
		end
	end	


	initial begin
		$dumpfile(`DUMP_FILE_NAME);
		$dumpvars(0, audio_tb);
	end
endmodule

