module uart_rx #(parameter CLK_FREQ = 12000000, parameter BAUD = 115200, parameter NUM_BITS = 8)
	(
	input i_clk,
	input i_data,
	output [NUM_BITS-1 :0] o_data,
	output o_done
	);

	// Number of Ticks for a period given BAUDRATE
	parameter CLKS_PER_PERIOD = CLK_FREQ / BAUD;

	// STATES	
	parameter WAIT = 3'b000;
	parameter CHECK_SB = 3'b001;
	parameter GET_DATA = 3'b010;
	parameter CHECK_FB = 3'b011;
	parameter RESET = 3'b100;

	// Registers
	reg [NUM_BITS - 1:0] r_data = 0;
	reg r_done = 0;
	reg [2:0] r_state = 3'b000;
	
	// Counters
	integer count = 0;
	integer bit = 0;

	// Assignments
	assign o_done = r_done;
	assign o_data = r_data;

	always @( posedge i_clk ) begin

		// Transitions
		case ( r_state )

			// If incoming bit is low, check to make sure it was intentional
			// Otherwise, Wait
			WAIT: begin
				if ( i_data == 1'b0 ) begin
					r_state = CHECK_SB;
				end
				else begin
					r_state = WAIT;
				end
			end
			
			// If Waited longer than half the period, Check to see if incoming bit is still low
			// If incoming bit is still low, start receiving data
			// Otherwise, not intentional and go back to Waiting
			CHECK_SB: begin
				if ( count >= CLKS_PER_PERIOD / 2 ) begin
					if ( i_data == 1'b0 ) begin
						r_state = GET_DATA;
						count = 0;
					end
					else begin
						r_state = WAIT;
						count = 0;
					end
				end
				else begin
					r_state = CHECK_SB;
				end
			end

			// If waited until middle of next bit, save bit, reset count, and increment to next bit
			// additionally, if next bit is more than number of bits per transfer, check final bit
			// else get more data
			GET_DATA: begin
				if ( count >= CLKS_PER_PERIOD ) begin
					count = 0;
					r_data[bit] = i_data;
					bit = bit + 1;

					if ( bit < NUM_BITS ) begin
						r_state = GET_DATA;
					end
					else begin
						r_state = CHECK_FB;
					end
				end
				else begin
					r_state = GET_DATA;
				end
			end

			// If incoming data has not reset to high, data may be corrupted, so throw out
			// else save set done bit to high so that o_data can be set to r_data
			CHECK_FB: begin
				if ( count >= CLKS_PER_PERIOD ) begin
					if ( i_data == 1'b1 ) begin
						r_state = RESET;
						r_done = 1'b1;
						count = 0;
					end
					else begin
						r_state = WAIT;
						count = 0;
					end
				end
				else begin
					r_state = CHECK_FB;
				end
			end
			
			// Return to WAIT
			RESET: begin
				r_state = WAIT;
			end
			
			// Default to WAIT state
			default: r_state = WAIT;

		endcase

		case ( r_state )
			WAIT: begin
				r_data = 0;
				r_done = 0;
				count = 0;
				bit = 0;
			end
			
			CHECK_SB: begin
				count = count + 1;
			end

			GET_DATA: begin
				count = count + 1;
			end

			CHECK_FB: begin
				count = count + 1;
			end

			RESET: begin
				count = 0;
				bit = 0;
			end
		endcase
	end
endmodule
