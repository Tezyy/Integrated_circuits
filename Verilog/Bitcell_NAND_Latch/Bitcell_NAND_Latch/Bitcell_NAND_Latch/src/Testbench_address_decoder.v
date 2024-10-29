`timescale 1ps/1ps

module testbench_decoder;
    // Declare inputs as reg
    reg adr0, adr1, adr2, E;

    // Declare output as wire
    wire Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7;
	

    Decoder_3_to_8 DUT(
        .adr0(adr0),
        .adr1(adr1),
        .adr2(adr2),
        .E(E),
        .Y0(Y0),
        .Y1(Y1),
        .Y2(Y2),
        .Y3(Y3),
        .Y4(Y4),
        .Y5(Y5),
        .Y6(Y6),
        .Y7(Y7)
    );
    initial begin 

    // Display the header for the simulation results
    $display("Time\t r_w sel inp E | Y0 Y1 Y2 Y3 Y4 Y5 Y6 Y7");
    $display("-----------------------------");
        
    // Monitor signal changes and print them during simulation
    $monitor("%4dns\t %b   %b   %b  %b  |  %b  %b  %b  %b  %b  %b  %b  %b", $time, adr0, adr1, adr2, E, Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7);
        
        adr0=0; adr1=0; adr2=0; E=0;
        adr0=0; adr1=0; adr2=1; E=0;
        adr0=0; adr1=1; adr2=0; E=0;
        adr0=0; adr1=1; adr2=1; E=0;
        adr0=1; adr1=0; adr2=0; E=0;
        adr0=1; adr1=0; adr2=1; E=0;
        adr0=1; adr1=1; adr2=0; E=0;
        adr0=1; adr1=1; adr2=1; E=0;

    //enable 1
        adr0=0; adr1=0; adr2=0; E=1;
        adr0=0; adr1=0; adr2=1; E=1;
        adr0=0; adr1=1; adr2=0; E=1;
        adr0=0; adr1=1; adr2=1; E=1;
        adr0=1; adr1=0; adr2=0; E=1;
        adr0=1; adr1=0; adr2=1; E=1;
        adr0=1; adr1=1; adr2=0; E=1;
        adr0=1; adr1=1; adr2=1; E=1;
      
    end
endmodule
