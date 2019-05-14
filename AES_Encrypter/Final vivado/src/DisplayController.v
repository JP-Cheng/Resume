//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: DisplayController: 
// From cur_phase/num to VGADisplayer & SevenSegment & led/dp
//////////////////////////////////////////////////////////////////////////////////

module DisplayController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input            clk,        // 25 MHz clock
    input            rst,        // Asynchronus reset
	input			 set,		 // set signal
    input      [3:0] cur_phase,  // Current phase
    input      [7:0] seven_num,
    //====================================================
    //=======           Output                      ======
    //====================================================
    // to VGADisplayer
    //output     [2:0]  car_state,
    //output     [3:0]  man_state,
    // from SevenSegment
    output     [6:0]  seg,
    output     [3:0]  an,
    output            dp,
    output     [15:0] led
    );
     
//=======================================
//=======          TODO            ======
//=======    Reuse SevenSegment    ======
//=======================================

	wire [3:0] nul;
	assign nul = 4'b0000;
	wire [3:0] msk;
	assign msk = 4'b0000;
	SevenSegment sevseg(clk, rst, nul, cur_phase, seven_num[7:4], seven_num[3:0], msk, seg, dp, an);

	assign led[15] = (rst)?1:0;
	assign led[14] = (set)?1:0;
		
endmodule
