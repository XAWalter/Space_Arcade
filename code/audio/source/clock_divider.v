module clk_divider #(parameter CLK_FREQ = 12000000)
	(
		input i_clk,
		input [23:0] i_freq,
		output o_clk
	);

	// divider
	wire [23:0] divider;
	assign divider = CLK_FREQ / i_freq;

	// counter
	reg [23:0] count = 0;

	// Assignments
	assign o_clk = ( count >= divider ) ? 1 : 0;

	always @(posedge i_clk) begin
		if ( count < divider ) begin
			count = count + 1;
		end
		else begin
			count = 0;
		end
	end

endmodule
