`timescale 1ps / 1ps

module Memory_unit (input op, input select, input [2:0] address, input [7:0] in_bus, output [7:0] out_bus);

	// CALL ADDRESS DECODER
	// 
	//
	//
	//
	
	// Initiate 8 Wordcells
	genvar j;
	
	generate	
    	for (j = 0; j < 8; j = j + 1) begin : wordcell_array
			Wordcell wc (
				.op(op),
				.sel_x(/* output of address decoder: addres_decoder.sel[j]*/select),
				.in_bus(in_bus),
				.out_bus(out_bus)
            );
        end
    endgenerate

endmodule
