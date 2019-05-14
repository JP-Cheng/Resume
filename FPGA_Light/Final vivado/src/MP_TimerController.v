//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: MP_TimerController, handle cur_phase , phase0_t~phase4_t
//////////////////////////////////////////////////////////////////////////////////

module MP_TimerController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk, // 25 MHz clock
    input                   rst, // Asynchronus reset
    input                   set, // 1 for set mode
    input                   buttonU, // Button Up
    input                   buttonD, // Button Down
    input                   buttonL, // Button Left
    input                   buttonR, // Button Right
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [2:0]        cur_phase,  // current phase for Display_Controller
    output     [3:0]        seven_num   // seven_num for Display_Controller    
    );

//========================================
//=======    WIRE declarations     =======
//========================================

	wire [2:0]phase_n;
	
	wire [3:0] num0;
	wire [3:0] num1;
	wire [3:0] num2;
	wire [3:0] num3;
	wire [3:0] num4;
	wire [3:0] num0_n;
	wire [3:0] num1_n;
	wire [3:0] num2_n;
	wire [3:0] num3_n;
	wire [3:0] num4_n;
	
	wire zero;
	wire z_sec;
	wire zz;
	
	wire U0;
	wire D0;
	wire U1;
	wire D1;
	wire U2;
	wire D2;
	wire U3;
	wire D3;
	wire U4;
	wire D4;
	
