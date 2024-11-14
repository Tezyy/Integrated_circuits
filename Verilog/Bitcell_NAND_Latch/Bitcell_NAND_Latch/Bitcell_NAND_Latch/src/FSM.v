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



module FSM(input op, select, clk, output valid, rw);
	
	comb_Logic cl (A, B, op, select, D_A, D_B, rw, valid);
	memory_elements me (D_A, D_B, clk, A, B);
	
endmodule