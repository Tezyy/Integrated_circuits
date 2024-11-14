`timescale 1ps / 1ps

module Testbench_memory_unit ();

	// creating logic signals
	reg op;  
	reg sel;
	reg [2:0] address;
	reg [7:0] in_bus;
	wire [7:0] out_bus;
	//wire [7:0] stored_value[7:0];
	
	// Initiate the DUT
	Memory_unit DUT (
		.op(op), 
		.select(sel), 
		.address(address), 
		.in_bus(in_bus), 
		.out_bus(out_bus)
		//.stored_value(stored_value)
	);	
	
	//Test cases
	initial begin
        // Display the header for the simulation results
        $display("Time\t\t\top\t\tsel\t\tadr\t\tin_bus\t\t | out_bus\t\twc0\t\t\t\t\t\t\twc1\t\t\t\t\t\twc2\t\t\t\t\t\twc3\t\t\t\t\t\twc4\t\t\t\t\t\twc5\t\t\t\t\t\twc6\t\t\t\t\t\twc7");
        $display("------------------------------------------------------------------------------------------------------------------");
        
        // Monitor signal changes and print them during simulation
        //$monitor("%4dns\t%b\t\t\t\t%b\t\t\t%b\t\t%b | %b\t%b\t\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, sel, address, in_bus, out_bus, 
		
        // Flash 0 to all cells to make it defined
		op=1; sel=1; in_bus=8'b00000000; address=3'b000; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b001; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b010; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b011; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b100; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b101; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b110; #10;
		op=1; sel=1; in_bus=8'b00000000; address=3'b111; #10;
		
		
		// Apply different input combinations	   		
		op=1; sel=0; in_bus=8'b01010101; address=3'b000; //write
		#10;
		
		op=1; sel=1; in_bus=8'b01010101; address=3'b000; //write
		#10;
		sel=0;
		#10
		op=0; sel=1; in_bus=8'b01010101; address=3'b000; //read
		#10;
		sel=0;
		#10
		op=0; sel=0; in_bus=8'b01010101; address=3'b000; 
		#10; 

		op=0; sel=1; in_bus=8'b00000000; address=3'b100; 
		#10; 

		op=1; sel=1; in_bus=8'b11110000; address=3'b100; 
		#10;

		op=0; sel=1; in_bus=8'b00000000; address=3'b100; 
		#10; 
		
		
		$stop; 
	end
	
endmodule
