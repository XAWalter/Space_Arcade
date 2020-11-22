module top(
	input CLK,
	input P2_3,
	output LEDR_N,
	output LEDG_N,
	output P1B1
);

	wire [7:0] w_data;
	wire w_done;
	reg r = 0;
	reg g = 1;

	assign P1B1 = CLK;

	assign LEDG_N = ~g;
	assign LEDR_N = ~r;

	uart_rx ur01(
		.i_clk(CLK),
		.i_data(P2_3),
		.o_data(w_data),
		.o_done(w_done)
	);

	always @(posedge w_done) begin
		if ( w_data == 8'h01 ) begin
			r = ~r;
		end
		g = ~g;
	end

endmodule

