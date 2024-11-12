`timescale 1ps / 1ps

module Testbench_memory_unit ();

	// creating logic signals
	logic op;  
	logic sel;
	//logic [2:0] address;
	logic [7:0] in_bus;
	logic [7:0] out_bus;
	logic [7:0] stored_value;
	
	// Initiate the DUT
	Memory_unit DUT (op, sel, /*address,*/ in_bus, out_bus, stored_value);	
	
	//Test cases
	initial begin
        // Display the header for the simulation results
        $display("Time\t\t\top\t\tsel\t\tadr\t\tin_bus\t\t | out_bus\t\tstored_value");
        $display("---------------------------------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t%b\t\t\t%b\t\t\t\t%b\t\t%b | %b\t%b", $time, op, sel, address, in_bus, out_bus, stored_value);
        
        // Apply different input combinations
			
		// Step 1: Write anything but sel_x is low
        op = 1; sel = 0; address=3'b000; in_bus = 8'b01010101;
        #10;
		
		op = 1; sel = 1; address=3'b000; in_bus = 8'b01010101;
        #10;
		op = 0; sel = 1; address=3'b000; in_bus = 8'b01010101;
        #10;
		op = 0; sel = 0; address=3'b000; in_bus = 8'b01010101;
        #10;
		
		$stop; 
	end
	
endmodule