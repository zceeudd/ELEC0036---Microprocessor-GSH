module into_branch_mux1(
	input logic muxbranch1,
	input logic Dclear,
	output logic muxbranch1final
	);
	
	assign muxbranch1final = Dclear ? 1'b0 : muxbranch1;



endmodule
