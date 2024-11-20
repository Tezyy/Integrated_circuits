`timescale 1ps / 1ps

module Bitcell_NAND (input in, input sel, input r_w, output out, output stored_value);

	// Intermediate signals
	wire nand1_out;
	wire nand2_out;

	wire latch_nand2_out;
	wire not_r_w; 
	
	wire low_impedance_output;
	
	
	// NAND1: in & sel & r_w = nand1_out  
	nand U1 (nand1_out, in, sel, r_w);
	
	// NAND2: sel & r_w & nand1_out = nand2_out
	nand U2 (nand2_out, sel, r_w, nand1_out);
	
	// LATCH NAND1: nand1_out & latch_nand2_out = latch_nand1_out = stored_value
	nand U3 (stored_value, nand1_out, latch_nand2_out);
	
	// LATCH NAND2: nand2_out & latch_nand1_out = latch_nand2_out 
	nand U4 (latch_nand2_out, nand2_out, stored_value);
	
	// NOT for r_w
	not U5 (not_r_w, r_w);
	
	// AND: sel & not_r_w & latch_nand1_out = out
	and U6 (low_impedance_output, sel, not_r_w, stored_value);	
	
	// Tristate buffer for output
	bufif1 U7 (out, low_impedance_output, sel);

endmodule
