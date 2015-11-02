module FlashLights(clk, flashEn, ledr);

	input clk, flashEn;
	output[9:0] ledr;
	
	reg[9:0] ledr;
	
	always @(posedge clk) begin
		if(flashEn)
			ledr[9:0] = 10'b1111111111;
		else
			ledr[9:0] = 10'b0000000000;
	end

endmodule