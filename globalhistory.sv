module globalhistory(
	input logic clk, Dstall,
	input logic [1:0] Dbranch,
	input logic branchcircuitout,
	output logic [2:0] globalhistoryout
	);

	reg globalhistorybit_1;
	reg globalhistorybit_2;
	reg globalhistorybit_3;
	
	//////UPDATING HISTORY///////////
	always_ff@(posedge clk) begin

		if((Dbranch==2'b01 || Dbranch==2'b00)&&(Dstall==1'b0)) begin
			globalhistorybit_1 <= branchcircuitout;
			globalhistorybit_2 <= globalhistorybit_1;
			globalhistorybit_3 <= globalhistorybit_2;
		end

		else begin
			globalhistorybit_1 <= globalhistorybit_1;
			globalhistorybit_2 <= globalhistorybit_2;
			globalhistorybit_3 <= globalhistorybit_3;
		end 
	end

	///////READING HISTORY/SELECTING PREDICTOR///
	logic branch_history1;
	logic branch_history2;
	logic branch_history3;

	assign branch_history1 = globalhistorybit_1;
	assign branch_history2 = globalhistorybit_2;
	assign branch_history3 = globalhistorybit_3;

	logic [2:0] branch_history;
	assign branch_history = {branch_history1,branch_history2,branch_history3};

	assign globalhistoryout = branch_history;


endmodule
