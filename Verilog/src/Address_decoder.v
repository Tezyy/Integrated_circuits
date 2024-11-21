`timescale 1ps/1ps

module address_decoder(
    input adr0, adr1, adr2,
    input valid,
	output [7:0] sel_x
);

    wire not_adr0, not_adr1, not_adr2; // Inverted inputs

    // Not gates
    not (not_adr0, adr0);
    not (not_adr1, adr1);
    not (not_adr2, adr2);

    // Implement each output with 4 inputs AND gates
	and (sel_x[0], not_adr0, not_adr1, not_adr2, valid);
    and (sel_x[1], not_adr0, not_adr1, adr2, valid);
    and (sel_x[2], not_adr0, adr1, not_adr2, valid); 
    and (sel_x[3], not_adr0, adr1, adr2, valid); 
    and (sel_x[4], adr0, not_adr1, not_adr2, valid); 
    and (sel_x[5], adr0, not_adr1, adr2, valid);   
    and (sel_x[6], adr0, adr1, not_adr2, valid);   
    and (sel_x[7], adr0, adr1, adr2, valid); 

endmodule


module testbench_decoder;
 
	reg valid;
	reg [2:0] address;
	wire [7:0] sel_x;
	
	
    address_decoder DUT(
		.valid(valid),
		.adr0(address[0]),
        .adr1(address[1]),
        .adr2(address[2]),
		.sel_x(sel_x)
	);
	
	initial begin	
		// Display the header for the simulation results
    $display("Time\t address valid | sel_x");
    $display("-----------------------------");
        
    // Monitor signal changes and print them during simulation
    $monitor("%4dns\t %b   %b |  %b", $time, address, valid, sel_x);
	
		address=3'b000; valid=0; #10;
		address=3'b100; valid=0; #10;
		address=3'b010; valid=0; #10;
		address=3'b110; valid=0; #10;
		address=3'b001; valid=0; #10;
		address=3'b101; valid=0; #10;
		address=3'b011; valid=0; #10;
		address=3'b111; valid=0; #10; 
		
		address=3'b000; valid=1; #10;
		address=3'b100; valid=1; #10;
		address=3'b010; valid=1; #10;
		address=3'b110; valid=1; #10;
		address=3'b001; valid=1; #10;
		address=3'b101; valid=1; #10;
		address=3'b011; valid=1; #10;
		address=3'b111; valid=1; #10;
      	
		$stop;
    end
	
endmodule