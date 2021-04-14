module processor2_tb();

	logic clk;

	processor2 processor2TEST(
	.clk(clk)
	);

	initial begin
	clk = 0;
	processor2TEST.processor2_datapath.data_PC.pc=16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[0] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[1] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[2] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[3] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[4] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[5] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[6] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_two_bit_branch_predictor.counters[7] = 16'b0000000000000000;
	processor2TEST.processor2_datapath.data_globalhistory.globalhistorybit_1 = 1'b0;
	processor2TEST.processor2_datapath.data_globalhistory.globalhistorybit_2 = 1'b0;
	processor2TEST.processor2_datapath.data_globalhistory.globalhistorybit_3 = 1'b0;
	$readmemh("cheeky.dat",processor2TEST.processor2_datapath.data_im.SRAM);
	processor2TEST.processor2_datapath.data_counter.counter = 8'b00000000;
	forever #10ps clk = ~clk;
	end

endmodule
	
