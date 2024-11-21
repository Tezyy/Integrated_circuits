`timescale 1ps / 1ps

module SRAM_with_FSM (input op, select, [2:0] adr, [7:0] in, clk, output [7:0] out, valid, rw, A, B);
   
	// Call Memory Unit	
	Memory_unit SRAM (
		.op(rw), 
		.select(valid), 
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


module Testbench_SRAM_with_FSM ();

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
	
	SRAM_with_FSM DUT(
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
