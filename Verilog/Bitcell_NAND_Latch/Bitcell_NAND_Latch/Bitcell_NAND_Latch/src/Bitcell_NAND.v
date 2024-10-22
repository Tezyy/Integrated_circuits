//-----------------------------------------------------------------------------
//
// Title       : Bitcell_NAND
// Design      : Bitcell_NAND_Latch
// Author      : Lukas
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:/dev/DIC_SRAM/Integrated_circuits/Verilog/Bitcell_NAND_Latch/Bitcell_NAND_Latch/Bitcell_NAND_Latch/src/Bitcell_NAND.v
// Generated   : Tue Oct 22 14:33:35 2024
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {Bitcell_NAND}}

module Bitcell_NAND ( in ,sel ,r_w ,out ,latch_nand1_out);

input in;
wire in;
input sel;
wire sel;
input r_w;
wire r_w;
output out;
wire out;

//}} End of automatically maintained section

// Enter your statements here //

// Intermediate signals
	output latch_nand1_out;

	wire nand1_out;
	wire nand2_out;
	wire latch_nand1_out;
	wire latch_nand2_out;
	wire not_r_w;
	
	
	// NAND1: in & sel & r_w = nand1_out  
	nand U1 (nand1_out, in, sel, r_w);
	
	// NAND2: sel & r_w & nand1_out = nand2_out
	nand U2 (nand2_out, sel, r_w, nand1_out);
	
	// LATCH NAND1: nand1_out & latch_nand2_out = latch_nand1_out
	nand U3 (latch_nand1_out, nand1_out, latch_nand2_out);
	
	// LATCH NAND2: nand2_out & latch_nand1_out = latch_nand2_out 
	nand U4 (latch_nand2_out, nand2_out, latch_nand1_out);
	
	// NOT for r_w
	not U5 (not_r_w, r_w);
	
	// AND: sel & not_r_w & latch_nand1_out = out
	and U6 (out, sel, not_r_w, latch_nand1_out);

endmodule
