`timescale 1ps / 1ps

module wordcell (input op, input sel_x, input [7:0] in_bus, output [7:0] out_bus, output [7:0] stored_data_bus);
 
	// Creating Intstances for 8 bitcells making up a word
	Bitcell_NAND bit0 (in_bus[0], sel_x, op, out_bus[0], stored_data_bus[0]);
	Bitcell_NAND bit1 (in_bus[1], sel_x, op, out_bus[1], stored_data_bus[1]);
	Bitcell_NAND bit2 (in_bus[2], sel_x, op, out_bus[2], stored_data_bus[2]); 
	Bitcell_NAND bit3 (in_bus[3], sel_x, op, out_bus[3], stored_data_bus[3]);
	Bitcell_NAND bit4 (in_bus[4], sel_x, op, out_bus[4], stored_data_bus[4]);
	Bitcell_NAND bit5 (in_bus[5], sel_x, op, out_bus[5], stored_data_bus[5]);
	Bitcell_NAND bit6 (in_bus[6], sel_x, op, out_bus[6], stored_data_bus[6]);
	Bitcell_NAND bit7 (in_bus[7], sel_x, op, out_bus[7], stored_data_bus[7]);	
	
endmodule