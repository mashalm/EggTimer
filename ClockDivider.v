module ClockDivider(clk, reset, clockOut);
	parameter frequency = 50000000;

	input clk, reset;
	output clockOut;
	reg clkOut = 0;
	//wire clockOut = clk;
	
	assign clockOut = clkOut;
	
	reg[31:0] counter = 0;

	always @ (posedge clk) begin
		counter <= counter + 1;
		if(reset == 1'b1)
			counter <= 32'd0;
		else begin
			if(counter == frequency) begin
				clkOut <= ~clkOut;
				counter <= 32'd0;
			end
		end //else
	end //always
endmodule