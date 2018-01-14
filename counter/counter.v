module counter(clock, reset, enable, out);
	input clock;
	input reset;
	input enable;
	output [3:0] out;
	wire clock;
	wire reset;
	wire enable;
	reg [3:0]out;

	always @ (posedge clock)
	begin : COUNTER
		if(reset == 1'b1) begin
			out <= #1 4'b0000;
		end
		else if(enable == 1'b1) begin
			out <= #1 out + 1;
		end
	end
endmodule	
