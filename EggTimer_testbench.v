`timescale 1ns / 1ps

module EggTimer_testbench;

	// inputs	
	reg CLOCK_50;
	reg[2:0]KEY;
	reg[7:0] SW;

	wire[6:0] HEX3, HEX2, HEX1, HEX0;
	wire[9:0] LEDR;

	// instantiation
	EggTimer et(CLOCK_50, KEY, SW, HEX3, HEX2, HEX1, HEX0, LEDR);

	initial begin
		CLOCK_50 = 1'b0;
		KEY[0] = 1'b0;
		
		#10;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);
		#10;
		KEY[1] = 1'b1;
		SW = 8'b000100010;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);
		
		#10;
		KEY[1] = 1'b1;
		SW = 8'b000110011;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);
		#10;
		KEY[1] = 1'b1;
		SW = 8'b001000001;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);
			
		#10;
		KEY[1] = 1'b0;
		KEY[2] = 1'b1;
		SW = 8'b011001000;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);

		#10;
		KEY[1] = 1'b0;
		KEY[2] = 1'b0;
		KEY[0] = 1'b1;
		SW = 8'b011001000;
		$display("reset = %d, set = %d, start/stop = %d, switches = %d, HEX0 = %d, HEX1 = %d, HEX2 = %d, HEX3 = %d", 
			KEY[0], KEY[1], KEY[2], SW, HEX0, HEX1, HEX2, HEX3);
			
		#10
		$finish;
	end
	
	always
		#5 CLOCK_50 = ~CLOCK_50;
endmodule