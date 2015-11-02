module DecrementTime(clk, reset, writeEnable, decrementEnable, inputTime, outputTime, isZero);

	input clk, reset, decrementEnable, writeEnable;
	input[7:0] inputTime;
	
	output reg [7:0] outputTime;
	output reg isZero;
	
	always @ (posedge clk) begin
		if(reset == 1'b1)
			outputTime <= 8'b00000000;
		else begin
			if(writeEnable == 1'b1)
				outputTime <= inputTime;
			else if(decrementEnable == 1'b1) begin
				outputTime <= outputTime - 8'b00000001;
				if(outputTime == 8'b00000000)
					isZero <= 1'b0;
				else if(outputTime[3:0] == 4'b1111)
					outputTime[3:0] <= 4'b1001;
			end //else if
		end //else
	end //always

endmodule