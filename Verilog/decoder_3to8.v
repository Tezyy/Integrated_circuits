`timescale 1ps/1ps

module decoder_3to8(
    input adr0, adr1, adr2, E, // 3-bit address inputs and enable input
    output Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7 // 8 output lines
);

    wire not_adr0, not_adr1, not_adr2; // Inverted inputs

    // Not gates
    not (not_adr0, adr0);
    not (not_adr1, adr1);
    not (not_adr2, adr2);

    // Implement each output with 4-input AND gates
    and (Y0, not_adr0, not_adr1, not_adr2, E);
    and (Y1, not_adr0, not_adr1, adr2, E);
    and (Y2, not_adr0, adr1, not_adr2, E); 
    and (Y3, not_adr0, adr1, adr2, E); 
    and (Y4, adr0, not_adr1, not_adr2, E); 
    and (Y5, adr0, not_adr1, adr2, E);   
    and (Y6, adr0, adr1, not_adr2, E);   
    and (Y7, adr0, adr1, adr2, E);    

endmodule
