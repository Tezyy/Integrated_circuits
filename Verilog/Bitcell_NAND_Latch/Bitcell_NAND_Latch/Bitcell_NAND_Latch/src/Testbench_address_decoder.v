`timescale 1ps/1ps

module testbench_decoder;
 
	logic select;
	logic [2:0] address;
	logic [7:0] sel_x;
	
	
    address_decoder DUT(
		.select(select),
		.adr0(address[0]),
        .adr1(address[1]),
        .adr2(address[2]),
		.sel_x(sel_x)
	);
	
	initial begin	
		// Display the header for the simulation results
    $display("Time\t address select | sel_x");
    $display("-----------------------------");
        
    // Monitor signal changes and print them during simulation
    $monitor("%4dns\t %b   %b |  %b", $time, address, select, sel_x);
	
		address=3'b000; select=0; #10;
		address=3'b100; select=0; #10;
		address=3'b010; select=0; #10;
		address=3'b110; select=0; #10;
		address=3'b001; select=0; #10;
		address=3'b101; select=0; #10;
		address=3'b011; select=0; #10;
		address=3'b111; select=0; #10; 
		
		address=3'b000; select=1; #10;
		address=3'b100; select=1; #10;
		address=3'b010; select=1; #10;
		address=3'b110; select=1; #10;
		address=3'b001; select=1; #10;
		address=3'b101; select=1; #10;
		address=3'b011; select=1; #10;
		address=3'b111; select=1; #10;
      	
		$stop;
    end
	
endmodule
