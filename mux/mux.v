module mux(in0, in1, sel, out);
	input in0, in1, sel;
	output out;
	reg out;
	always @ (sel or in0 or in1)
	begin : MUX
		if(sel == 1'b0) begin
			out = in0;
		end
		else begin
			out = in1;
		end
	end	
endmodule
