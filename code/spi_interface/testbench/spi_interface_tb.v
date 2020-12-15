`timescale 1ns/1ps
module spi_interface_tb;
	reg [7:0] i_data;
	reg i_data_ready;
	reg i_clk;
	wire o_mosi;
	wire o_s_clk;
	wire o_ss;
	wire o_done;

	spi_interface si01(
		.i_data(i_data),
		.i_data_ready(i_data_ready),
		.i_clk(i_clk),
		.o_mosi(o_mosi),
		.o_s_clk(o_s_clk),
		.o_ss(o_ss),
		.o_done(o_done)
	);

	initial begin
		i_clk = 0;
		forever begin
			i_clk = ~i_clk; #50;
		end
	end

	initial begin
		i_data = 8'b11110001;
		i_data_ready = 1'b0; #500;
		i_data_ready = 1'b1;
		#100000;
		i_data_ready = 1'b0; #500;
		i_data = 8'b00001110; #10;
		i_data_ready = 1'b1;

	end	


	initial begin
		$dumpfile(`DUMP_FILE_NAME);
		$dumpvars(0, spi_interface_tb);
	end
endmodule

