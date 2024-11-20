`timescale 1ps / 1ps

module Wordcell (input op, input sel_x, input [7:0] in_bus, output [7:0] out_bus, output [7:0] stored_data);
	
	// Use Generate to loop over Initialization
	genvar i;
	
	generate	
    	for (i = 0; i < 8; i = i + 1) begin : bitcell_array
			Bitcell_NAND bc (
				.in(in_bus[i]),
                .out(out_bus[i]),
                .r_w(op),
                .sel(sel_x),
				.stored_value(stored_data[i])
            );
        end
    endgenerate
endmodule

module Testbench_wordcell ();

	// creating logic signals
	reg op;  
	reg sel_x;
	reg [7:0] in_bus;
	wire [7:0] out_bus;
	wire [7:0] stored_value;
	
	// Initiate the DUT
	Wordcell DUT (op, sel_x, in_bus, out_bus, stored_value);
	
	//Test cases
	initial begin
        // Display the header for the simulation results
        $display("Time\t\t\top\t\tsel_x\t\tin_bus\t\t | out_bus\t\tstored_value");
        $display("---------------------------------------------------");
        
        // Monitor signal changes and print them during simulation
        $monitor("%4dns\t%b\t\t\t%b\t\t\t\t\t\t%b | %b\t%b", $time, op, sel_x, in_bus, out_bus, stored_value);
        
        // Apply different input combinations
			
		// Step 1: Write anything but sel_x is low
        op = 1; sel_x = 0; in_bus = 8'b01010101;
        #10;
		
		// Step 2: Read anything but sel_x is low
        op = 0; sel_x = 0; in_bus = 8'b01010101;
        #10; 
		
		// Step 3: Read with input
        op = 0; sel_x = 1; in_bus = 8'b01010101;
        #10;
		
		// Step 4: Write input
        op = 1; sel_x = 1; in_bus = 8'b01010101;
        #10;
		
		// Step 5: Read stored_values
        op = 0; sel_x = 1; in_bus = 8'b00000000;
        #10;
		
		// Step 6: disable
        op = 0; sel_x = 0; in_bus = 8'b00000000;
        #10; 
		
		// Step 7: Write new values
        op = 1; sel_x = 1; in_bus = 8'b11001100;
        #10; 
		
		// Step 8: Read stored_values
        op = 0; sel_x = 1; in_bus = 8'b00000000;
        #10;
		
		
		$stop; 
	end

endmodule