//=============================
//======  phase setting  ======
//=============================
	
	DFF dff_p0 (cur_phase[0], phase_n[0], clk, rst, 0);
	DFF dff_p1 (cur_phase[1], phase_n[1], clk, rst, 0);
	DFF dff_p2 (cur_phase[2], phase_n[2], clk, rst, 0);

	wire x1;
	XOR2 xor1(cur_phase[2], cur_phase[1], x1);
	wire x0;
	XOR2 xor0(cur_phase[1], cur_phase[0], x0);

	NOR4 n00(cur_sec_n[3], cur_sec_n[2], cur_sec_n[1], cur_sec_n[0], zero);
	
	wire [2:0]z;
	MUX21 m0(zz, (~cur_phase[2]&cur_phase[1]&cur_phase[0]), cur_phase[2], z[2]);
	MUX21 m1(zz, (~cur_phase[2]&x0), cur_phase[1], z[1]);
	MUX21 m2(zz, (~cur_phase[2]&~cur_phase[0]), cur_phase[0], z[0]);

	wire [2:0]l;
	MUX21 m9(buttonL, (~cur_phase[2]&cur_phase[1]&cur_phase[0]), z[2], l[2]);
	MUX21 m10(buttonL, (~cur_phase[2]&x0), z[1], l[1]);
	MUX21 m11(buttonL, (~cur_phase[2]&~cur_phase[0]), z[0], l[0]);

	wire [2:0]r;
	MUX21 m12(buttonR, ~(cur_phase[2]|cur_phase[1]|cur_phase[0]), l[2], r[2]);
	MUX21 m13(buttonR, ((~cur_phase[2]&cur_phase[1]&cur_phase[0])|(cur_phase[2]&~cur_phase[1]&~cur_phase[0])), l[1], r[1]);
	MUX21 m14(buttonR, (x1&~cur_phase[0]), l[0], r[0]);
	
	
	wire [2:0]L;
	MUX21 m3(buttonL, ((~cur_phase[2]&cur_phase[1]&cur_phase[0])|(cur_phase[2]&~cur_phase[1]&~cur_phase[0])), cur_phase[2], L[2]);
	MUX21 m4(buttonL, (~cur_phase[2]&x0), cur_phase[1], L[1]);
	MUX21 m5(buttonL, (~cur_phase[2]&~cur_phase[0]), cur_phase[0], L[0]);
	
	wire [2:0]R;
	MUX21 m6(buttonR, 1'b0, L[2], R[2]);
	MUX21 m7(buttonR, ((~cur_phase[2]&cur_phase[1]&cur_phase[0])|(cur_phase[2]&~cur_phase[1]&~cur_phase[0])), L[1], R[1]);
	MUX21 m8(buttonR, (x1&~cur_phase[0]), L[0], R[0]);
	
	MUX21 m15(set, R[2], r[2], phase_n[2]);
	MUX21 m16(set, R[1], r[1], phase_n[1]);
	MUX21 m17(set, R[0], r[0], phase_n[0]);
	
//===============================
//=====  time setting part  =====
//===============================
	
    DFF dff00 (num0[0], num0_n[0], clk, rst, 0);
	DFF dff01 (num0[1], num0_n[1], clk, rst, 0);
	DFF dff02 (num0[2], num0_n[2], clk, rst, 1);
	DFF dff03 (num0[3], num0_n[3], clk, rst, 0);
	//4'b0100==4
	DFF dff04 (num1[0], num1_n[0], clk, rst, 0);
	DFF dff05 (num1[1], num1_n[1], clk, rst, 0);
	DFF dff06 (num1[2], num1_n[2], clk, rst, 1);
	DFF dff07 (num1[3], num1_n[3], clk, rst, 0);
	DFF dff08 (num2[0], num2_n[0], clk, rst, 0);
	DFF dff09 (num2[1], num2_n[1], clk, rst, 0);
	DFF dff10 (num2[2], num2_n[2], clk, rst, 1);
	DFF dff11 (num2[3], num2_n[3], clk, rst, 0);
	DFF dff12 (num3[0], num3_n[0], clk, rst, 0);
	DFF dff13 (num3[1], num3_n[1], clk, rst, 0);
	DFF dff14 (num3[2], num3_n[2], clk, rst, 1);
	DFF dff15 (num3[3], num3_n[3], clk, rst, 0);
	DFF dff16 (num4[0], num4_n[0], clk, rst, 0);
	DFF dff17 (num4[1], num4_n[1], clk, rst, 0);
	DFF dff18 (num4[2], num4_n[2], clk, rst, 1);
	DFF dff19 (num4[3], num4_n[3], clk, rst, 0);

	assign U0 = buttonU & (cur_phase==3'b000) & (num0!=4'b1001) & (set==1'b1);
	assign D0 = buttonD & (cur_phase==3'b000) & (num0!=4'b0000) & (set==1'b1);
	assign U1 = buttonU & (cur_phase==3'b001) & (num1!=4'b1001) & (set==1'b1);
	assign D1 = buttonD & (cur_phase==3'b001) & (num1!=4'b0000) & (set==1'b1);
	assign U2 = buttonU & (cur_phase==3'b010) & (num2!=4'b1001) & (set==1'b1);
	assign D2 = buttonD & (cur_phase==3'b010) & (num2!=4'b0000) & (set==1'b1);
	assign U3 = buttonU & (cur_phase==3'b011) & (num3!=4'b1001) & (set==1'b1);
	assign D3 = buttonD & (cur_phase==3'b011) & (num3!=4'b0000) & (set==1'b1);
	assign U4 = buttonU & (cur_phase==3'b100) & (num4!=4'b1001) & (set==1'b1);
	assign D4 = buttonD & (cur_phase==3'b100) & (num4!=4'b0000) & (set==1'b1);

	
	assign num0_n[0] = (U0|D0)? ~num0[0]:num0[0];
	assign num0_n[1] = (U0 & num0[0])? ~num0[1]:(D0 & ~num0[0])?~num0[1]:num0[1];
	assign num0_n[2] = (U0 & num0[0]& num0[1])? ~num0[2]:(D0 & ~num0[0]& ~num0[1])?~num0[2]:num0[2];
	assign num0_n[3] = (U0 & num0[0]& num0[1]& num0[2])? ~num0[3]:(D0 & ~num0[0]& ~num0[1]& ~num0[2])?~num0[3]:num0[3];
	
	assign num1_n[0] = (U1|D1)? ~num1[0]:num1[0];
	assign num1_n[1] = (U1 & num1[0])? ~num1[1]:(D1 & ~num1[0])?~num1[1]:num1[1];
	assign num1_n[2] = (U1 & num1[0]& num1[1])? ~num1[2]:(D1 & ~num1[0]& ~num1[1])?~num1[2]:num1[2];
	assign num1_n[3] = (U1 & num1[0]& num1[1]& num1[2])? ~num1[3]:(D1 & ~num1[0]& ~num1[1]& ~num1[2])?~num1[3]:num1[3];
	
	assign num2_n[0] = (U2|D2)? ~num2[0]:num2[0];
	assign num2_n[1] = (U2 & num2[0])? ~num2[1]:(D2 & ~num2[0])?~num2[1]:num2[1];
	assign num2_n[2] = (U2 & num2[0]& num2[1])? ~num2[2]:(D2 & ~num2[0]& ~num2[1])?~num2[2]:num2[2];
	assign num2_n[3] = (U2 & num2[0]& num2[1]& num2[2])? ~num2[3]:(D2 & ~num2[0]& ~num2[1]& ~num2[2])?~num2[3]:num2[3];

	assign num3_n[0] = (U3|D3)? ~num3[0]:num3[0];
	assign num3_n[1] = (U3 & num3[0])? ~num3[1]:(D3 & ~num3[0])?~num3[1]:num3[1];
	assign num3_n[2] = (U3 & num3[0]& num3[1])? ~num3[2]:(D3 & ~num3[0]& ~num3[1])?~num3[2]:num3[2];
	assign num3_n[3] = (U3 & num3[0]& num3[1]& num3[2])? ~num3[3]:(D3 & ~num3[0]& ~num3[1]& ~num3[2])?~num3[3]:num3[3];

	assign num4_n[0] = (U4|D4)? ~num4[0]:num4[0];
	assign num4_n[1] = (U4 & num4[0])? ~num4[1]:(D4 & ~num4[0])?~num4[1]:num4[1];
	assign num4_n[2] = (U4 & num4[0]& num4[1])? ~num4[2]:(D4 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num4_n[3] = (U4 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D4 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];

//================================
//========   timer part   ========
//================================

	wire [3:0] new_sec_s;
	wire [3:0] set_sec;
	wire [3:0] next_sec;
	wire [3:0] pre_sec;
	wire [3:0] cur_sec_n;
	wire timer_set;
	Timer t0(clk, rst, timer_set, seven_num, cur_sec_n, z_sec);
	assign zz = z_sec&zero;
	
	assign seven_num = (timer_set)?new_sec_s:cur_sec_n;
	assign timer_set = set|zz|buttonL|buttonR|rst;
	assign set_sec = (cur_phase[2])?num4:(cur_phase[1])?((cur_phase[0])?num3:num2):((cur_phase[0])?num1:num0);
	assign next_sec = (cur_phase[2])?num0:(cur_phase[1])?((cur_phase[0])?num4:num3):((cur_phase[0])?num2:num1);
	assign pre_sec = (cur_phase[2])?num3:(cur_phase[1])?((cur_phase[0])?num2:num1):((cur_phase[0])?num0:num4);
	assign new_sec_s = (zz|buttonL)?next_sec:(buttonR)?pre_sec:set_sec;
	
endmodule
