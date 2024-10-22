//-----------------------------------------------------------------------------
//
// Title       : Verilog_NOR
// Design      : Bitcell_NOR
// Author      : Lukas
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:/dev/DIC_SRAM/Integrated_circuits/Verilog/Bitcell_XOR/Bitcell_XOR/src/Verilog_XOR.v
// Generated   : Tue Oct 22 11:26:16 2024
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
//{module {Verilog_XOR}}

module Verilog_XOR ( in ,r_w ,sel ,out );

input in;
wire in;
input r_w;
wire r_w;
input sel;
wire sel;
output out;
wire out;

//}} End of automatically maintained section

// Enter your statements here //	  

    // Intermediate signals
    wire nand1_out;
    wire nand2_out;
    wire nor1_out;
    wire nor2_out;
    wire not_r_w;
    wire not_in;

    // NOT gate for in (NOT(in))
    not U1 (not_in, in);

    // NAND1: r_w & sel & inp = nand1_out
    nand U2 (nand1_out, r_w, sel, in);

    // NAND2: r_w & sel & NOT(inp) = nand2_out
    nand U3 (nand2_out, r_w, sel, not_in);

    // NOR1: nand1_out & nor2_out = nor1_out
    nor U4 (nor1_out, nand1_out, nor2_out);

    // NOR2: nand2_out & nor1_out = nor2_out
    nor U5 (nor2_out, nand2_out, nor1_out);

    // NOT gate for r_w (NOT(r_w))
    not U6 (not_r_w, r_w);

    // NAND3: NOT(r_w) & nor2_out & sel = out
    nand U7 (out, not_r_w, nor2_out, sel);


endmodule
