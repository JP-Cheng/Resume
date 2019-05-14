module(
	input	[127:0] num,	//want to random
	output	[127:0] ran
);

	initial begin
		assert(std::randomize(num));
		assign ran = num;
	end

endmodule