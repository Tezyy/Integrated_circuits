`timescale 1ps / 1ps

module Memory_unit_no_FSM (input rw, input valid, input [2:0] address, input [7:0] in_bus, output [7:0] out_bus, output [7:0] stored_value[7:0]);
	
	// Set up intermediate lines
	wire [7:0] sel_x;
	
	// CALL ADDRESS DECODER
	address_decoder ad (
		.valid(valid),
		.adr0(address[0]),
		.adr1(address[1]),
		.adr2(address[2]),
		.sel_x(sel_x)
	);	  		

	
	// Initiate 8 Wordcells
	genvar j;
	
	generate	
    	for (j = 0; j < 8; j = j + 1) begin : wordcell_array
			Wordcell wc (
				.rw(rw),
				.sel_x(sel_x[j]),
				.in_bus(in_bus),
				.out_bus(out_bus),
				.stored_data(stored_value[j])
            );
        end
    endgenerate

endmodule


module Memory_unit (input op, select, [2:0] adr, [7:0] in, clk, output [7:0] out, valid, rw, A, B);
   
	// Call Memory Unit	
	Memory_unit_no_FSM mu (
		.rw(rw), 
		.valid(valid), 
		.address(adr), 
		.in_bus(in), 
		.out_bus(out)
	);	
	
	// Call FSM
	FSM fsm (
		.op(op), 
		.select(select), 
		.clk(clk), 
		.valid(valid), 
		.rw(rw), 
		.A(A), 
		.B(B)
	);

endmodule


module Testbench_memory_unit ();

	reg op;
	reg select;
	reg clk;
	reg [2:0] adr;
	reg [7:0] in;
	wire valid;
	wire rw;
	wire A;
	wire B;
	wire [7:0] out;
	
	Memory_unit mu(
		.op(op), 
		.select(select), 
		.adr(adr), 
		.in(in), 
		.clk(clk), 
		.out(out), 
		.valid(valid), 
		.rw(rw), 
		.A(A), 
		.B(B)
	);	 
	
	// Set up a clock signal
	always begin
    	clk = 1;
    	#10;
    	clk = 0;
    	#10;
	end
	
	initial begin
		// Display the header for the simulation results
    	$display("   Time op select clk adr   in       | valid rw   AB    out");
    	$display("-------------------------------------------------------------");		
		
        
    	// Monitor signal changes and print them during simulation
    	$monitor("%4dns\t %b    %b     %b  %b   %b |  %b     %b   %b%b    %b" , $time, op, select, clk, adr, in, valid, rw, A, B, out);
		
		// First go in state 11 (idle) to define the FSM
		op=0; select=0; adr=3'b000; in=8'b00000000; #50; 
		
		// Write 01010101 to address 000
		op=1; select=1; adr=3'b000; in=8'b01010101; #40; 
		
		// Go to stable state
		op=0; select=0; #40;
		
		// Read the signal and stay there
		op=0; select=1; #120;

   		$stop;
	end
endmodule
