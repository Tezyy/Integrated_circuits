`timescale 1ps/1ps

module address_decoder(
    input adr0, adr1, adr2,
    input select,
	output [7:0] sel_x
);

    wire not_adr0, not_adr1, not_adr2; // Inverted inputs

    // Not gates
    not (not_adr0, adr0);
    not (not_adr1, adr1);
    not (not_adr2, adr2);

    // Implement each output with 4 inputs AND gates
	and (sel_x[0],not_adr0, not_adr1, not_adr2, select);
    and (sel_x[1],not_adr0, not_adr1, adr2, select);
    and (sel_x[2],not_adr0, adr1, not_adr2, select); 
    and (sel_x[3],not_adr0, adr1, adr2, select); 
    and (sel_x[4], adr0, not_adr1, not_adr2, select); 
    and (sel_x[5], adr0, not_adr1, adr2, select);   
    and (sel_x[6], adr0, adr1, not_adr2, select);   
    and (sel_x[7], adr0, adr1, adr2, select); 

endmodule