//`timescale 1ps / 1ps
// `include "Address_decoder"
// `include "Wordcell"
`include "..\src\Wordcell.v"
`include "..\src\Address_decoder.v"

module Memory_unit (
input op, 
input select, 
input [2:0] address, 
input [7:0] in_bus, 
output [7:0] out_bus,
output [7:0] stored_data
);
	
	// Set up intermediate lines
	wire [7:0] sel_x;
	wire [7:0] intermediate_input = in_bus;
	
	// CALL ADDRESS DECODER
	address_decoder ad (
		.adr(address),
		.select(select),
		.sel_x(sel_x)
	);	  		

	
	// Initiate 8 Wordcells
	genvar i;
	
	generate	
    	for (i = 0; i < 8; i = i + 1) begin : wordcell_array
			Wordcell wc (
				.op(op),
				.sel_x(sel_x[i]),
				.in_bus(intermediate_input),
				.out_bus(out_bus),
				.stored_data(stored_data)
            );
        end
    endgenerate

endmodule
