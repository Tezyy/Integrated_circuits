`timescale 1ps / 1ps

module Memory_unit (input op, input select, input [2:0] address, input [7:0] in_bus, output [7:0] out_bus, output [7:0] stored_value);
	
	// Set up intermediate lines
	wire [7:0] sel_x;
	
	// CALL ADDRESS DECODER
	address_decoder ad (
		.select(select),
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
				.op(op),
				.sel_x(sel_x[j]),
				.in_bus(in_bus),
				.out_bus(out_bus),
				.stored_data(stored_value)
            );
        end
    endgenerate

endmodule
