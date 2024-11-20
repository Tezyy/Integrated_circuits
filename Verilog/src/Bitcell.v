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


module testbench_bitcell;
    // Declare signals
    reg r_w;
    reg sel;
    reg in;	
    wire out;
	wire stored_value;

    // Instantiate the DUT (Device Under Test)
    Bitcell_NAND DUT (in, sel, r_w, out, stored_value);

    // Test cases
    initial begin
        // Display the header for the simulation results
        $display("Time\t r_w sel inp | out stored_value");
        $display("-----------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t %b   %b   %b  |  %b  %b", $time, r_w, sel, in, out, stored_value);
        
        // Apply different input combinations
			
		// Test case 1: r_w high, no result
        r_w = 1; sel = 0; in = 0;
        #10;	
		
		// Test case 2: all low, no result
        r_w = 0; sel = 0; in = 0;
        #10;
		
		// Test case 3: r_w high and input high, no result
        r_w = 1; sel = 0; in = 1;
        #10;
		
		// Test case 4: input high, no result
        r_w = 0; sel = 0; in = 1;
        #10;
		
		// Test case 5: write a zero, stored_value should be 0 now
        r_w = 1; sel = 1; in = 0;
        #10;
		
		// Test case 6: read result, out is 0
        r_w = 0; sel = 1; in = 0;
        #10;
		
		// Test case 7: read result while input 1, out is 0
        r_w = 0; sel = 1; in = 1;
        #10;
		
		// Test case 8: write a 1, stored_value should be 1
        r_w = 1; sel = 1; in = 1;
        #10;	  
		 r_w = 1; sel = 0; in = 1;
        #10;
		
		// Test case 9: read result, out is 1
        r_w = 0; sel = 1; in = 1;
        #10;
		
		// Test case 10: read result while input goes to 0, out is 1
        r_w = 0; sel = 1; in = 0;
        #10;
				

        $stop;
    end
endmodule
