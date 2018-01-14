`include "counter.v"
module counter_tb();
	reg clock, reset, enable;
	wire [3:0] out;
	initial begin
		$display("time\t clk reset enable counter");
		$monitor("%g\t %b %b %b %b", $time, clock, reset, enable, out);
		clock = 1;
		reset = 0;
		enable = 0;
		#5 reset = 1;
		#10 reset = 0;
		#5 enable = 1;
		#100 enable = 0;
		#10 $finish;
	end

	always begin
		#5 clock = ~clock;
	end

	counter U_counter(clock, reset, enable, out);
endmodule	
