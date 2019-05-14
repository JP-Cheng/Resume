//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: MP_TimerController, handle cur_phase , phase0_t~phase4_t
//////////////////////////////////////////////////////////////////////////////////

module AES_Encoder(
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
    output     [3:0]        cur_phase,  // current phase for Display_Controller
    output     [7:0]        seven_num   // seven_num for Display_Controller    
    );

//========================================
//=======    WIRE declarations     =======
//========================================

	wire [3:0]phase_n;
	
	wire [7:0] num0;
	wire [7:0] num1;
	wire [7:0] num2;
	wire [7:0] num3;
	wire [7:0] num4;
	wire [7:0] num5;
	wire [7:0] num6;
	wire [7:0] num7;
	wire [7:0] num8;
	wire [7:0] num9;
	wire [7:0] numA;
	wire [7:0] numB;
	wire [7:0] numC;
	wire [7:0] numD;
	wire [7:0] numE;
	wire [7:0] numF;
	wire [7:0] num0_n;
	wire [7:0] num1_n;
	wire [7:0] num2_n;
	wire [7:0] num3_n;
	wire [7:0] num4_n;
	wire [7:0] num5_n;
	wire [7:0] num6_n;
	wire [7:0] num7_n;
	wire [7:0] num8_n;
	wire [7:0] num9_n;
	wire [7:0] numA_n;
	wire [7:0] numB_n;
	wire [7:0] numC_n;
	wire [7:0] numD_n;
	wire [7:0] numE_n;
	wire [7:0] numF_n;
	
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
	wire U5;
	wire D5;
	wire U6;
	wire D6;
	wire U7;
	wire D7;
	wire U8;
	wire D8;
	wire U9;
	wire D9;
	wire UA;
	wire DA;
	wire UB;
	wire DB;
	wire UC;
	wire DC;
	wire UD;
	wire DD;
	wire UE;
	wire DE;
	wire UF;
	wire DF;
	
//=============================
//======  phase setting  ======
//=============================
	
	DFF dff_p0 (cur_phase[0], phase_n[0], clk, rst, 0);
	DFF dff_p1 (cur_phase[1], phase_n[1], clk, rst, 0);
	DFF dff_p2 (cur_phase[2], phase_n[2], clk, rst, 0);
	DFF dff_p3 (cur_phase[3], phase_n[3], clk, rst, 0);
	
	assign phase_n[0] = (buttonL|buttonR)?~cur_phase[0]:cur_phase[0];
	assign phase_n[1] = ((buttonR&cur_phase[0])|(buttonL&~cur_phase[0]))?~cur_phase[1]:cur_phase[1];
	assign phase_n[2] = ((buttonR&cur_phase[0]&cur_phase[1])|(buttonL&~cur_phase[0]&~cur_phase[1]))?~cur_phase[2]:cur_phase[2];
	assign phase_n[3] = ((buttonR&cur_phase[0]&cur_phase[1]&cur_phase[2])|(buttonL&~cur_phase[0]&~cur_phase[1]&~cur_phase[2]))?~cur_phase[3]:cur_phase[3];

