module music
	(
		input i_clk,
		output o_pulse
	);
	
	// LUT for songs
	reg [23:0]songs[63:0];
	initial begin
		songs[0] = 261;
		songs[1] = 261;
		songs[2] = 233;
		songs[3] = 196;
		songs[4] = 0;
		songs[5] = 174;
		songs[6] = 155;
		songs[7] = 0;
		songs[8] = 130;
		songs[9] = 155;
		songs[10] = 130;
		songs[11] = 155;
		songs[12] = 130;
		songs[13] = 155;
		songs[14] = 0;
		songs[15] = 174;
		songs[16] = 174;
		songs[17] = 0;
		songs[18] = 196;
		songs[19] = 0;
		songs[20] = 0;
		songs[21] = 0;
		songs[22] = 0;
		songs[23] = 311;
		songs[24] = 311;
		songs[25] = 0;
		songs[26] = 349;
		songs[27] = 349;
		songs[28] = 0;
		songs[29] = 311;
		songs[30] = 311;
		songs[31] = 261;
		songs[32] = 0;
		songs[33] = 261;
		songs[34] = 0;
		songs[35] = 311;
		songs[36] = 0;
		songs[37] = 261;
		songs[38] = 0;
		songs[39] = 311;
		songs[40] = 0;
		songs[41] = 261;
		songs[42] = 0;
		songs[43] = 311;
		songs[44] = 0;
		songs[45] = 392;
		songs[46] = 0;
		songs[47] = 0;
		songs[48] = 0;
		songs[49] = 349;
		songs[50] = 349;
		songs[51] = 0;
		songs[52] = 0;
		songs[53] = 466;
		songs[54] = 392;
		songs[55] = 466;
		songs[56] = 0;
		songs[57] = 392;
		songs[58] = 466;
		songs[59] = 0;
		songs[60] = 392;
		songs[61] = 466;
		songs[62] = 523;
		songs[63] = 261;
	end

	// Curr note freq
	reg [23:0] r_freq = 0;

	// Beats Per Second (BPS) Clock
	wire w_bps_clk;

	// counter for switching notes
	integer count = -1;

	// input: clk, BPS - note changes / seconds
	// output: clk pulses for given BPS
	clk_divider cd02(
		.i_clk(i_clk),
		.i_freq(8),
		.o_clk(w_bps_clk)
	);

	// input: clk, frequency of note wanted to be played
	// output: pulse for magnet DC Speaker?	
	audio_note an03(
		.i_clk(i_clk),
		.i_freq(r_freq),
		.o_pulse(o_pulse)
	);


	always @(posedge w_bps_clk) begin
		if ( count < 63 ) begin
			count = count + 1;
		end
		else begin
			count = 0;
		end
		r_freq = songs[count];
	end

endmodule
