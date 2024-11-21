`timescale 1ps / 1ps

module Bitcell (input in, input sel, input rw, output out, output stored_value);

	// Intermediate signals
	wire nand1_out;
	wire nand2_out;

	wire latch_nand2_out;
	wire not_rw; 
	
	wire low_impedance_output;
	
	
	// NAND1: in & sel & rw = nand1_out  
	nand (nand1_out, in, sel, rw);
	
	// NAND2: sel & rw & nand1_out = nand2_out
	nand (nand2_out, sel, rw, nand1_out);
	
	// LATCH NAND1: nand1_out & latch_nand2_out = latch_nand1_out = stored_value
	nand (stored_value, nand1_out, latch_nand2_out);
	
	// LATCH NAND2: nand2_out & latch_nand1_out = latch_nand2_out 
	nand (latch_nand2_out, nand2_out, stored_value);
	
	// NOT for rw
	not (not_r_w, rw);
	
	// AND: sel & not_r_w & latch_nand1_out = low_impedance_output
	and (low_impedance_output, sel, not_r_w, stored_value);	
	
	// Tristate buffer for output
	bufif1 (out, low_impedance_output, sel);

endmodule


module testbench_bitcell;
    // Declare signals
    reg rw;
    reg sel;
    reg in;	
    wire out;
	wire stored_value;

    // Instantiate the DUT (Device Under Test)
    Bitcell_NAND DUT (in, sel, rw, out, stored_value);

    // Test cases
    initial begin
        // Display the header for the simulation results
        $display("Time\t rw sel inp | out stored_value");
        $display("-----------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t %b   %b   %b  |  %b  %b", $time, rw, sel, in, out, stored_value);
        
        // Apply different input combinations
			
		// Test case 1: r_w high, no result
        rw = 1; sel = 0; in = 0;
        #10;	
		
		// Test case 2: all low, no result
        rw = 0; sel = 0; in = 0;
        #10;
		
		// Test case 3: r_w high and input high, no result
        rw = 1; sel = 0; in = 1;
        #10;
		
		// Test case 4: input high, no result
        rw = 0; sel = 0; in = 1;
        #10;
		
		// Test case 5: write a zero, stored_value should be 0 now
        rw = 1; sel = 1; in = 0;
        #10;
		
		// Test case 6: read result, out is 0
        rw = 0; sel = 1; in = 0;
        #10;
		
		// Test case 7: read result while input 1, out is 0
        rw = 0; sel = 1; in = 1;
        #10;
		
		// Test case 8: write a 1, stored_value should be 1
        rw = 1; sel = 1; in = 1;
        #10;
		
		// Test case 9: read result, out is 1
        rw = 0; sel = 1; in = 1;
        #10;
		
		// Test case 10: read result while input goes to 0, out is 1
        rw = 0; sel = 1; in = 0;
        #10;
				

        $stop;
    end
endmodule
