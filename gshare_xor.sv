module gshare_xor(
	input logic [15:0] pc,
	input logic [2:0] globalhistory,
	output logic [2:0] xor_out
	);


	logic [2:0] pc_index;
	assign pc_index = pc[2:0];

	assign xor_out = pc_index^globalhistory;


endmodule