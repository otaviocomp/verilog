`include "mux.v"
module mux_tb();
	reg in0, in1, sel;
	wire out;
	initial begin
		$display("time\t in0\t in1\t sel\t out");
		$monitor("%g\t %b\t %b\t %b\t %b", $time, in0, in1, sel, out);
		in0 = 0;
		in1 = 0;
		sel = 0;
		#5 in0 = 1;
		#5 in0 = 0;
		   in1 = 1;
		#5 in0 = 1;
		#5 sel = 1;
		   in0 = 0;
		   in1 = 0;
		#5 in0 = 1;
		#5 in0 = 0;
		   in1 = 1;
		#5 in0 = 1;
		#5 $finish;
	end
	mux U_mux(in0, in1, sel, out);
endmodule	
