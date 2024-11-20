`timescale 1ps / 1ps

module fsm
    (
        input op,
        input sel,
        input clk,
        output valid,
        output rw
    );

    wire P0;
    wire P1;
    wire P2;
    wire P3;
    wire P4;
    

    and(P0, op, sel);
    or(P3, P0, P1);
    not(P1, P2);
    nand(P2, valid, rw);
    and(P4, P2, sel);


    flipflop ff1 (
        .inp(P4),
        .clk(clk),
        .outp(valid)
    );

    flipflop ff2 (
        .inp(P3),
        .clk(clk),
        .outp(rw)
    );
endmodule