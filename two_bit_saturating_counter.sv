//our saturating counter for our two-bit predictor

module two_bit_saturating_counter(
	input logic clk, Dstall,
	input logic [17:0] Finstruction,
	input logic [2:0] globalhistoryout,
	input logic [2:0] Dglobalhistoryout,
	input logic Dbranchcircuitout,
	input logic [1:0] Dbranch,
	output logic muxbranch1
	);

	//table of counters (branch predictors)
	reg[1:0] counters[7:0];

	////////////////////UPDATING COUNTER////////////////
	always_ff@(posedge clk) begin
		if (counters[Dglobalhistoryout]==2'b00 && Dbranchcircuitout==1'b1 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <= 2'b01;
		end

		else if (counters[Dglobalhistoryout]==2'b01 && Dbranchcircuitout==1'b1 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <= 2'b11;
		end

		else if (counters[Dglobalhistoryout]==2'b10 && Dbranchcircuitout==1'b1 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <= 2'b11;
		end
		

		else if (counters[Dglobalhistoryout]==2'b11 && Dbranchcircuitout==1'b0 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <=2'b10;
		end

		else if (counters[Dglobalhistoryout]==2'b10 && Dbranchcircuitout==1'b0 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <=2'b00;
		end

		else if (counters[Dglobalhistoryout]==2'b01 && Dbranchcircuitout==1'b0 && (Dstall==1'b0) && (Dbranch==2'b00 || Dbranch==2'b01)) begin
			counters[Dglobalhistoryout] <=2'b00;
		end

		else begin
			counters[Dglobalhistoryout] <= counters[Dglobalhistoryout];
		end
	end

	/////////////////READING COUNTER////////////////////
	
	logic [5:0] branch_or_not; 
	assign branch_or_not = Finstruction[17:12];
	//opcode of our instruction to determine if its a branch
	
	//if we have a branch instruction, the branch mux select will read from the counter, if not then it will simply take 0
	assign muxbranch1 = (branch_or_not==6'b010001 || branch_or_not==6'b010010) ? ((counters[globalhistoryout]==2'b11 || counters[globalhistoryout]==2'b10) ? 1'b1 : 1'b0) : 1'b0;
	


endmodule