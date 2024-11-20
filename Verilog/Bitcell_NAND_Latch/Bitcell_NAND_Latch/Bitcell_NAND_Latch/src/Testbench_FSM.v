`timescale 1ps / 1ps

module Testbench_FSM;

	reg select;
	reg op;	 
	reg clk;
	wire valid;
	wire rw;
	wire A;
	wire B;
	
	FSM DUT(
		.op(op), 
		.select(select), 
		.clk(clk),
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
    	$display("   Time op select clk | valid rw stateAB");
    	$display("--------------------------------------");		
		
        
    	// Monitor signal changes and print them during simulation
    	$monitor("%4dns\t %b    %b     %b  |  %b     %b   %b%b" , $time, op, select, clk, valid, rw, A, B);
		
		// First go in state 11 (idle) to define the FSM
		op=0; select=0; #50; 
		
		// Stay in state 11, by writing x0
      	op=0; select=0; #20; 
		op=1; select=0; #20;
		
		// Go to state 00
		op=1; select=1; #20; 
		
		// Checking state 00 to 01 by xx
		// Go to state 01 by 00
		op=0; select=0; #20;
		
		// Go to state 00
		op=1; select=1; #20;
			
		// Go to state 01 by 01
		op=0; select=1; #20;
		
		// Go to state 00
		op=1; select=1; #20;
		
		// Go to state 01 by 10
		op=1; select=0; #20;
		
		// Go to state 00
		op=1; select=1; #20;
		
		// Go to state 01 by 11
		op=1; select=1; #20;
		
		// Go to state 10
		op=0; select=1; #20;
		
		// Go to state 00
		op=1; select=1; #20;
		
		// Go to state 01
		op=1; select=1; #20;
		
		// Go to state 10
		op=0; select=1; #20;
		
		// Stay in state 10
		op=0; select=1; #20;
		
		// Check going to state 11 by x0
		// Go to state 11 by 00
		op=0; select=0; #20;  
		
		// Go to state 10
		op=0; select=1; #20;
		
		// Go to state 11 by 10
		op=1; select=0; #20;  
		
		// Check transistion 01 to 11 by x0
		// Go to 01			  
		op=1; select=1; #20;  
		op=0; select=0; #20;
		
		// Go to 11 by 00
		op=0; select=0; #20;
		
		// Go to 01
		op=1; select=1; #20;  
		op=0; select=0; #20;
		
		// Go to 11 by 10
		op=1; select=0; #20;
	
		
		$stop;
	end

endmodule
