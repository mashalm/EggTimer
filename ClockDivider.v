module ClockDivider(clk, reset, clockOut);
	parameter frequency = 50000000;

	input clk, reset;
	output reg clockOut;
	///reg clockOut;
	//wire clockOut = clk;
	
	reg[31:0] counter = 0;

	always @ (posedge clk) begin
		counter <= counter + 1;
		if(reset == 1'b1)
			counter <= 32'd0;
		else begin
			if(counter == frequency) begin
				clockOut <= ~clockOut;
				counter <= 32'd0;
			end
		end //else
	end //always
endmodule