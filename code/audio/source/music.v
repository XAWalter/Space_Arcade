module music
	(
		input i_clk,
		output o_pulse
	);
	
	// LUT for songs
	reg [23:0]songs[15:0];
	initial begin
		songs[0] = 1318;
		songs[1] = 1318;
		songs[2] = 1318;
		songs[3] = 1046;
		songs[4] = 1318;
		songs[5] = 1567;
		songs[6] = 0;
		songs[7] = 783;
		songs[8] = 0;
		songs[9] = 1046;
		songs[10] = 783;
		songs[11] = 659;
		songs[12] = 880;
		songs[13] = 987;
		songs[14] = 932;
		songs[15] = 880;
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
		.i_freq(4),
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
		if ( count < 15 ) begin
			count = count + 1;
		end
		else begin
			count = 0;
		end
		r_freq = songs[count];
	end

endmodule
