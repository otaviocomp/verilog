global Inst
{
	const NOP = 4d0;
	const LOAD = 4d1;
	const STORE	= 4d2;
	const SET = 4d3;
	const LT =4d4;
	const EQ = 4d5;
	const BEQ = 4d6;
	const BNEQ = 4d7;
	const ADD = 4d8;
	const SUB = 4d9;
	const SHL = 4d10;
	const SHR = 4d11;
	const AND = 4d12;
	const OR = 4d13;
	const INV = 4d14;
	const XOR = 4d15;
}

module CPU
(
	input clk,
	input rst,
	output write, 
	output read,
	output address[8],
	output dout [8],
	input din[8]
)
{
	.clk(clk), .rst(rst)
	{
		dff reg[16][8]; // CPU registers
	}

	instRom instRom;

	sig	op[4];
	sig arg1[4];
	sig arg2[4];
	sig dest[4];
	sig constant[8];

	always
	{
		write = 0;
		read = 0;
		address = 8hxx;
		dout = 8hxx;

		instRom.address = reg.q[0]];
		reg.d[0] = reg.q[0] + 1;
		
		op = instRom.inst[15:12];     
		dest = instRom.inst[11:8];    
		arg1 = instRom.inst[7:4];     
		arg2 = instRom.inst[3:0];     
		constant = instRom.inst[7:0];

		case (op) 
		{
			Inst.LOAD:
				read = 1;                                  // request a read
				reg.d[dest] = din;                         // save the data
				address = reg.q[arg1] + arg2;              // set the address
			Inst.STORE:
				write = 1;                                 // request a write
				dout = reg.q[dest];                        // output the data
				address = reg.q[arg1] + arg2;              // set the address
			Inst.SET:
				reg.d[dest] = constant;                    // set the reg to constant
			Inst.LT:
				reg.d[dest] = reg.q[arg1] < reg.q[arg2];   // less-than comparison
			Inst.EQ:
				reg.d[dest] = reg.q[arg1] == reg.q[arg2];  // equals comparison
			Inst.BEQ:
				if (reg.q[dest] == constant)               // if R[dest] == constant
					reg.d[0] = reg.q[0] + 2;                 // skip next instruction
			Inst.BNEQ:
				if (reg.q[dest] != constant)               // if R[dest] != constant
					reg.d[0] = reg.q[0] + 2;                 // skip next instruction
			Inst.ADD:
				reg.d[dest] = reg.q[arg1] + reg.q[arg2];   // addition
			Inst.SUB:
				reg.d[dest] = reg.q[arg1] - reg.q[arg2];   // subtraction
			Inst.SHL:
				reg.d[dest] = reg.q[arg1] << reg.q[arg2];  // shift left
			Inst.SHR:
				reg.d[dest] = reg.q[arg1] >> reg.q[arg2];  // shift right
			Inst.AND:
				reg.d[dest] = reg.q[arg1] & reg.q[arg2];   // bit-wise AND
			Inst.OR:
				reg.d[dest] = reg.q[arg1] | reg.q[arg2];   // bit-wise OR
			Inst.INV:
				reg.d[dest] = ~reg.q[arg1];                // bit-wise invert
			Inst.XOR:
				reg.d[dest] = reg.q[arg1] ^ reg.q[arg2];   // bit-wise XOR
    }
  }
}
