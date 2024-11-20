`timescale 1ps / 1ps

module Bitcell_NAND (
    input in,               // Input data
    input sel,              // Select signal
    input r_w,              // Read/Write control signal
    output out,             // Output signal
    output stored_value // Stored value in the bitcell
);

    // Intermediate signals
    wire nand1_out;
    wire nand2_out;
    wire latch_nand2_out;
    wire latch_nand1_out =0;
    wire not_r_w;

    // Initial condition for stored_value
  

    // NAND1: in & sel & r_w = nand1_out  
    nand U1 (nand1_out, in, sel, r_w);

    // NAND2: sel & r_w & nand1_out = nand2_out
    nand U2 (nand2_out, sel, r_w, nand1_out);

    // LATCH NAND1: nand1_out & latch_nand2_out = stored_value
    nand U3 (latch_nand1_out, nand1_out, latch_nand2_out);

    // LATCH NAND2: nand2_out & latch_nand1_out = latch_nand2_out 
    nand U4 (latch_nand2_out, nand2_out, latch_nand1_out);

    // NOT for r_w
    not U5 (not_r_w, r_w);

    // Output Logic (Read operation, r_w = 1)
    assign out = (sel && ~r_w) ? latch_nand1_out : 1'bz; // Read stored_value when r_w = 0
    assign stored_value = latch_nand1_out;
    // Write operation (update stored_value only when r_w = 0)
    //always @(posedge r_w or negedge r_w) begin
    //    if (~r_w) begin
    //        stored_value <= nand1_out; // Update stored_value only on write
    //    end
    //end

endmodule
