`timescale 1ps / 1ps

module comb_Logic(input A, B, op, select, output D_A, D_B, rw, valid);

	// Intermediate signals
	reg A_or_B;
	reg op_nand_sel; 
	reg not_A;
	reg not_B;
	reg not_sel;
	reg not_A_and_not_B;
	
	
	
	// D_A
	or (A_or_B, A, B);
	nand (op_nand_sel, op, select);
	and (D_A, A_or_B, op_nand_sel);
	
	// D_B 
	not (not_A, A);	
	not (not_B, B);
	not (not_sel, select);
	and (not_A_and_not_B, not_A, not_B);
	or (D_B, not_A_and_not_B, not_sel);	
	
	// rw and valid
	assign rw = not_A;
	assign valid = not_B;
	
endmodule


module d_flip_flop(input d, clk, output q);	  
	
	// Intermediate signals
	reg s;
	reg r;
	reg w1;
	reg w2;
	reg w3;
	reg qb;
	
	// Gates
	nand (w1, s, w2);
	nand (w2, d, r);
	not (w3, w1);
	nand (s, w1, clk);
	nand (r, w3, clk);
	nand (q, s, qb);
	nand (qb, q, r);
		
endmodule


module memory_elements(input D_A, D_B, clk, output A, B);
	 	
	d_flip_flop DFF_A (D_A, clk, A);
	d_flip_flop DFF_B (D_B, clk, B);
	
endmodule


module FSM(input op, select, clk, output valid, rw, A, B);
	
	comb_Logic cl (A, B, op, select, D_A, D_B, rw, valid);
	memory_elements me (D_A, D_B, clk, A, B);
	
endmodule


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
