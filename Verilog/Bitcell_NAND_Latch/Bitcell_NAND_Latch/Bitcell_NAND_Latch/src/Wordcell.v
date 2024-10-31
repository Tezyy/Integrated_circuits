`timescale 1ps / 1ps

module Wordcell (input op, input sel_x, input [7:0] in_bus, output [7:0] out_bus, output [7:0] stored_data);
	
	// Use Generate to loop over Initialization
	genvar i;
	
	generate	
    	for (i = 0; i < 8; i = i + 1) begin : bitcell_array
			Bitcell_NAND bc (
				.in(in_bus[i]),
                .out(out_bus[i]),
                .r_w(op),
                .sel(sel_x),
				.stored_value(stored_data[i])
            );
        end
    endgenerate
endmodule