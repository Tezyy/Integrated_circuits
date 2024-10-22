`timescale 1ns/1ps

module testbench_bitcell;
    // Declare inputs as reg
    reg r_w;
    reg sel;
    reg in;

    // Declare output as wire
    wire out;
	wire latch_nand1_out;

    // Instantiate the DUT (Device Under Test), which is the logic_circuit
    Bitcell_NAND DUT (
        .r_w(r_w),
        .sel(sel),
        .in(in),
        .out(out),
		.latch_nand1_out(latch_nand1_out)
    );

    // Test cases
    initial begin
        // Display the header for the simulation results
        $display("Time\t r_w sel inp | out stored_value");
        $display("-----------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t %b   %b   %b  |  %b  %b", $time, r_w, sel, in, out, latch_nand1_out);
        
        // Apply different input combinations
        // Format: r_w, sel, inp
			
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
		
		// Test case 9: read result, out is 1
        r_w = 0; sel = 1; in = 1;
        #10;
		
		// Test case 10: read result while input goes to 0, out is 1
        r_w = 0; sel = 1; in = 0;
        #10;
				
        
        // End the simulation
        $stop;
    end
endmodule
