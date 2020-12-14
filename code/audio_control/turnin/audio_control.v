module audio_control 
	(
		input i_clk,
		input i_data,
		output o_pulse,
		output o_g
	);
	
	// Registers
	reg r_m00_enable = 0;
	reg [7:0] r_ur00_data = 0;
	reg r_g = 0;

	// Assignments
	assign o_g = ~r_g;

	// Wires
	wire w_m00_done;
	wire w_ur00_done;
	wire [7:0] w_ur00_data;

	// Module Instantiation
	music m00(
		.i_clk(i_clk),
		.i_enable(r_m00_enable),
		.o_pulse(o_pulse),
		.o_done(w_m00_done)
	);

	uart_rx ur00(
		.i_clk(i_clk),
		.i_data(i_data),
		.o_data(w_ur00_data),
		.o_done(w_ur00_done)
	);

	// When there is a change in input from bluetooth
	// Save data into the data register
	always @(posedge w_ur00_done) begin
		r_ur00_data = w_ur00_data;
		if ( r_ur00_data == 8'h01 ) begin
			r_g = 1;
		end
		else begin
			r_g = 0;
		end
	end
		

	// If recive a 1 from bluetooth or music is not done playing, play the music
	// else dont play
	always @(posedge i_clk) begin

		// Uncomment one of the two if statements

		// Allow Song to finish
		//if ( r_ur00_data == 8'h01 || w_m00_done == 1'b0 ) begin

		// Do not allow song to finish
		if ( r_ur00_data == 8'h01 ) begin

			r_m00_enable <= 1'b1;
		end
		else begin
			r_m00_enable <= 1'b0;
		end
	end
endmodule
