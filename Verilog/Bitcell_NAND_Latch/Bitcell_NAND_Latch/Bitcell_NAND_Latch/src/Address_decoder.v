`timescale 1ps/1ps

module address_decoder(
    input [2:0] adr,
    input select,
	output [7:0] sel_x
);


    wire [2:0] not_adr; // Inverted inputs

    // Not gates
    not (not_adr[0], adr[0]);
    not (not_adr[1], adr[1]);
    not (not_adr[2], adr[2]);

    // Implement each output with 4 inputs AND gates
	and (sel_x[0],not_adr[0], not_adr[1], not_adr[2], select);
    and (sel_x[1],adr[0], not_adr[1], not_adr[2], select);
    and (sel_x[2],not_adr[0], adr[1], not_adr[2], select); 
    and (sel_x[3],adr[0], adr[1], not_adr[2], select); 
    and (sel_x[4],not_adr[0], not_adr[1], adr[2], select); 
    and (sel_x[5], adr[0], not_adr[1], adr[2], select);   
    and (sel_x[6], not_adr[0], adr[1], adr[2], select);   
    and (sel_x[7], adr[0], adr[1], adr[2], select); 

endmodule