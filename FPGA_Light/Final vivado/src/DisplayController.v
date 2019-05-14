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
    input      [2:0] cur_phase,  // Current phase
    input      [3:0] seven_num,
    //====================================================
    //=======           Output                      ======
    //====================================================
    // to VGADisplayer
    output     [2:0]  car_state,
    output     [3:0]  man_state,
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
	assign msk = 4'b1010;
	SevenSegment sevseg(clk, rst, nul, cur_phase, nul, seven_num, msk, seg, dp, an);

	assign led[15] = (man_state == 4'b0000)?1:0;
	assign led[14] = (man_state == 4'b0001)?1:0;
	assign led[13] = (man_state == 4'b0010)?1:0;
	assign led[12] = (man_state == 4'b0011)?1:0;
	assign led[11] = (man_state == 4'b0100)?1:0;
	assign led[10] = (man_state == 4'b0101)?1:0;
	assign led[9] = (man_state == 4'b0110)?1:0;
	assign led[8] = (man_state == 4'b0111)?1:0;
	assign led[7] = (man_state == 4'b1000)?1:0;
	assign led[6] = 0;
	assign led[5] = (car_state == 3'b100)?1:0;
	assign led[4] = (car_state == 3'b010)?1:0;
	assign led[3] = (car_state == 3'b001)?1:0;
	assign led[2] = 0;
	assign led[1] = (rst)?1:0;
	assign led[0] = (set)?1:0;
	
//=======================================
//============  counter part  ===========
//=======================================

	wire [21:0] counter;
	wire [21:0] counter_n;
	wire switch;
	wire switch2;
	
	assign switch = (counter==22'b1011111010111100001000)? 1 :0;
	assign switch2 = (counter[20:0]==21'b101111101011110000100)?1:0;
	
	DFF dff0  (counter[0 ], counter_n[0 ], clk, rst, 0);
	DFF dff1  (counter[1 ], counter_n[1 ], clk, rst, 0);
	DFF dff2  (counter[2 ], counter_n[2 ], clk, rst, 0);
	DFF dff3  (counter[3 ], counter_n[3 ], clk, rst, 0);
	DFF dff4  (counter[4 ], counter_n[4 ], clk, rst, 0);
	DFF dff5  (counter[5 ], counter_n[5 ], clk, rst, 0);
	DFF dff6  (counter[6 ], counter_n[6 ], clk, rst, 0);
	DFF dff7  (counter[7 ], counter_n[7 ], clk, rst, 0);
	DFF dff8  (counter[8 ], counter_n[8 ], clk, rst, 0);
	DFF dff9  (counter[9 ], counter_n[9 ], clk, rst, 0);
	DFF dff10 (counter[10], counter_n[10], clk, rst, 0);
	DFF dff11 (counter[11], counter_n[11], clk, rst, 0);
	DFF dff12 (counter[12], counter_n[12], clk, rst, 0);
	DFF dff13 (counter[13], counter_n[13], clk, rst, 0);
	DFF dff14 (counter[14], counter_n[14], clk, rst, 0);
	DFF dff15 (counter[15], counter_n[15], clk, rst, 0);
	DFF dff16 (counter[16], counter_n[16], clk, rst, 0);
	DFF dff17 (counter[17], counter_n[17], clk, rst, 0);
	DFF dff18 (counter[18], counter_n[18], clk, rst, 0);
	DFF dff19 (counter[19], counter_n[19], clk, rst, 0);
	DFF dff20 (counter[20], counter_n[20], clk, rst, 0);
	DFF dff21 (counter[21], counter_n[21], clk, rst, 0);
	
	assign counter_n[0] = ((switch&p[0])|(switch2&p[1]))? 0: ~counter[0];
	assign counter_n[1] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0])? ~counter[1]:counter[1];
	assign counter_n[2] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1])? ~counter[2]:counter[2];
	assign counter_n[3] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2])? ~counter[3]:counter[3];
	assign counter_n[4] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3])? ~counter[4]:counter[4];
	assign counter_n[5] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4])? ~counter[5]:counter[5];
	assign counter_n[6] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5])? ~counter[6]:counter[6];
	assign counter_n[7] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6])? ~counter[7]:counter[7];
	assign counter_n[8] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7])? ~counter[8]:counter[8];
	assign counter_n[9] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8])? ~counter[9]:counter[9];
	assign counter_n[10] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9])? ~counter[10]:counter[10];
	assign counter_n[11] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10])? ~counter[11]:counter[11];
	assign counter_n[12] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							)? ~counter[12]:counter[12];
	assign counter_n[13] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12])? ~counter[13]:counter[13];
	assign counter_n[14] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13])? ~counter[14]:counter[14];
	assign counter_n[15] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14])? ~counter[15]:counter[15];
	assign counter_n[16] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15])? ~counter[16]:counter[16];
	assign counter_n[17] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15]& counter[16])? ~counter[17]:counter[17];
	assign counter_n[18] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17])? ~counter[18]:counter[18];
	assign counter_n[19] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18])? ~counter[19]:counter[19];
	assign counter_n[20] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19])? ~counter[20]:counter[20];
	assign counter_n[21] = ((switch&p[0])|(switch2&p[1]))?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
							& counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20])? ~counter[21]:counter[21];

//=======================================
//=======  state description part  ======
//=======================================

    wire [3:0]man_state_n;
	
	DFF m0(man_state[0], man_state_n[0], clk, rst, 0);
	DFF m1(man_state[1], man_state_n[1], clk, rst, 0);
	DFF m2(man_state[2], man_state_n[2], clk, rst, 0);
	DFF m3(man_state[3], man_state_n[3], clk, rst, 0);
	
	wire x;
	XOR2 x0(cur_phase[2], cur_phase[1], x);	//don't walk
	wire [1:0]p;
	NOR3 n0(cur_phase[2], cur_phase[1], cur_phase[0], p[0]);	//slowly walk
	NOR3 n1(cur_phase[2], cur_phase[1], ~cur_phase[0], p[1]);	//fastly walk
	
	assign man_state_n[0]=((p[0]&switch)|(p[1]&switch2))?
	((~man_state[3])&(~man_state[0])|(man_state[3])):(x)?1'b0:(man_state[0]);
	
	wire hey;
	XOR2 xx(man_state[1], man_state[0], hey);
	assign man_state_n[1]=((p[0]&switch)|(p[1]&switch2))?
	((~man_state[3])&hey):(x)?1'b0:(man_state[1]);
	
	assign man_state_n[2]=((p[0]&switch)|(p[1]&switch2))?
	(((~man_state[3])&(man_state[2])&(~man_state[1]))|
	((~man_state[3])&(man_state[2])&(man_state[1])&(~man_state[0]))|
	((~man_state[3])&(~man_state[2])&(man_state[1])&(man_state[0]))):(x)?1'b0:(man_state[2]);
	
	assign man_state_n[3]=((p[0]&switch)|(p[1]&switch2))?
	((~man_state[3])&man_state[2]&man_state[1]&man_state[0]):(x)?1'b0:(man_state[3]);
 
	assign car_state[2] = cur_phase[2]&(~cur_phase[1])&(~cur_phase[0]);
	assign car_state[1] = (~cur_phase[2])&cur_phase[1]&cur_phase[0];
	assign car_state[0] = ((~cur_phase[2])&(~cur_phase[1]))|((~cur_phase[2])&(~cur_phase[0]));
	
endmodule
