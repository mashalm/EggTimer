module EggTimer(CLOCK_50, KEY, SW, HEX3, HEX2, HEX1, HEX0, LEDR);
	
	input CLOCK_50;
	input [2:0] KEY;
	input[7:0] SW;
	
	output[6:0] HEX3;
	output[6:0] HEX2;
	output[6:0] HEX1;
	output[6:0] HEX0;
	output[9:0] LEDR;
	
	wire reset = KEY[0];
	wire clk = CLOCK_50;
	
	//declare the wires for the controller here
	wire isTimeFlat = isSecsFlat & isMinsFlat;
	wire decEn, minsSet, secsSet, flashEn, inSetSecsState, inSetMinsState;
	//declare the controller itself here
	TimerController tc(.clk(clk), .reset(reset), .set(KEY[1]), .startStop(KEY[2]), 
	.isTimeFlat(isTimeFlat), .swSecEn(inSetSecsState), .swMinEn(inSetMinsState), 
	.decEn(decEn), .flashEn(flashEn), .secsSet(secsSet), .minsSet(minsSet));

	//these will be the regs holding the set values
	wire[7:0] initialSecsValue = (secsSet ? SW : 8'b00000000);
	wire[7:0] initialMinsValue = (minsSet ? SW : 8'b00000000);
	
	//clock divider for time decrementer
	wire oneSec;
	ClockDivider oneSecDiv(.clk(clk), .reset(reset), .clockOut(oneSec));
	
	wire[7:0] decrementedSecs;
	wire isSecsFlat;
	DecrementTime decSecs(.clk(clk), .writeEnable(secsSet), .decrementEnable(decEn & oneSec), 
		.inputTime(initialSecsValue), .outputTime(decrementedSecs), .isZero(isSecsFlat));
	
	wire[7:0] decrementedMins;
	wire isMinsFlat;
	DecrementTime decMins(.clk(clk), .writeEnable(minsSet), .decrementEnable(decEn & oneSec), 
		.inputTime(initialMinsValue), .outputTime(decrementedMins), .isZero(isMinsFlat));
	
	//clock divider for flashing lights
	wire halfSec;
	ClockDivider #(25000000) halfSecDiv(.clk(clk), .reset(reset), .clockOut(halfSec));

	FlashLights fl(.clk(clk), .flashEn(flashEn & halfSec), .ledr(LEDR));
	
	dec2_7seg d1(.num(inSetSecsState ? SW[3:0] : decrementedSecs[3:0]), .display(HEX0));
	dec2_7seg d2(.num(inSetSecsState ? SW[7:4] : decrementedSecs[7:4]), .display(HEX1));
	dec2_7seg d3(.num(inSetMinsState ? SW[3:0] : decrementedMins[3:0]), .display(HEX2));
	dec2_7seg d4(.num(inSetMinsState ? SW[7:4] : decrementedMins[7:4]), .display(HEX3));
	
endmodule