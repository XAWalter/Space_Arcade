module audio_note
	(
		input wire i_clk,
		input wire [23:0] i_freq,
		output wire o_pulse
	);


	// States
	parameter LOW = 1'b0;
	parameter HIGH = 1'b1;

	// Divider
	parameter CLK_FREQ = 12000000;
	wire [23:0] div;
	
	// Regs
	reg r_pulse;
	reg c_state = LOW;
	
	// counter
	integer i = 0;

	// Assignments
	assign o_pulse = ( i_freq > 0 ) ? r_pulse : 0;
	assign div = CLK_FREQ / (i_freq * 2);

	
	
		always @(posedge i_clk) begin
			
			// Transitions
			case (c_state)
				LOW: begin
					if ( i < div ) begin
						i <= i + 1;
						c_state <= LOW;
					end
					else begin
						//$display("%b", c_state);
						i <= 0;
						c_state <= HIGH;
					end
				end
		
				HIGH: begin
					if ( i < div ) begin
						i <= i + 1;
						c_state <= HIGH;
					end
					else begin
						//$display("%b", c_state);
						i <= 0;
						c_state <= LOW;
					end
				end
			endcase
		
			// Actions	
			case (c_state)
				LOW: begin
					r_pulse <= 0;
				end
		
				HIGH: begin
					r_pulse <= 1;
				end
			endcase
		
		end
	
endmodule
