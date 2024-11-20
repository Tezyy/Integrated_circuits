`timescale 1ps / 1ps

module SRAM_with_FSM (input op, select, [2:0] adr, [7:0] in, clk, output [7:0] out, valid, rw, A, B);
   
	// Call Memory Unit	
	Memory_unit SRAM (
		.op(rw), 
		.select(valid), 
		.address(adr), 
		.in_bus(in), 
		.out_bus(out)
	);	
	
	// Call FSM
	FSM fsm (
		.op(op), 
		.select(select), 
		.clk(clk), 
		.valid(valid), 
		.rw(rw), 
		.A(A), 
		.B(B)
	);

endmodule
