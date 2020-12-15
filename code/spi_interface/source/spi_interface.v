module spi_interface(
		input [7:0] i_data,
		input i_data_ready,
		input i_clk,
		output o_mosi,
		output o_s_clk,
		output o_ss,
		output o_done
	);
	
	// States
	parameter IDLE = 2'b00;
	parameter SEND_DATA = 2'b01;
	parameter DONE = 2'b10;

	// Registers
	reg [7:0] r_data = 8'b00000000;
	reg [31:0] r_freq = 6000000;
	reg r_s_clk = 1'b1;
	reg r_mosi = 1'b0;
	reg r_done = 1'b0;
	reg [1:0] r_curr_state = IDLE;
	reg r_clk_run = 0;

	// Wire	
	wire w_switch;

	// Counter
	integer count = 7;

	// Assignments
	assign o_ss = 1'b0;
	assign o_s_clk = (r_clk_run) ? r_s_clk : 1;
	assign o_mosi = r_mosi;
	assign o_done = r_done;

	
	// clk Divider
	clk_divider cd01(
		.i_clk(i_clk),
		.i_freq(r_freq),
		.o_clk(w_switch)
	);

	// Off when data is not ready
	always @(posedge i_clk) begin
		if ( i_data_ready ) begin
			r_data = i_data;
		end
		else begin
			r_curr_state = IDLE;
			r_data = 0;
		end
	end
	
	// Clock Divider to half of icebreaker clock
	always @(posedge w_switch) begin
		r_s_clk = ~r_s_clk;
	end


	// OLED reads data on Posedge thus send data on negedge
	always @(negedge r_s_clk) begin
		// Transitions
		case ( r_curr_state )

			IDLE: begin
				if ( !i_data_ready ) begin
					r_curr_state = IDLE;
				end
				else begin
					count = 7;
					r_curr_state = SEND_DATA;
				end
			end	

			SEND_DATA: begin
				if ( !i_data_ready ) begin
					r_curr_state = IDLE;
				end
				else if ( count >= 0 ) begin
					r_curr_state = SEND_DATA;
				end
				else begin
					count = 7;
					r_curr_state = DONE;
				end
			end

			DONE: begin
				if ( !i_data_ready ) begin
					r_curr_state = IDLE;
				end
				else begin
					r_curr_state = DONE;
				end
			end
		endcase

		// Actions
		case ( r_curr_state )
			
			IDLE: begin
				r_mosi = 0;
				r_done = 0;
				r_clk_run = 0;
			end
			
			SEND_DATA: begin
				r_clk_run = 1;
				r_mosi = r_data[count];
				count = count - 1;
			end

			DONE: begin
				r_done = 1'b1;
				r_clk_run = 0;
			end
		endcase
	end
				

endmodule
