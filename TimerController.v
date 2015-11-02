module TimerController(clk, reset, set, startStop, isTimeFlat, swSecEn, swMinEn, 
decEn, flashEn, secsSet, minsSet);
	// all seven states 
	parameter Reset = 0, SetSec = 1, SetMin = 2, SetTimer = 3, RunTimer = 4, Flash = 5;
	parameter true = 1'b1, false = 1'b0;
	input clk, reset, set, startStop, isTimeFlat; // isTimeFlat is the flag when timer is done decrementing (when time is flat)
	output swSecEn, swMinEn, decEn, flashEn, secsSet, minsSet;
	
	// output flags for each state
	reg swSecEn, swMinEn, decEn, flashEn, secsSet, minsSet; // inRunTimerState is the selection bit in mux to choose between the data from swtich validator and the value from decrementor
	reg[2:0] state;
	always @(state) begin
		case (state) 
		/*
			Reset: begin
				swSecEn <= false;
				swMinEn <= false;
				decEn <= false;
				flashEn <= false;
				inRunTimerState <= false;
			end
			*/
			SetSec: begin
				swSecEn <= true;
				swMinEn <= false;
				decEn <= false;
				flashEn <= false;
			end
			SetMin: begin
				swSecEn <= false;
				swMinEn <= true;
				decEn <= false;
				flashEn <= false;
			end
			SetTimer: begin
				swSecEn <= false;
				swMinEn <= false;
				decEn <= false;
				flashEn <= false;
			end
			RunTimer: begin
				decEn <= true;
				swSecEn <= false;
				swMinEn <= false;
				flashEn <= false;
			end
			Flash: begin
				flashEn <= true; // turn on the LED
				swSecEn <= false;
				swMinEn <= false;
				decEn <= false;
			end
			default: begin
				swSecEn <= false;
				swMinEn <= false;
				decEn <= false;
				flashEn <= false;
			end
		endcase
	end

	
	// state transition goes here
	// reg reset, set, startStop, isTimeFlat;
	always @(negedge clk or negedge reset) begin
		secsSet <= false;
		minsSet <= false;
			case (state) 
				// in all states, if reset is 1 then do state <= Reset
				Reset: begin
					// after one clock cycle, move on to SetSec
					//state <= SetSec;
					if(set) begin
						state <= SetSec;
					end
				end
				SetSec: begin
					if (reset)
						state <= Reset;
					else if (set)
						state <= SetMin;
						secsSet <= true;
				end
				SetMin: begin
					if (reset)
						state <= Reset;
					else if (set)
						state <= SetTimer;
						minsSet <= true;
				end
				SetTimer: begin
					if (reset)
						state <= Reset;
					else if (startStop)
						state <= RunTimer;
				end
				RunTimer: begin
					if (reset)
						state <= Reset;
					else if (startStop)
						state <= SetTimer;
					else if (isTimeFlat)
						state <= Flash;
				end
				Flash: begin
					if (reset)
						state <= Reset;
				end
				default: begin
					state <= Reset;
					secsSet <= false;
					minsSet <= false;
				end
			endcase
	end	
endmodule