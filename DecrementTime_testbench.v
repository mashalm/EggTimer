`timescale 1ns / 1ps

module DecrementTime_testbench;

	// inputs	
	reg clk, reset, decrementEnable, writeEnable;
	reg[7:0] inputTime;
	
	// outputs
	wire [7:0] outputTime;
	wire isZero;

	// instantiation
	DecrementTime dt(clk, reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);

	initial begin
		clk = 1'b0;
		reset = 1'b0;
		
		#10;
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
		 
		writeEnable = 1'b1;
		decrementEnable = 1'b0;
		inputTime = 8'b00100010;
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
		writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
			
			writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
			
			writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
			
			writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
			
			writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			
			
			writeEnable = 1'b0;
		decrementEnable = 1'b1;
		inputTime = 8'b00100010; //should not matter
		#10
		
		$display("reset = %d, wrtEn = %d, decEn = %d, inputTime = %d, outputTime = %d, isZero = %d", 
			reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);
			

		$finish;
	end
	
	always
		#5 clk = ~clk;
endmodule