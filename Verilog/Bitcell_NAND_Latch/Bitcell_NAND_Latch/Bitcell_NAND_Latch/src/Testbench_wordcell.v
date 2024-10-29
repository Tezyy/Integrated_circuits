`timescale 1ps / 1ps

module Testbench_wordcell ();

	// creating logic signals
	logic op;  
	logic sel_x;
	logic [7:0] in_bus;
	logic [7:0] out_bus;
	logic [7:0] stored_value;
	
	// Initiate the DUT
	wordcell DUT (op, sel_x, in_bus, out_bus, stored_value);
	
	//Test cases
	initial begin
        // Display the header for the simulation results
        $display("Time\t op sel_x in_bus | out_bus stored_value");
        $display("-----------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t %b   %b   %b  |  %b  %b", $time, op, sel_x, in_bus, out_bus, stored_value);
        
        // Apply different input combinations
			
		// Test case 1: r_w high, no result
        op = 1; sel_x = 0; in_bus = 8'b01010101;
        #10;
		
		$stop; 
	end

endmodule
