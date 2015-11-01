module EggTimer(CLOCK_50, KEY, SW, HEX3, HEX2, HEX1, HEX0, LEDR);
	
	input CLOCK_50;
	input [2:0] KEY;
	input[7:0] SW;
	
	output[6:0] HEX3;
	output[6:0] HEX2;
	output[6:0] HEX1;
	output[6:0] HEX0;
	output[9:0] LEDR;

endmodule