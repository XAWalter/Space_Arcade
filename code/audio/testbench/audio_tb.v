`timescale 1ns/1ps
module audio_tb;
	
	// Inputs
	reg clk;
	reg [15:0] freq;
	wire pulse;


	audio_note an01(
		.i_clk(clk),
		.i_freq(freq),
		.o_pulse(pulse)
	);

	initial begin
		freq = 500;
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