//===============================
//=====  plaintext setting  =====
//===============================
	
    DFF dff00 (num0[0], num0_n[0], clk, rst, 0);
	DFF dff01 (num0[1], num0_n[1], clk, rst, 0);
	DFF dff02 (num0[2], num0_n[2], clk, rst, 0);
	DFF dff03 (num0[3], num0_n[3], clk, rst, 0);
	DFF df00 (num0[4], num0_n[4], clk, rst, 0);
	DFF df01 (num0[5], num0_n[5], clk, rst, 0);
	DFF df02 (num0[6], num0_n[6], clk, rst, 0);
	DFF df03 (num0[7], num0_n[7], clk, rst, 0);
	DFF dff04 (num1[0], num1_n[0], clk, rst, 0);
	DFF dff05 (num1[1], num1_n[1], clk, rst, 0);
	DFF dff06 (num1[2], num1_n[2], clk, rst, 0);
	DFF dff07 (num1[3], num1_n[3], clk, rst, 0);
	DFF df04 (num1[4], num1_n[4], clk, rst, 0);
	DFF df05 (num1[5], num1_n[5], clk, rst, 0);
	DFF df06 (num1[6], num1_n[6], clk, rst, 0);
	DFF df07 (num1[7], num1_n[7], clk, rst, 0);
	DFF dff08 (num2[0], num2_n[0], clk, rst, 0);
	DFF dff09 (num2[1], num2_n[1], clk, rst, 0);
	DFF dff10 (num2[2], num2_n[2], clk, rst, 0);
	DFF dff11 (num2[3], num2_n[3], clk, rst, 0);
	DFF dff12 (num3[0], num3_n[0], clk, rst, 0);
	DFF dff13 (num3[1], num3_n[1], clk, rst, 0);
	DFF dff14 (num3[2], num3_n[2], clk, rst, 0);
	DFF dff15 (num3[3], num3_n[3], clk, rst, 0);
	DFF dff16 (num4[0], num4_n[0], clk, rst, 0);
	DFF dff17 (num4[1], num4_n[1], clk, rst, 0);
	DFF dff18 (num4[2], num4_n[2], clk, rst, 0);
	DFF dff19 (num4[3], num4_n[3], clk, rst, 0);
    DFF dff20 (num5[0], num5_n[0], clk, rst, 0);
	DFF dff21 (num5[1], num5_n[1], clk, rst, 0);
	DFF dff22 (num5[2], num5_n[2], clk, rst, 0);
	DFF dff23 (num5[3], num5_n[3], clk, rst, 0);
	DFF dff24 (num6[0], num6_n[0], clk, rst, 0);
	DFF dff25 (num6[1], num6_n[1], clk, rst, 0);
	DFF dff26 (num6[2], num6_n[2], clk, rst, 0);
	DFF dff27 (num6[3], num6_n[3], clk, rst, 0);
	DFF dff28 (num7[0], num7_n[0], clk, rst, 0);
	DFF dff29 (num7[1], num7_n[1], clk, rst, 0);
	DFF dff30 (num7[2], num7_n[2], clk, rst, 0);
	DFF dff31 (num7[3], num7_n[3], clk, rst, 0);
	DFF dff32 (num8[0], num8_n[0], clk, rst, 0);
	DFF dff33 (num8[1], num8_n[1], clk, rst, 0);
	DFF dff34 (num8[2], num8_n[2], clk, rst, 0);
	DFF dff35 (num8[3], num8_n[3], clk, rst, 0);
	DFF dff36 (num9[0], num9_n[0], clk, rst, 0);
	DFF dff37 (num9[1], num9_n[1], clk, rst, 0);
	DFF dff38 (num9[2], num9_n[2], clk, rst, 0);
	DFF dff39 (num9[3], num9_n[3], clk, rst, 0);
    DFF dff40 (numA[0], numA_n[0], clk, rst, 0);
	DFF dff41 (numA[1], numA_n[1], clk, rst, 0);
	DFF dff42 (numA[2], numA_n[2], clk, rst, 0);
	DFF dff43 (numA[3], numA_n[3], clk, rst, 0);
	DFF dff44 (numB[0], numB_n[0], clk, rst, 0);
	DFF dff45 (numB[1], numB_n[1], clk, rst, 0);
	DFF dff46 (numB[2], numB_n[2], clk, rst, 0);
	DFF dff47 (numB[3], numB_n[3], clk, rst, 0);
	DFF dff48 (numC[0], numC_n[0], clk, rst, 0);
	DFF dff49 (numC[1], numC_n[1], clk, rst, 0);
	DFF dff50 (numC[2], numC_n[2], clk, rst, 0);
	DFF dff51 (numC[3], numC_n[3], clk, rst, 0);
	DFF dff52 (numD[0], numD_n[0], clk, rst, 0);
	DFF dff53 (numD[1], numD_n[1], clk, rst, 0);
	DFF dff54 (numD[2], numD_n[2], clk, rst, 0);
	DFF dff55 (numD[3], numD_n[3], clk, rst, 0);
	DFF dff56 (numE[0], numE_n[0], clk, rst, 0);
	DFF dff57 (numE[1], numE_n[1], clk, rst, 0);
	DFF dff58 (numE[2], numE_n[2], clk, rst, 0);
	DFF dff59 (numE[3], numE_n[3], clk, rst, 0);
	DFF dff60 (numF[0], numF_n[0], clk, rst, 0);
	DFF dff61 (numF[1], numF_n[1], clk, rst, 0);
	DFF dff62 (numF[2], numF_n[2], clk, rst, 0);
	DFF dff63 (numF[3], numF_n[3], clk, rst, 0);
	DFF df08 (num2[4], num2_n[4], clk, rst, 0);
	DFF df09 (num2[5], num2_n[5], clk, rst, 0);
	DFF df10 (num2[6], num2_n[6], clk, rst, 0);
	DFF df11 (num2[7], num2_n[7], clk, rst, 0);
	DFF df12 (num3[4], num3_n[4], clk, rst, 0);
	DFF df13 (num3[5], num3_n[5], clk, rst, 0);
	DFF df14 (num3[6], num3_n[6], clk, rst, 0);
	DFF df15 (num3[7], num3_n[7], clk, rst, 0);
	DFF df16 (num4[4], num4_n[4], clk, rst, 0);
	DFF df17 (num4[5], num4_n[5], clk, rst, 0);
	DFF df18 (num4[6], num4_n[6], clk, rst, 0);
	DFF df19 (num4[7], num4_n[7], clk, rst, 0);
    DFF df20 (num5[4], num5_n[4], clk, rst, 0);
	DFF df21 (num5[5], num5_n[5], clk, rst, 0);
	DFF df22 (num5[6], num5_n[6], clk, rst, 0);
	DFF df23 (num5[7], num5_n[7], clk, rst, 0);
	DFF df24 (num6[4], num6_n[4], clk, rst, 0);
	DFF df25 (num6[5], num6_n[5], clk, rst, 0);
	DFF df26 (num6[6], num6_n[6], clk, rst, 0);
	DFF df27 (num6[7], num6_n[7], clk, rst, 0);
	DFF df28 (num7[4], num7_n[4], clk, rst, 0);
	DFF df29 (num7[5], num7_n[5], clk, rst, 0);
	DFF df30 (num7[6], num7_n[6], clk, rst, 0);
	DFF df31 (num7[7], num7_n[7], clk, rst, 0);
	DFF df32 (num8[4], num8_n[4], clk, rst, 0);
	DFF df33 (num8[5], num8_n[5], clk, rst, 0);
	DFF df34 (num8[6], num8_n[6], clk, rst, 0);
	DFF df35 (num8[7], num8_n[7], clk, rst, 0);
	DFF df36 (num9[4], num9_n[4], clk, rst, 0);
	DFF df37 (num9[5], num9_n[5], clk, rst, 0);
	DFF df38 (num9[6], num9_n[6], clk, rst, 0);
	DFF df39 (num9[7], num9_n[7], clk, rst, 0);
    DFF df40 (numA[4], numA_n[4], clk, rst, 0);
	DFF df41 (numA[5], numA_n[5], clk, rst, 0);
	DFF df42 (numA[6], numA_n[6], clk, rst, 0);
	DFF df43 (numA[7], numA_n[7], clk, rst, 0);
	DFF df44 (numB[4], numB_n[4], clk, rst, 0);
	DFF df45 (numB[5], numB_n[5], clk, rst, 0);
	DFF df46 (numB[6], numB_n[6], clk, rst, 0);
	DFF df47 (numB[7], numB_n[7], clk, rst, 0);
	DFF df48 (numC[4], numC_n[4], clk, rst, 0);
	DFF df49 (numC[5], numC_n[5], clk, rst, 0);
	DFF df50 (numC[6], numC_n[6], clk, rst, 0);
	DFF df51 (numC[7], numC_n[7], clk, rst, 0);
	DFF df52 (numD[4], numD_n[4], clk, rst, 0);
	DFF df53 (numD[5], numD_n[5], clk, rst, 0);
	DFF df54 (numD[6], numD_n[6], clk, rst, 0);
	DFF df55 (numD[7], numD_n[7], clk, rst, 0);
	DFF df56 (numE[4], numE_n[4], clk, rst, 0);
	DFF df57 (numE[5], numE_n[5], clk, rst, 0);
	DFF df58 (numE[6], numE_n[6], clk, rst, 0);
	DFF df59 (numE[7], numE_n[7], clk, rst, 0);
	DFF df60 (numF[4], numF_n[4], clk, rst, 0);
	DFF df61 (numF[5], numF_n[5], clk, rst, 0);
	DFF df62 (numF[6], numF_n[6], clk, rst, 0);
	DFF df63 (numF[7], numF_n[7], clk, rst, 0);
	
	assign U0 = buttonU & (cur_phase==4'b0000) & (num0!=8'b11111111) & (set==1'b1);
	assign D0 = buttonD & (cur_phase==4'b0000) & (num0!=8'b00000000) & (set==1'b1);
	assign U1 = buttonU & (cur_phase==4'b0001) & (num1!=8'b11111111) & (set==1'b1);
	assign D1 = buttonD & (cur_phase==4'b0001) & (num1!=8'b00000000) & (set==1'b1);
	assign U2 = buttonU & (cur_phase==4'b0010) & (num2!=8'b11111111) & (set==1'b1);
	assign D2 = buttonD & (cur_phase==4'b0010) & (num2!=8'b00000000) & (set==1'b1);
	assign U3 = buttonU & (cur_phase==4'b0011) & (num3!=8'b11111111) & (set==1'b1);
	assign D3 = buttonD & (cur_phase==4'b0011) & (num3!=8'b00000000) & (set==1'b1);
	assign U4 = buttonU & (cur_phase==4'b0100) & (num4!=8'b11111111) & (set==1'b1);
	assign D4 = buttonD & (cur_phase==4'b0100) & (num4!=8'b00000000) & (set==1'b1);
	assign U5 = buttonU & (cur_phase==4'b0101) & (num5!=8'b11111111) & (set==1'b1);
	assign D5 = buttonD & (cur_phase==4'b0101) & (num5!=8'b00000000) & (set==1'b1);
	assign U6 = buttonU & (cur_phase==4'b0110) & (num6!=8'b11111111) & (set==1'b1);
	assign D6 = buttonD & (cur_phase==4'b0110) & (num6!=8'b00000000) & (set==1'b1);
	assign U7 = buttonU & (cur_phase==4'b0111) & (num7!=8'b11111111) & (set==1'b1);
	assign D7 = buttonD & (cur_phase==4'b0111) & (num7!=8'b00000000) & (set==1'b1);
	assign U8 = buttonU & (cur_phase==4'b1000) & (num8!=8'b11111111) & (set==1'b1);
	assign D8 = buttonD & (cur_phase==4'b1000) & (num8!=8'b00000000) & (set==1'b1);
	assign U9 = buttonU & (cur_phase==4'b1001) & (num9!=8'b11111111) & (set==1'b1);
	assign D9 = buttonD & (cur_phase==4'b1001) & (num9!=8'b00000000) & (set==1'b1);
	assign UA = buttonU & (cur_phase==4'b1010) & (numA!=8'b11111111) & (set==1'b1);
	assign DA = buttonD & (cur_phase==4'b1010) & (numA!=8'b00000000) & (set==1'b1);
	assign UB = buttonU & (cur_phase==4'b1011) & (numB!=8'b11111111) & (set==1'b1);
	assign DB = buttonD & (cur_phase==4'b1011) & (numB!=8'b00000000) & (set==1'b1);
	assign UC = buttonU & (cur_phase==4'b1100) & (numC!=8'b11111111) & (set==1'b1);
	assign DC = buttonD & (cur_phase==4'b1100) & (numC!=8'b00000000) & (set==1'b1);
	assign UD = buttonU & (cur_phase==4'b1101) & (numD!=8'b11111111) & (set==1'b1);
	assign DD = buttonD & (cur_phase==4'b1101) & (numD!=8'b00000000) & (set==1'b1);
	assign UE = buttonU & (cur_phase==4'b1110) & (numE!=8'b11111111) & (set==1'b1);
	assign DE = buttonD & (cur_phase==4'b1110) & (numE!=8'b00000000) & (set==1'b1);
	assign UF = buttonU & (cur_phase==4'b1111) & (numF!=8'b11111111) & (set==1'b1);
	assign DF = buttonD & (cur_phase==4'b1111) & (numF!=8'b00000000) & (set==1'b1);
	
	assign num0_n[0] = (U0|D0)? ~num0[0]:num0[0];
	assign num0_n[1] = (U0 & num0[0])? ~num0[1]:(D0 & ~num0[0])?~num0[1]:num0[1];
	assign num0_n[2] = (U0 & num0[0]& num0[1])? ~num0[2]:(D0 & ~num0[0]& ~num0[1])?~num0[2]:num0[2];
	assign num0_n[3] = (U0 & num0[0]& num0[1]& num0[2])? ~num0[3]:(D0 & ~num0[0]& ~num0[1]& ~num0[2])?~num0[3]:num0[3];
	assign num0_n[4] = (U0 & num0[0]& num0[1]& num0[2]& num0[3])? ~num0[4]:(D0 & ~num0[0]& ~num0[1]& ~num0[2]& ~num0[3])?~num0[4]:num0[4];
	assign num0_n[5] = (U0 & num0[0]& num0[1]& num0[2]& num0[3]& num0[4])? ~num0[5]:(D0 & ~num0[0]& ~num0[1]& ~num0[2]& ~num0[3]& ~num0[4])?~num0[5]:num0[5];
	assign num0_n[6] = (U0 & num0[0]& num0[1]& num0[2]& num0[3]& num0[4]& num0[5])? ~num0[6]:(D0 & ~num0[0]& ~num0[1]& ~num0[2]& ~num0[3]& ~num0[4]& ~num0[5])?~num0[6]:num0[6];
	assign num0_n[7] = (U0 & num0[0]& num0[1]& num0[2]& num0[3]& num0[4]& num0[5]& num0[6])? ~num0[7]:(D0 & ~num0[0]& ~num0[1]& ~num0[2]& ~num0[3]& ~num0[4]& ~num0[5]& ~num0[6])?~num0[7]:num0[7];
	
	assign num1_n[0] = (U1|D1)? ~num1[0]:num1[0];
	assign num1_n[1] = (U1 & num1[0])? ~num1[1]:(D1 & ~num1[0])?~num1[1]:num1[1];
	assign num1_n[2] = (U1 & num1[0]& num1[1])? ~num1[2]:(D1 & ~num1[0]& ~num1[1])?~num1[2]:num1[2];
	assign num1_n[3] = (U1 & num1[0]& num1[1]& num1[2])? ~num1[3]:(D1 & ~num1[0]& ~num1[1]& ~num1[2])?~num1[3]:num1[3];
	assign num1_n[4] = (U0 & num1[0]& num1[1]& num1[2]& num1[3])? ~num1[4]:(D0 & ~num1[0]& ~num1[1]& ~num1[2]& ~num1[3])?~num1[4]:num1[4];
	assign num1_n[5] = (U0 & num1[0]& num1[1]& num1[2]& num1[3]& num1[4])? ~num1[5]:(D0 & ~num1[0]& ~num1[1]& ~num1[2]& ~num1[3]& ~num1[4])?~num1[5]:num1[5];
	assign num1_n[6] = (U0 & num1[0]& num1[1]& num1[2]& num1[3]& num1[4]& num1[5])? ~num1[6]:(D0 & ~num1[0]& ~num1[1]& ~num1[2]& ~num1[3]& ~num1[4]& ~num1[5])?~num1[6]:num1[6];
	assign num1_n[7] = (U0 & num1[0]& num1[1]& num1[2]& num1[3]& num1[4]& num1[5]& num1[6])? ~num1[7]:(D0 & ~num1[0]& ~num1[1]& ~num1[2]& ~num1[3]& ~num1[4]& ~num1[5]& ~num1[6])?~num1[7]:num1[7];
	
	assign num2_n[0] = (U2|D2)? ~num2[0]:num2[0];
	assign num2_n[1] = (U2 & num2[0])? ~num2[1]:(D2 & ~num2[0])?~num2[1]:num2[1];
	assign num2_n[2] = (U2 & num2[0]& num2[1])? ~num2[2]:(D2 & ~num2[0]& ~num2[1])?~num2[2]:num2[2];
	assign num2_n[3] = (U2 & num2[0]& num2[1]& num2[2])? ~num2[3]:(D2 & ~num2[0]& ~num2[1]& ~num2[2])?~num2[3]:num2[3];
	assign num2_n[4] = (U0 & num2[0]& num2[1]& num2[2]& num2[3])? ~num2[4]:(D0 & ~num2[0]& ~num2[1]& ~num2[2]& ~num2[3])?~num2[4]:num2[4];
	assign num2_n[5] = (U0 & num2[0]& num2[1]& num2[2]& num2[3]& num2[4])? ~num2[5]:(D0 & ~num2[0]& ~num2[1]& ~num2[2]& ~num2[3]& ~num2[4])?~num2[5]:num2[5];
	assign num2_n[6] = (U0 & num2[0]& num2[1]& num2[2]& num2[3]& num2[4]& num2[5])? ~num2[6]:(D0 & ~num2[0]& ~num2[1]& ~num2[2]& ~num2[3]& ~num2[4]& ~num2[5])?~num2[6]:num2[6];
	assign num2_n[7] = (U0 & num2[0]& num2[1]& num2[2]& num2[3]& num2[4]& num2[5]& num2[6])? ~num2[7]:(D0 & ~num2[0]& ~num2[1]& ~num2[2]& ~num2[3]& ~num2[4]& ~num2[5]& ~num2[6])?~num2[7]:num2[7];
	
	assign num3_n[0] = (U3|D3)? ~num3[0]:num3[0];
	assign num3_n[1] = (U3 & num3[0])? ~num3[1]:(D3 & ~num3[0])?~num3[1]:num3[1];
	assign num3_n[2] = (U3 & num3[0]& num3[1])? ~num3[2]:(D3 & ~num3[0]& ~num3[1])?~num3[2]:num3[2];
	assign num3_n[3] = (U3 & num3[0]& num3[1]& num3[2])? ~num3[3]:(D3 & ~num3[0]& ~num3[1]& ~num3[2])?~num3[3]:num3[3];
	assign num3_n[4] = (U0 & num3[0]& num3[1]& num3[2]& num3[3])? ~num3[4]:(D0 & ~num3[0]& ~num3[1]& ~num3[2]& ~num3[3])?~num3[4]:num3[4];
	assign num3_n[5] = (U0 & num3[0]& num3[1]& num3[2]& num3[3]& num3[4])? ~num3[5]:(D0 & ~num3[0]& ~num3[1]& ~num3[2]& ~num3[3]& ~num3[4])?~num3[5]:num3[5];
	assign num3_n[6] = (U0 & num3[0]& num3[1]& num3[2]& num3[3]& num3[4]& num3[5])? ~num3[6]:(D0 & ~num3[0]& ~num3[1]& ~num3[2]& ~num3[3]& ~num3[4]& ~num3[5])?~num3[6]:num3[6];
	assign num3_n[7] = (U0 & num3[0]& num3[1]& num3[2]& num3[3]& num3[4]& num3[5]& num3[6])? ~num3[7]:(D0 & ~num3[0]& ~num3[1]& ~num3[2]& ~num3[3]& ~num3[4]& ~num3[5]& ~num3[6])?~num3[7]:num3[7];
	
	assign num4_n[0] = (U4|D4)? ~num4[0]:num4[0];
	assign num4_n[1] = (U4 & num4[0])? ~num4[1]:(D4 & ~num4[0])?~num4[1]:num4[1];
	assign num4_n[2] = (U4 & num4[0]& num4[1])? ~num4[2]:(D4 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num4_n[3] = (U4 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D5 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num4_n[4] = (U0 & num4[0]& num4[1]& num4[2]& num4[3])? ~num4[4]:(D0 & ~num4[0]& ~num4[1]& ~num4[2]& ~num4[3])?~num4[4]:num4[4];
	assign num4_n[5] = (U0 & num4[0]& num4[1]& num4[2]& num4[3]& num4[4])? ~num4[5]:(D0 & ~num4[0]& ~num4[1]& ~num4[2]& ~num4[3]& ~num4[4])?~num4[5]:num4[5];
	assign num4_n[6] = (U0 & num4[0]& num4[1]& num4[2]& num4[3]& num4[4]& num4[5])? ~num4[6]:(D0 & ~num4[0]& ~num4[1]& ~num4[2]& ~num4[3]& ~num4[4]& ~num4[5])?~num4[6]:num4[6];
	assign num4_n[7] = (U0 & num4[0]& num4[1]& num4[2]& num4[3]& num4[4]& num4[5]& num4[6])? ~num4[7]:(D0 & ~num4[0]& ~num4[1]& ~num4[2]& ~num4[3]& ~num4[4]& ~num4[5]& ~num4[6])?~num4[7]:num4[7];
	
	assign num5_n[0] = (U5|D5)? ~num4[0]:num4[0];
	assign num5_n[1] = (U5 & num4[0])? ~num4[1]:(D5 & ~num4[0])?~num4[1]:num4[1];
	assign num5_n[2] = (U5 & num4[0]& num4[1])? ~num4[2]:(D5 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num5_n[3] = (U5 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D5 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num5_n[4] = (U0 & num5[0]& num5[1]& num5[2]& num5[3])? ~num5[4]:(D0 & ~num5[0]& ~num5[1]& ~num5[2]& ~num5[3])?~num5[4]:num5[4];
	assign num5_n[5] = (U0 & num5[0]& num5[1]& num5[2]& num5[3]& num5[4])? ~num5[5]:(D0 & ~num5[0]& ~num5[1]& ~num5[2]& ~num5[3]& ~num5[4])?~num5[5]:num5[5];
	assign num5_n[6] = (U0 & num5[0]& num5[1]& num5[2]& num5[3]& num5[4]& num5[5])? ~num5[6]:(D0 & ~num5[0]& ~num5[1]& ~num5[2]& ~num5[3]& ~num5[4]& ~num5[5])?~num5[6]:num5[6];
	assign num5_n[7] = (U0 & num5[0]& num5[1]& num5[2]& num5[3]& num5[4]& num5[5]& num5[6])? ~num5[7]:(D0 & ~num5[0]& ~num5[1]& ~num5[2]& ~num5[3]& ~num5[4]& ~num5[5]& ~num5[6])?~num5[7]:num5[7];
	
	assign num6_n[0] = (U6|D6)? ~num4[0]:num4[0];
	assign num6_n[1] = (U6 & num4[0])? ~num4[1]:(D6 & ~num4[0])?~num4[1]:num4[1];
	assign num6_n[2] = (U6 & num4[0]& num4[1])? ~num4[2]:(D6 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num6_n[3] = (U6 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D6 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num6_n[4] = (U0 & num6[0]& num6[1]& num6[2]& num6[3])? ~num6[4]:(D0 & ~num6[0]& ~num6[1]& ~num6[2]& ~num6[3])?~num6[4]:num6[4];
	assign num6_n[5] = (U0 & num6[0]& num6[1]& num6[2]& num6[3]& num6[4])? ~num6[5]:(D0 & ~num6[0]& ~num6[1]& ~num6[2]& ~num6[3]& ~num6[4])?~num6[5]:num6[5];
	assign num6_n[6] = (U0 & num6[0]& num6[1]& num6[2]& num6[3]& num6[4]& num6[5])? ~num6[6]:(D0 & ~num6[0]& ~num6[1]& ~num6[2]& ~num6[3]& ~num6[4]& ~num6[5])?~num6[6]:num6[6];
	assign num6_n[7] = (U0 & num6[0]& num6[1]& num6[2]& num6[3]& num6[4]& num6[5]& num6[6])? ~num6[7]:(D0 & ~num6[0]& ~num6[1]& ~num6[2]& ~num6[3]& ~num6[4]& ~num6[5]& ~num6[6])?~num6[7]:num6[7];
	
	assign num7_n[0] = (U7|D7)? ~num4[0]:num4[0];
	assign num7_n[1] = (U7 & num4[0])? ~num4[1]:(D7 & ~num4[0])?~num4[1]:num4[1];
	assign num7_n[2] = (U7 & num4[0]& num4[1])? ~num4[2]:(D7 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num7_n[3] = (U7 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D7 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num7_n[4] = (U0 & num7[0]& num7[1]& num7[2]& num7[3])? ~num7[4]:(D0 & ~num7[0]& ~num7[1]& ~num7[2]& ~num7[3])?~num7[4]:num7[4];
	assign num7_n[5] = (U0 & num7[0]& num7[1]& num7[2]& num7[3]& num7[4])? ~num7[5]:(D0 & ~num7[0]& ~num7[1]& ~num7[2]& ~num7[3]& ~num7[4])?~num7[5]:num7[5];
	assign num7_n[6] = (U0 & num7[0]& num7[1]& num7[2]& num7[3]& num7[4]& num7[5])? ~num7[6]:(D0 & ~num7[0]& ~num7[1]& ~num7[2]& ~num7[3]& ~num7[4]& ~num7[5])?~num7[6]:num7[6];
	assign num7_n[7] = (U0 & num7[0]& num7[1]& num7[2]& num7[3]& num7[4]& num7[5]& num7[6])? ~num7[7]:(D0 & ~num7[0]& ~num7[1]& ~num7[2]& ~num7[3]& ~num7[4]& ~num7[5]& ~num7[6])?~num7[7]:num7[7];
	
	assign num8_n[0] = (U8|D8)? ~num4[0]:num4[0];
	assign num8_n[1] = (U8 & num4[0])? ~num4[1]:(D8 & ~num4[0])?~num4[1]:num4[1];
	assign num8_n[2] = (U8 & num4[0]& num4[1])? ~num4[2]:(D8 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num8_n[3] = (U8 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D8 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num8_n[4] = (U0 & num8[0]& num8[1]& num8[2]& num8[3])? ~num8[4]:(D0 & ~num8[0]& ~num8[1]& ~num8[2]& ~num8[3])?~num8[4]:num8[4];
	assign num8_n[5] = (U0 & num8[0]& num8[1]& num8[2]& num8[3]& num8[4])? ~num8[5]:(D0 & ~num8[0]& ~num8[1]& ~num8[2]& ~num8[3]& ~num8[4])?~num8[5]:num8[5];
	assign num8_n[6] = (U0 & num8[0]& num8[1]& num8[2]& num8[3]& num8[4]& num8[5])? ~num8[6]:(D0 & ~num8[0]& ~num8[1]& ~num8[2]& ~num8[3]& ~num8[4]& ~num8[5])?~num8[6]:num8[6];
	assign num8_n[7] = (U0 & num8[0]& num8[1]& num8[2]& num8[3]& num8[4]& num8[5]& num8[6])? ~num8[7]:(D0 & ~num8[0]& ~num8[1]& ~num8[2]& ~num8[3]& ~num8[4]& ~num8[5]& ~num8[6])?~num8[7]:num8[7];
	
	assign num9_n[0] = (U9|D9)? ~num4[0]:num4[0];
	assign num9_n[1] = (U9 & num4[0])? ~num4[1]:(D9 & ~num4[0])?~num4[1]:num4[1];
	assign num9_n[2] = (U9 & num4[0]& num4[1])? ~num4[2]:(D9 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign num9_n[3] = (U9 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D9 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign num9_n[4] = (U0 & num9[0]& num9[1]& num9[2]& num9[3])? ~num9[4]:(D0 & ~num9[0]& ~num9[1]& ~num9[2]& ~num9[3])?~num9[4]:num9[4];
	assign num9_n[5] = (U0 & num9[0]& num9[1]& num9[2]& num9[3]& num9[4])? ~num9[5]:(D0 & ~num9[0]& ~num9[1]& ~num9[2]& ~num9[3]& ~num9[4])?~num9[5]:num9[5];
	assign num9_n[6] = (U0 & num9[0]& num9[1]& num9[2]& num9[3]& num9[4]& num9[5])? ~num9[6]:(D0 & ~num9[0]& ~num9[1]& ~num9[2]& ~num9[3]& ~num9[4]& ~num9[5])?~num9[6]:num9[6];
	assign num9_n[7] = (U0 & num9[0]& num9[1]& num9[2]& num9[3]& num9[4]& num9[5]& num9[6])? ~num9[7]:(D0 & ~num9[0]& ~num9[1]& ~num9[2]& ~num9[3]& ~num9[4]& ~num9[5]& ~num9[6])?~num9[7]:num9[7];

	assign numA_n[0] = (UA|DA)? ~num4[0]:num4[0];
	assign numA_n[1] = (UA & num4[0])? ~num4[1]:(DA & ~num4[0])?~num4[1]:num4[1];
	assign numA_n[2] = (UA & num4[0]& num4[1])? ~num4[2]:(DA & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numA_n[3] = (UA & num4[0]& num4[1]& num4[2])? ~num4[3]:(DA & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numA_n[4] = (U0 & numA[0]& numA[1]& numA[2]& numA[3])? ~numA[4]:(D0 & ~numA[0]& ~numA[1]& ~numA[2]& ~numA[3])?~numA[4]:numA[4];
	assign numA_n[5] = (U0 & numA[0]& numA[1]& numA[2]& numA[3]& numA[4])? ~numA[5]:(D0 & ~numA[0]& ~numA[1]& ~numA[2]& ~numA[3]& ~numA[4])?~numA[5]:numA[5];
	assign numA_n[6] = (U0 & numA[0]& numA[1]& numA[2]& numA[3]& numA[4]& numA[5])? ~numA[6]:(D0 & ~numA[0]& ~numA[1]& ~numA[2]& ~numA[3]& ~numA[4]& ~numA[5])?~numA[6]:numA[6];
	assign numA_n[7] = (U0 & numA[0]& numA[1]& numA[2]& numA[3]& numA[4]& numA[5]& numA[6])? ~numA[7]:(D0 & ~numA[0]& ~numA[1]& ~numA[2]& ~numA[3]& ~numA[4]& ~numA[5]& ~numA[6])?~numA[7]:numA[7];

	assign numB_n[0] = (UB|DB)? ~num4[0]:num4[0];
	assign numB_n[1] = (UB & num4[0])? ~num4[1]:(DB & ~num4[0])?~num4[1]:num4[1];
	assign numB_n[2] = (UB & num4[0]& num4[1])? ~num4[2]:(DB & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numB_n[3] = (UB & num4[0]& num4[1]& num4[2])? ~num4[3]:(DB & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numB_n[4] = (U0 & numB[0]& numB[1]& numB[2]& numB[3])? ~numB[4]:(D0 & ~numB[0]& ~numB[1]& ~numB[2]& ~numB[3])?~numB[4]:numB[4];
	assign numB_n[5] = (U0 & numB[0]& numB[1]& numB[2]& numB[3]& numB[4])? ~numB[5]:(D0 & ~numB[0]& ~numB[1]& ~numB[2]& ~numB[3]& ~numB[4])?~numB[5]:numB[5];
	assign numB_n[6] = (U0 & numB[0]& numB[1]& numB[2]& numB[3]& numB[4]& numB[5])? ~numB[6]:(D0 & ~numB[0]& ~numB[1]& ~numB[2]& ~numB[3]& ~numB[4]& ~numB[5])?~numB[6]:numB[6];
	assign numB_n[7] = (U0 & numB[0]& numB[1]& numB[2]& numB[3]& numB[4]& numB[5]& numB[6])? ~numB[7]:(D0 & ~numB[0]& ~numB[1]& ~numB[2]& ~numB[3]& ~numB[4]& ~numB[5]& ~numB[6])?~numB[7]:numB[7];

	assign numC_n[0] = (UC|DC)? ~num4[0]:num4[0];
	assign numC_n[1] = (UC & num4[0])? ~num4[1]:(DC & ~num4[0])?~num4[1]:num4[1];
	assign numC_n[2] = (UC & num4[0]& num4[1])? ~num4[2]:(DC & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numC_n[3] = (UC & num4[0]& num4[1]& num4[2])? ~num4[3]:(DC & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numC_n[4] = (U0 & numC[0]& numC[1]& numC[2]& numC[3])? ~numC[4]:(D0 & ~numC[0]& ~numC[1]& ~numC[2]& ~numC[3])?~numC[4]:numC[4];
	assign numC_n[5] = (U0 & numC[0]& numC[1]& numC[2]& numC[3]& numC[4])? ~numC[5]:(D0 & ~numC[0]& ~numC[1]& ~numC[2]& ~numC[3]& ~numC[4])?~numC[5]:numC[5];
	assign numC_n[6] = (U0 & numC[0]& numC[1]& numC[2]& numC[3]& numC[4]& numC[5])? ~numC[6]:(D0 & ~numC[0]& ~numC[1]& ~numC[2]& ~numC[3]& ~numC[4]& ~numC[5])?~numC[6]:numC[6];
	assign numC_n[7] = (U0 & numC[0]& numC[1]& numC[2]& numC[3]& numC[4]& numC[5]& numC[6])? ~numC[7]:(D0 & ~numC[0]& ~numC[1]& ~numC[2]& ~numC[3]& ~numC[4]& ~numC[5]& ~numC[6])?~numC[7]:numC[7];

	assign numD_n[0] = (UD|DD)? ~num4[0]:num4[0];
	assign numD_n[1] = (UD & num4[0])? ~num4[1]:(DD & ~num4[0])?~num4[1]:num4[1];
	assign numD_n[2] = (UD & num4[0]& num4[1])? ~num4[2]:(DD & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numD_n[3] = (UD & num4[0]& num4[1]& num4[2])? ~num4[3]:(DD & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numD_n[4] = (U0 & numD[0]& numD[1]& numD[2]& numD[3])? ~numD[4]:(D0 & ~numD[0]& ~numD[1]& ~numD[2]& ~numD[3])?~numD[4]:numD[4];
	assign numD_n[5] = (U0 & numD[0]& numD[1]& numD[2]& numD[3]& numD[4])? ~numD[5]:(D0 & ~numD[0]& ~numD[1]& ~numD[2]& ~numD[3]& ~numD[4])?~numD[5]:numD[5];
	assign numD_n[6] = (U0 & numD[0]& numD[1]& numD[2]& numD[3]& numD[4]& numD[5])? ~numD[6]:(D0 & ~numD[0]& ~numD[1]& ~numD[2]& ~numD[3]& ~numD[4]& ~numD[5])?~numD[6]:numD[6];
	assign numD_n[7] = (U0 & numD[0]& numD[1]& numD[2]& numD[3]& numD[4]& numD[5]& numD[6])? ~numD[7]:(D0 & ~numD[0]& ~numD[1]& ~numD[2]& ~numD[3]& ~numD[4]& ~numD[5]& ~numD[6])?~numD[7]:numD[7];

	assign numE_n[0] = (UE|DE)? ~num4[0]:num4[0];
	assign numE_n[1] = (UE & num4[0])? ~num4[1]:(DE & ~num4[0])?~num4[1]:num4[1];
	assign numE_n[2] = (UE & num4[0]& num4[1])? ~num4[2]:(DE & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numE_n[3] = (UE & num4[0]& num4[1]& num4[2])? ~num4[3]:(DE & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numE_n[4] = (U0 & numE[0]& numE[1]& numE[2]& numE[3])? ~numE[4]:(D0 & ~numE[0]& ~numE[1]& ~numE[2]& ~numE[3])?~numE[4]:numE[4];
	assign numE_n[5] = (U0 & numE[0]& numE[1]& numE[2]& numE[3]& numE[4])? ~numE[5]:(D0 & ~numE[0]& ~numE[1]& ~numE[2]& ~numE[3]& ~numE[4])?~numE[5]:numE[5];
	assign numE_n[6] = (U0 & numE[0]& numE[1]& numE[2]& numE[3]& numE[4]& numE[5])? ~numE[6]:(D0 & ~numE[0]& ~numE[1]& ~numE[2]& ~numE[3]& ~numE[4]& ~numE[5])?~numE[6]:numE[6];
	assign numE_n[7] = (U0 & numE[0]& numE[1]& numE[2]& numE[3]& numE[4]& numE[5]& numE[6])? ~numE[7]:(D0 & ~numE[0]& ~numE[1]& ~numE[2]& ~numE[3]& ~numE[4]& ~numE[5]& ~numE[6])?~numE[7]:numE[7];

	assign numF_n[0] = (UF|DF)? ~num4[0]:num4[0];
	assign numF_n[1] = (UF & num4[0])? ~num4[1]:(DF & ~num4[0])?~num4[1]:num4[1];
	assign numF_n[2] = (UF & num4[0]& num4[1])? ~num4[2]:(DF & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
	assign numF_n[3] = (UF & num4[0]& num4[1]& num4[2])? ~num4[3]:(DF & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];
	assign numF_n[4] = (U0 & numF[0]& numF[1]& numF[2]& numF[3])? ~numF[4]:(D0 & ~numF[0]& ~numF[1]& ~numF[2]& ~numF[3])?~numF[4]:numF[4];
	assign numF_n[5] = (U0 & numF[0]& numF[1]& numF[2]& numF[3]& numF[4])? ~numF[5]:(D0 & ~numF[0]& ~numF[1]& ~numF[2]& ~numF[3]& ~numF[4])?~numF[5]:numF[5];
	assign numF_n[6] = (U0 & numF[0]& numF[1]& numF[2]& numF[3]& numF[4]& numF[5])? ~numF[6]:(D0 & ~numF[0]& ~numF[1]& ~numF[2]& ~numF[3]& ~numF[4]& ~numF[5])?~numF[6]:numF[6];
	assign numF_n[7] = (U0 & numF[0]& numF[1]& numF[2]& numF[3]& numF[4]& numF[5]& numF[6])? ~numF[7]:(D0 & ~numF[0]& ~numF[1]& ~numF[2]& ~numF[3]& ~numF[4]& ~numF[5]& ~numF[6])?~numF[7]:numF[7];

//==================================
//====   round key generation   ====
//==================================

	wire [127:0] key00;
	
	wire [127:0] key0;
	wire [127:0] key1;
	wire [127:0] key2;
	wire [127:0] key3;
	wire [127:0] key4;
	wire [127:0] key5;
	wire [127:0] key6;
	wire [127:0] key7;
	wire [127:0] key8;
	wire [127:0] key9;
	wire [127:0] key10;
	
	wire [31:0]  key05;
	wire [31:0]  key15;
	wire [31:0]  key25;
	wire [31:0]  key35;
	wire [31:0]  key45;
	wire [31:0]  key55;
	wire [31:0]  key65;
	wire [31:0]  key75;
	wire [31:0]  key85;
	wire [31:0]  key95;

	RANDOM128 r0(key00, key0);

	GFUNC g01(key0[31:0], 4'b0001, key05);
	XOR32 x10(key05, key0[127:96], key1[127:96]);
	XOR32 x11(key1[127:96], key0[95:64], key1[95:64]);
	XOR32 x12(key1[95:64], key0[63:32], key1[63:32]);
	XOR32 x13(key1[63:32], key0[31:0], key1[31:0]);
	
	GFUNC g02(key1[31:0], 4'b0010, key15);
	XOR32 x20(key15, key1[127:96], key2[127:96]);
	XOR32 x21(key2[127:96], key1[95:64], key2[95:64]);
	XOR32 x22(key2[95:64], key1[63:32], key2[63:32]);
	XOR32 x23(key2[63:32], key1[31:0], key2[31:0]);
	
	GFUNC g03(key2[31:0], 4'b0011, key25);
	XOR32 x30(key25, key2[127:96], key3[127:96]);
	XOR32 x31(key3[127:96], key2[95:64], key3[95:64]);
	XOR32 x32(key3[95:64], key2[63:32], key3[63:32]);
	XOR32 x33(key3[63:32], key2[31:0], key3[31:0]);
	
	GFUNC g04(key3[31:0], 4'b0100, key35);
	XOR32 x40(key35, key3[127:96], key4[127:96]);
	XOR32 x41(key4[127:96], key3[95:64], key4[95:64]);
	XOR32 x42(key4[95:64], key3[63:32], key4[63:32]);
	XOR32 x43(key4[63:32], key3[31:0], key4[31:0]);
	
	GFUNC g05(key4[31:0], 4'b0101, key45);
	XOR32 x50(key45, key4[127:96], key5[127:96]);
	XOR32 x51(key5[127:96], key4[95:64], key5[95:64]);
	XOR32 x52(key5[95:64], key4[63:32], key5[63:32]);
	XOR32 x53(key5[63:32], key4[31:0], key5[31:0]);
	
	GFUNC g06(key5[31:0], 4'b0110, key55);
	XOR32 x60(key55, key5[127:96], key6[127:96]);
	XOR32 x61(key6[127:96], key5[95:64], key6[95:64]);
	XOR32 x62(key6[95:64], key5[63:32], key6[63:32]);
	XOR32 x63(key6[63:32], key5[31:0], key6[31:0]);
	
	GFUNC g07(key6[31:0], 4'b0111, key65);
	XOR32 x70(key65, key6[127:96], key7[127:96]);
	XOR32 x71(key7[127:96], key6[95:64], key7[95:64]);
	XOR32 x72(key7[95:64], key6[63:32], key7[63:32]);
	XOR32 x73(key7[63:32], key6[31:0], key7[31:0]);
	
	GFUNC g08(key7[31:0], 4'b1000, key75);
	XOR32 x80(key75, key7[127:96], key8[127:96]);
	XOR32 x81(key8[127:96], key7[95:64], key8[95:64]);
	XOR32 x82(key8[95:64], key7[63:32], key8[63:32]);
	XOR32 x83(key8[63:32], key7[31:0], key8[31:0]);
	
	GFUNC g09(key8[31:0], 4'b1001, key85);
	XOR32 x90(key85, key8[127:96], key9[127:96]);
	XOR32 x91(key9[127:96], key8[95:64], key9[95:64]);
	XOR32 x92(key9[95:64], key8[63:32], key9[63:32]);
	XOR32 x93(key9[63:32], key8[31:0], key9[31:0]);
	
	GFUNC g10(key9[31:0], 4'b1010, key95);
	XOR32 x100(key95, key9[127:96], key10[127:96]);
	XOR32 x101(key10[127:96], key9[95:64], key10[95:64]);
	XOR32 x102(key10[95:64], key9[63:32], key10[63:32]);
	XOR32 x103(key10[63:32], key9[31:0], key10[31:0]);

//================================
//=========   Encoding   =========
//================================	
//=================================
//==========   Round 0   ==========
//=================================

	wire	[127:0] CTextR0;
	wire	[127:0] tmpR0;
	assign	tmpR0[127:120]  = numF;
	assign	tmpR0[119:112]  = numE;
	assign	tmpR0[111:104]  = numD;
	assign	tmpR0[103:96]   = numC;
	assign	tmpR0[95:88]    = numB;
	assign	tmpR0[87:80]    = numA;
	assign	tmpR0[79:72]    = num9;
	assign	tmpR0[71:64]    = num8;
	assign	tmpR0[63:56]    = num7;
	assign	tmpR0[55:48]    = num6;
	assign	tmpR0[47:40]    = num5;
	assign	tmpR0[39:32]    = num4;
	assign	tmpR0[31:24]    = num3;
	assign	tmpR0[23:16]    = num2;
	assign	tmpR0[15:8]     = num1;
	assign	tmpR0[7:0]      = num0;
	
	XOR128 x0128(key0, tmpR0, CTextR0);

//=================================
//==========   Round 1   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR1;
	SBOX128 sb1(CTextR0, SBR1);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR1;
	SFR sf1(SBR1, SRR1);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR1;
	MC mc1(SRR1, MCR1);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR1;
	XOR128 x1128(key1, MCR1, CTextR1);

//=================================
//==========   Round 2   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR2;
	SBOX128 sb2(CTextR1, SBR2);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR2;
	SFR sf2(SBR2, SRR2);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR2;
	MC mc2(SRR2, MCR2);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR2;
	XOR128 x2128(key2, MCR2, CTextR2);
	
//=================================
//==========   Round 3   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR3;
	SBOX128 sb3(CTextR2, SBR3);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR3;
	SFR sf3(SBR3, SRR3);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR3;
	MC mc3(SRR3, MCR3);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR3;
	XOR128 x3128(key3, MCR3, CTextR3);

//=================================
//==========   Round 4   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR4;
	SBOX128 sb4(CTextR3, SBR4);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR4;
	SFR sf4(SBR4, SRR4);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR4;
	MC mc4(SRR4, MCR4);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR4;
	XOR128 x4128(key4, MCR4, CTextR4);
	
//=================================
//==========   Round 5   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR1;
	SBOX128 sb5(CTextR4, SBR5);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR5;
	SFR sf5(SBR5, SRR5);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR5;
	MC mc5(SRR5, MCR5);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR5;
	XOR128 x5128(key5, MCR5, CTextR5);

//=================================
//==========   Round 6   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR6;
	SBOX128 sb6(CTextR5, SBR6);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR6;
	SFR sf6(SBR6, SRR6);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR6;
	MC mc6(SRR6, MCR6);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR6;
	XOR128 x6128(key6, MCR6, CTextR6);
	
//=================================
//==========   Round 7   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR7;
	SBOX128 sb7(CTextR6, SBR7);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR7;
	SFR sf7(SBR7, SRR7);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR7;
	MC mc7(SRR7, MCR7);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR7;
	XOR128 x7128(key7, MCR7, CTextR7);

//=================================
//==========   Round 8   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR8;
	SBOX128 sb8(CTextR7, SBR8);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR8;
	SFR sf8(SBR8, SRR8);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR8;
	MC mc8(SRR8, MCR8);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR8;
	XOR128 x8128(key8, MCR8, CTextR8);
	
//=================================
//==========   Round 9   ==========
//=================================
///////////////////////////////////SBOX
	wire [127:0] SBR9;
	SBOX128 sb9(CTextR8, SBR9);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR9;
	SFR sf9(SBR9, SRR9);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR9;
	MC mc9(SRR9, MCR9);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR9;
	XOR128 x9128(key9, MCR9, CTextR9);

//================================
//=========   Round 10   =========
//================================
///////////////////////////////////SBOX
	wire [127:0] SBR10;
	SBOX128 sb10(CTextR9, SBR10);
	
///////////////////////////////////ShiftRow
	
	wire [127:0] SRR10;
	SFR sf10(SBR10, SRR10);
	
///////////////////////////////////MixColumn

	wire [127:0] MCR10;
	MC mc10(SRR10, MCR10);

///////////////////////////////////KeyAdd

	wire [127:0] CTextR10;
	XOR128 x10128(key10, MCR10, CTextR10);

//=================================
//======   phase_to_cipher   ======
//=================================
	wire [7:0] num_s;
	wire [7:0] num_n;
	wire cho_set;
	assign cho_set = set|buttonL|buttonR|rst;
	PHA_PICK choose0(cho_set, cur_phase, CTextR10, num_s);
	PHA_PICK choose1(cho_set, phase_n, CTextR10, num_n);
	assign seven_num = (set==0&(buttonL|buttonR))?num_n:num_s;

endmodule
