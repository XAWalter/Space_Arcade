module audio_note
	(
		input wire i_clk,
		output wire o_pulse
	);

	// Assignments
	assign o_pulse = r_pulse;
	
	// States
	parameter LOW = 1'b0;
	parameter HIGH = 1'b1;

	// Divider
	parameter DIV = 15000;
	
	
	// Regs
	reg r_pulse;
	reg c_state = LOW;
	
	// counter
	integer i = 0;
	
	
		always @(posedge i_clk) begin
			
			// Transitions
			case (c_state)
				LOW: begin
					if ( i < DIV ) begin
						i <= i + 1;
						c_state <= LOW;
					end
					else begin
						$display("%b", c_state);
						i <= 0;
						c_state <= HIGH;
					end
				end
		
				HIGH: begin
					if ( i < DIV ) begin
						i <= i + 1;
						c_state <= HIGH;
					end
					else begin
						$display("%b", c_state);
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
		


