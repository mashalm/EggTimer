module DecrementTime(clk, reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);

	input clk, reset, decrementEnable, writeEnable;
	input[7:0] inputTime;
	
	output reg [7:0] outputTime;
	output reg isZero;
	
	always @ (posedge clk) begin
			//if(reset == 1'b1) begin
			//	outputTime <= 8'b00000000;
			//end
			if(writeEnable == 1'b1)
				outputTime <= inputTime;
			else if(decrementEnable == 1'b1) begin
				outputTime[3:0] <= outputTime[3:0] - 1'b0001;
				if(outputTime[3:0] == 4'b0000) begin
					outputTime[3:0] <= 4'b1001;
					outputTime[7:4] <= outputTime[7:4] - 4'b0001;
				end
				if(outputTime[7:0] == 8'b00000000) begin
					isZero <= 1'b1;
					outputTime[3:0] <= 4'b1001;
					outputTime[7:4] <= 4'b0101;
				end
			end //else if
		//end //else
	end //always

endmodule