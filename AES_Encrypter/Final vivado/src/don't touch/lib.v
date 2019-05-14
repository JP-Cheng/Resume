
////////////////////////////////////////////// INV
module INV(in1, out1);
      output reg out1;
       input in1;
always@(*)
begin 
out1 = ~in1;
end

endmodule

////////////////////////////////////////////// AND2
module AND2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=A&B;
end

endmodule

////////////////////////////////////////////// AND3
module AND3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=A&B&C;
end

endmodule

////////////////////////////////////////////// AND4
module AND4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=A&B&C&D;
end

endmodule


////////////////////////////////////////////// OR2
module OR2(A,B,Y);
      output reg Y;
       input A,B;

always@(*)
begin 
Y=A|B;
end

endmodule

////////////////////////////////////////////// OR3
module OR3(A,B,C,Y);
      output reg Y;
       input A,B,C;

always@(*)
begin 
Y=A|B|C;
end

endmodule

////////////////////////////////////////////// OR4
module OR4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;

always@(*)
begin 
Y=A|B|C|D;
end

endmodule

////////////////////////////////////////////// NAND2
module NAND2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=~(A&B);
end

endmodule

////////////////////////////////////////////// NAND3
module NAND3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=~(A&B&C);
end

endmodule

////////////////////////////////////////////// NAND4
module NAND4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=~(A&B&C&D);
end

endmodule

////////////////////////////////////////////// NOR2

module NOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=~(A|B);
end

endmodule

////////////////////////////////////////////// NOR3

module NOR3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=~(A|B|C);
end

endmodule

////////////////////////////////////////////// NOR4

module NOR4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=~(A|B|C|D);
end

endmodule

////////////////////////////////////////////// XOR2
module XOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=(~A&B) | (A&~B);
end

endmodule

//////////////////////////////////////////////XNOR2
module XNOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=(A&B) | (~A&~B);
end

endmodule

//////////////////////////////////////////////DFF, positive edge D flip flop, asynchronous positive reset, when reset, reset to H or L according to HL

module DFF(Q,D,CLK,RESET,HL);

output reg Q;
input D,CLK,RESET,HL;

always@(posedge CLK or posedge RESET) 
begin
    if(RESET) Q<=HL;
    else Q<=D;
end

endmodule

//////////////////////////////////////////////MUX21
module MUX21(SEL,A,B,Y); //if SEL==1 Y=A, else Y=B
output reg Y;
input SEL,A,B;

always@(*) 
begin
    Y = (SEL)?A:B;
end
   
endmodule

//////////////////////////////////////////////MUX41
module MUX41(SEL,A,B,C,D,Y); //if SEL==00 Y=A, SEL==01 Y=B, SEL==10 Y=C, SEL==11 Y=D
output reg Y;
input [1:0] SEL;
input A,B,C,D;

always@(*) 
begin
    case(SEL)
    2'b00: Y=A;
    2'b01: Y=B;
    2'b10: Y=C;
    2'b11: Y=D;
    endcase
end
   
endmodule

///////////////////////////////////////////////random128

module RANDOM128(
	input		[127:0] NUM,	//want to random
	output reg	[127:0] RAN
);

	always@(*)
	begin
		RAN[127:96] = $random;
		RAN[95:64] = $random;
		RAN[63:32] = $random;
		RAN[31:0] = $random;
	end

endmodule

////////////////////////////////////////////////SBox_8bits

module SBOX8(
	input		[7:0] PLAIN,
	output reg	[7:0] CIP
);

always@(*)
begin
	case(PLAIN)
	8'h00: CIP = 8'h63;
	8'h01: CIP = 8'h7c;
	8'h02: CIP = 8'h77;
	8'h03: CIP = 8'h7b;
	8'h04: CIP = 8'hf2;
	8'h05: CIP = 8'h6b;
	8'h06: CIP = 8'h6f;
	8'h07: CIP = 8'hc5;
	8'h08: CIP = 8'h30;
	8'h09: CIP = 8'h01;
	8'h0a: CIP = 8'h67;
	8'h0b: CIP = 8'h2b;
	8'h0c: CIP = 8'hfe;
	8'h0d: CIP = 8'hd7;
	8'h0e: CIP = 8'hab;
	8'h0f: CIP = 8'h76;
	
	8'h10: CIP = 8'hca;
	8'h11: CIP = 8'h82;
	8'h12: CIP = 8'hc9;
	8'h13: CIP = 8'h7d;
	8'h14: CIP = 8'hfa;
	8'h15: CIP = 8'h59;
	8'h16: CIP = 8'h47;
	8'h17: CIP = 8'hf0;
	8'h18: CIP = 8'had;
	8'h19: CIP = 8'hd4;
	8'h1a: CIP = 8'ha2;
	8'h1b: CIP = 8'haf;
	8'h1c: CIP = 8'h9c;
	8'h1d: CIP = 8'ha4;
	8'h1e: CIP = 8'h72;
	8'h1f: CIP = 8'hc0;

	8'h20: CIP = 8'hb7;
	8'h21: CIP = 8'hfd;
	8'h22: CIP = 8'h93;
	8'h23: CIP = 8'h26;
	8'h24: CIP = 8'h36;
	8'h25: CIP = 8'h3f;
	8'h26: CIP = 8'hf7;
	8'h27: CIP = 8'hcc;
	8'h28: CIP = 8'h34;
	8'h29: CIP = 8'ha5;
	8'h2a: CIP = 8'he5;
	8'h2b: CIP = 8'hf1;
	8'h2c: CIP = 8'h71;
	8'h2d: CIP = 8'hd8;
	8'h2e: CIP = 8'h31;
	8'h2f: CIP = 8'h15;

	8'h30: CIP = 8'h04;
	8'h31: CIP = 8'hc7;
	8'h32: CIP = 8'h23;
	8'h33: CIP = 8'hc3;
	8'h34: CIP = 8'h18;
	8'h35: CIP = 8'h96;
	8'h36: CIP = 8'h05;
	8'h37: CIP = 8'h9a;
	8'h38: CIP = 8'h07;
	8'h39: CIP = 8'h12;
	8'h3a: CIP = 8'h80;
	8'h3b: CIP = 8'he2;
	8'h3c: CIP = 8'heb;
	8'h3d: CIP = 8'h27;
	8'h3e: CIP = 8'hb2;
	8'h3f: CIP = 8'h75;

	8'h40: CIP = 8'h09;
	8'h41: CIP = 8'h83;
	8'h42: CIP = 8'h2c;
	8'h43: CIP = 8'h1a;
	8'h44: CIP = 8'h1b;
	8'h45: CIP = 8'h6e;
	8'h46: CIP = 8'h5a;
	8'h47: CIP = 8'ha0;
	8'h48: CIP = 8'h52;
	8'h49: CIP = 8'h3b;
	8'h4a: CIP = 8'hd6;
	8'h4b: CIP = 8'hb3;
	8'h4c: CIP = 8'h29;
	8'h4d: CIP = 8'he3;
	8'h4e: CIP = 8'h2f;
	8'h4f: CIP = 8'h84;

	8'h50: CIP = 8'h53;
	8'h51: CIP = 8'hd1;
	8'h52: CIP = 8'h00;
	8'h53: CIP = 8'hed;
	8'h54: CIP = 8'h20;
	8'h55: CIP = 8'hfc;
	8'h56: CIP = 8'hb1;
	8'h57: CIP = 8'h5b;
	8'h58: CIP = 8'h6a;
	8'h59: CIP = 8'hcb;
	8'h5a: CIP = 8'hbe;
	8'h5b: CIP = 8'h39;
	8'h5c: CIP = 8'h4a;
	8'h5d: CIP = 8'h4c;
	8'h5e: CIP = 8'h58;
	8'h5f: CIP = 8'hcf;

	8'h60: CIP = 8'hd0;
	8'h61: CIP = 8'hef;
	8'h62: CIP = 8'haa;
	8'h63: CIP = 8'hfb;
	8'h64: CIP = 8'h43;
	8'h65: CIP = 8'h4d;
	8'h66: CIP = 8'h33;
	8'h67: CIP = 8'h85;
	8'h68: CIP = 8'h45;
	8'h69: CIP = 8'hf9;
	8'h6a: CIP = 8'h02;
	8'h6b: CIP = 8'h7f;
	8'h6c: CIP = 8'h50;
	8'h6d: CIP = 8'h3c;
	8'h6e: CIP = 8'h9f;
	8'h6f: CIP = 8'ha8;

	8'h70: CIP = 8'h51;
	8'h71: CIP = 8'ha3;
	8'h72: CIP = 8'h40;
	8'h73: CIP = 8'h8f;
	8'h74: CIP = 8'h92;
	8'h75: CIP = 8'h9d;
	8'h76: CIP = 8'h38;
	8'h77: CIP = 8'hf5;
	8'h78: CIP = 8'hbc;
	8'h79: CIP = 8'hb6;
	8'h7a: CIP = 8'hda;
	8'h7b: CIP = 8'h21;
	8'h7c: CIP = 8'h10;
	8'h7d: CIP = 8'hff;
	8'h7e: CIP = 8'hf3;

	8'h80: CIP = 8'hcd;
	8'h81: CIP = 8'h0c;
	8'h82: CIP = 8'h13;
	8'h83: CIP = 8'hec;
	8'h84: CIP = 8'h5f;
	8'h85: CIP = 8'h97;
	8'h86: CIP = 8'h44;
	8'h87: CIP = 8'h17;
	8'h88: CIP = 8'hc4;
	8'h89: CIP = 8'ha7;
	8'h8a: CIP = 8'h7e;
	8'h8b: CIP = 8'h3d;
	8'h8c: CIP = 8'h64;
	8'h8d: CIP = 8'h5d;
	8'h8e: CIP = 8'h19;
	8'h8f: CIP = 8'h73;

	8'h90: CIP = 8'h60;
	8'h91: CIP = 8'h81;
	8'h92: CIP = 8'h4f;
	8'h93: CIP = 8'hdc;
	8'h94: CIP = 8'h22;
	8'h95: CIP = 8'h2a;
	8'h96: CIP = 8'h90;
	8'h97: CIP = 8'h88;
	8'h98: CIP = 8'h46;
	8'h99: CIP = 8'hee;
	8'h9a: CIP = 8'hb8;
	8'h9b: CIP = 8'h14;
	8'h9c: CIP = 8'hde;
	8'h9d: CIP = 8'h5e;
	8'h9e: CIP = 8'h0b;
	8'h9f: CIP = 8'hdb;

	8'ha0: CIP = 8'he0;
	8'ha1: CIP = 8'h32;
	8'ha2: CIP = 8'h3a;
	8'ha3: CIP = 8'h0a;
	8'ha4: CIP = 8'h49;
	8'ha5: CIP = 8'h06;
	8'ha6: CIP = 8'h24;
	8'ha7: CIP = 8'h5c;
	8'ha8: CIP = 8'hc2;
	8'ha9: CIP = 8'hd3;
	8'haa: CIP = 8'hac;
	8'hab: CIP = 8'h62;
	8'hac: CIP = 8'h91;
	8'had: CIP = 8'h95;
	8'hae: CIP = 8'he4;
	8'haf: CIP = 8'h79;

	8'hb0: CIP = 8'he7;
	8'hb1: CIP = 8'hc8;
	8'hb2: CIP = 8'h37;
	8'hb3: CIP = 8'h6d;
	8'hb4: CIP = 8'h8d;
	8'hb5: CIP = 8'hd5;
	8'hb6: CIP = 8'h4e;
	8'hb7: CIP = 8'ha9;
	8'hb8: CIP = 8'h6c;
	8'hb9: CIP = 8'h56;
	8'hba: CIP = 8'hf4;
	8'hbb: CIP = 8'hea;
	8'hbc: CIP = 8'h65;
	8'hbd: CIP = 8'h7a;
	8'hbe: CIP = 8'hae;
	8'hbf: CIP = 8'h08;

	8'hc0: CIP = 8'hba;
	8'hc1: CIP = 8'h78;
	8'hc2: CIP = 8'h25;
	8'hc3: CIP = 8'h2e;
	8'hc4: CIP = 8'h1c;
	8'hc5: CIP = 8'ha6;
	8'hc6: CIP = 8'hb4;
	8'hc7: CIP = 8'hc6;
	8'hc8: CIP = 8'he8;
	8'hc9: CIP = 8'hdd;
	8'hca: CIP = 8'h74;
	8'hcb: CIP = 8'h1f;
	8'hcc: CIP = 8'h4b;
	8'hcd: CIP = 8'hbd;
	8'hce: CIP = 8'h8b;
	8'hcf: CIP = 8'h8a;

	8'hd0: CIP = 8'h70;
	8'hd1: CIP = 8'h3e;
	8'hd2: CIP = 8'hb5;
	8'hd3: CIP = 8'h66;
	8'hd4: CIP = 8'h48;
	8'hd5: CIP = 8'h03;
	8'hd6: CIP = 8'hf6;
	8'hd7: CIP = 8'h0e;
	8'hd8: CIP = 8'h61;
	8'hd9: CIP = 8'h35;
	8'hda: CIP = 8'h57;
	8'hdb: CIP = 8'hb9;
	8'hdc: CIP = 8'h86;
	8'hdd: CIP = 8'hc1;
	8'hde: CIP = 8'h1d;
	8'hdf: CIP = 8'h9e;

	8'he0: CIP = 8'he1;
	8'he1: CIP = 8'hf8;
	8'he2: CIP = 8'h98;
	8'he3: CIP = 8'h11;
	8'he4: CIP = 8'h69;
	8'he5: CIP = 8'hd9;
	8'he6: CIP = 8'h8e;
	8'he7: CIP = 8'h94;
	8'he8: CIP = 8'h9b;
	8'he9: CIP = 8'h1e;
	8'hea: CIP = 8'h87;
	8'heb: CIP = 8'he9;
	8'hec: CIP = 8'hce;
	8'hed: CIP = 8'h55;
	8'hee: CIP = 8'h28;
	8'hef: CIP = 8'hdf;

	8'hf0: CIP = 8'h8c;
	8'hf1: CIP = 8'ha1;
	8'hf2: CIP = 8'h89;
	8'hf3: CIP = 8'h0d;
	8'hf4: CIP = 8'hbf;
	8'hf5: CIP = 8'he6;
	8'hf6: CIP = 8'h42;
	8'hf7: CIP = 8'h68;
	8'hf8: CIP = 8'h41;
	8'hf9: CIP = 8'h99;
	8'hfa: CIP = 8'h2d;
	8'hfb: CIP = 8'h0f;
	8'hfc: CIP = 8'hb0;
	8'hfd: CIP = 8'h54;
	8'hfe: CIP = 8'hbb;
	8'hff: CIP = 8'h16;
	
	endcase
end
	
endmodule

////////////////////////////////////////////////SBox_128bit

module SBOX128(
	input		[127:0] PLAIN,
	output reg	[127:0] SBR
);

always@(*)
begin

	SBOX8(PLAIN[127:120], SBR[127:120]);	//B0
	SBOX8(PLAIN[119:112], SBR[119:112]);	//B1
	SBOX8(PLAIN[111:104], SBR[111:104]);	//B2
	SBOX8(PLAIN[103:96], SBR[103:96]);		//B3
	SBOX8(PLAIN[95:88], SBR[95:88]);		//B4
	SBOX8(PLAIN[87:80], SBR[87:80]);		//B5
	SBOX8(PLAIN[79:72], SBR[79:72]);		//B6
	SBOX8(PLAIN[71:64], SBR[71:64]);		//B7
	SBOX8(PLAIN[63:56], SBR[63:56]);		//B8
	SBOX8(PLAIN[55:48], SBR[55:48]);		//B9
	SBOX8(PLAIN[47:40], SBR[47:40]);		//B10
	SBOX8(PLAIN[39:32], SBR[39:32]);		//B11
	SBOX8(PLAIN[31:24], SBR[31:24]);		//B12
	SBOX8(PLAIN[23:16], SBR[23:16]);		//B13
	SBOX8(PLAIN[15:8], SBR[15:8]);			//B14
	SBOX8(PLAIN[7:0], SBR[7:0]);			//B15
	
end
	
endmodule

////////////////////////////////////////////////ShiftRow

module SFR(
	input		[127:0] SBR,
	output reg	[127:0] SRR
);

always@(*)
begin

	SRR[127:120] = SBR[127:120];
	SRR[95:88] = SBR[95:88];
	SRR[63:56] = SBR[63:56];
	SRR[31:24] = SBR[31:24];
	
	SRR[119:112] = SBR[87:80];
	SRR[111:104] = SBR[47:40];
	SRR[103:96] = SBR[8:0];
	
	SRR[87:80] = SBR[55:48];
	SRR[79:72] = SBR[15:8];
	SRR[71:64] = SBR[103:96];
	
	SRR[55:48] = SBR[23:16];
	SRR[47:40] = SBR[111:104];
	SRR[39:32] = SBR[71:64];
	
	SRR[23:16] = SBR[119:112];
	SRR[15:8] = SBR[79:72];
	SRR[7:0] = SBR[39:32];	
	
end
	
endmodule

////////////////////////////////////////////////MixColumn

module MC(
	input		[127:0] SRR,
	output reg	[127:0] MCR
);

always@(*) 
begin
    
	MCR[127:120] = ((SRR[127:120]<<1)+(SRR[119:112]<<1)+(SRR[119:112])+(SRR[111:104])+(SRR[103:96]))%9'b100011011;
	MCR[119:112] = ((SRR[127:120])+(SRR[119:112]<<1)+(SRR[111:104]<<1)+(SRR[111:104])+(SRR[103:96]))%9'b100011011;
	MCR[111:104] = ((SRR[127:120])+(SRR[119:112])+(SRR[111:104]<<1)+(SRR[103:96]<<1)+(SRR[103:96]))%9'b100011011;
	MCR[103:96]  = ((SRR[127:120]<<1)+(SRR[127:120])+(SRR[119:112])+(SRR[111:104])+(SRR[103:96]<<1))%9'b100011011;
	
	MCR[95:88] = ((SRR[95:88]<<1)+(SRR[87:80]<<1)+(SRR[87:80])+(SRR[79:72])+(SRR[71:64]))%9'b100011011;
	MCR[87:80] = ((SRR[95:88])+(SRR[87:80]<<1)+(SRR[79:72]<<1)+(SRR[79:72])+(SRR[71:64]))%9'b100011011;
	MCR[79:72] = ((SRR[95:88])+(SRR[87:80])+(SRR[79:72]<<1)+(SRR[71:64]<<1)+(SRR[71:64]))%9'b100011011;
	MCR[71:64]  = ((SRR[95:88]<<1)+(SRR[95:88])+(SRR[87:80])+(SRR[79:72])+(SRR[71:64]<<1))%9'b100011011;
	
	MCR[63:56] = ((SRR[63:56]<<1)+(SRR[55:48]<<1)+(SRR[55:48])+(SRR[47:40])+(SRR[39:32]))%9'b100011011;
	MCR[55:48] = ((SRR[63:56])+(SRR[55:48]<<1)+(SRR[47:40]<<1)+(SRR[47:40])+(SRR[39:32]))%9'b100011011;
	MCR[47:40] = ((SRR[63:56])+(SRR[55:48])+(SRR[47:40]<<1)+(SRR[39:32]<<1)+(SRR[39:32]))%9'b100011011;
	MCR[39:32]  = ((SRR[63:56]<<1)+(SRR[63:56])+(SRR[55:48])+(SRR[47:40])+(SRR[39:32]<<1))%9'b100011011;
	
	MCR[31:24] = ((SRR[31:24]<<1)+(SRR[23:16]<<1)+(SRR[23:16])+(SRR[15:8])+(SRR[7:0]))%9'b100011011;
	MCR[23:16] = ((SRR[31:24])+(SRR[23:16]<<1)+(SRR[15:8]<<1)+(SRR[15:8])+(SRR[7:0]))%9'b100011011;
	MCR[15:8] = ((SRR[31:24])+(SRR[23:16])+(SRR[15:8]<<1)+(SRR[7:0]<<1)+(SRR[7:0]))%9'b100011011;
	MCR[7:0]  = ((SRR[31:24]<<1)+(SRR[31:24])+(SRR[23:16])+(SRR[15:8])+(SRR[7:0]<<1))%9'b100011011;
	
end

endmodule
////////////////////////////////////////////////XOR_8bit

module XOR8(
	input		[7:0] A,
	input		[7:0] B,
	output reg	[7:0] Y
);
reg i;
always@(*) 
begin
    for (i = 0; i < 8 ; i= i + 1)begin
	Y[i] = (~A[i]&B[i]) | (A[i]&~B[i]);
	end
end

endmodule

////////////////////////////////////////////////XOR_32bit

module XOR32(
	input		[31:0] A,
	input		[31:0] B,
	output reg	[31:0] Y
);
reg i;
always@(*) 
begin
    for (i = 0; i < 32 ; i= i + 1)begin
	Y[i] = (~A[i]&B[i]) | (A[i]&~B[i]);
	end
end

endmodule

////////////////////////////////////////////////XOR_128bit

module XOR128(
	input		[127:0] A,
	input		[127:0] B,
	output reg	[127:0] Y
);
reg i;
always@(*) 
begin
    for (i = 0; i < 128 ; i= i + 1)begin
	Y[i] = (~A[i]&B[i]) | (A[i]&~B[i]);
	end
end

endmodule

/////////////////////////////////////////////////g function

module GFUNC(
	input		[31:0] VEC,
    input   	[3:0]  ROUND,
	output reg	[31:0] MYWORD
);
	wire [7:0] tmp01;
	reg [7:0] tmp02;
	wire [7:0] tmp03;
	wire [7:0] tmp04;
	wire [7:0] tmp05;
	wire [7:0] tmp06;
	wire [7:0] tmp07;
	wire [7:0] tmp08;
	wire [7:0] tmp09;
	wire [7:0] tmp10;
	wire [7:0] tmp11;
	wire [7:0] tmp12;
	assign tmp03=8'h01;
	assign tmp04=8'b00000010;
	assign tmp05=8'b00000100;
	assign tmp06=8'b00001000;
	assign tmp07=8'b00010000;
	assign tmp08=8'b00100000;
	assign tmp09=8'b01000000;
	assign tmp10=8'b10000000;
	assign tmp11=8'b00011011;
	assign tmp12=8'b00110110;
	
	SBOX8 (VEC[31:24], MYWORD[7:0]);
	SBOX8 (VEC[7:0], MYWORD[15:8]);
	SBOX8 (VEC[15:8], MYWORD[23:16]);
	SBOX8 (VEC[23:16], tmp02);
	/*case(ROUND)
	4'b0000:	  tmp01 = tmp03;
	4'b0001:	  tmp01 = 8'b00000010;
	4'b0010:	  tmp01 = 8'b00000100;
	4'b0011:	  tmp01 = 8'b00001000;
	4'b0100:	  tmp01 = 8'b00010000;
	4'b0101:	  tmp01 = 8'b00100000;
	4'b0110:	  tmp01 = 8'b01000000;
	4'b0111:	  tmp01 = 8'b10000000;
	4'b1000:	  tmp01 = 8'b00011011;
	4'b1001:	  tmp01 = 8'b00110110;
	endcase*/
	tmp01=(ROUND==4'b0000)?( tmp03):(ROUND==4'b0001)?( tmp04):
	(ROUND==4'b0010)?( tmp05):(ROUND==4'b0011)?( tmp06):
	(ROUND==4'b0100)?( tmp07):(ROUND==4'b0101)?( tmp08):
	(ROUND==4'b0110)?( tmp09):(ROUND==4'b0111)?( tmp08):
	(ROUND==4'b1000)?( tmp11):(ROUND==4'b1001)?( tmp12);
	
	XOR8(tmp02, tmp01, MYWORD[31:24]);

	
endmodule

////////////////////////////////////////////////PhaseDecoder

module PHA_PICK(
	input		set,
	input		[3:0] PHASE,
	input		[127:0] CIPHER,
	output reg	[7:0] NUMBER
);

always@(set) begin
    case(PHASE)
	4'b0000: NUMBER = CIPHER[7:0];
	4'b0001: NUMBER = CIPHER[15:8];
	4'b0010: NUMBER = CIPHER[23:16];
	4'b0011: NUMBER = CIPHER[31:24];
	4'b0100: NUMBER = CIPHER[39:32];
	4'b0101: NUMBER = CIPHER[47:40];
	4'b0110: NUMBER = CIPHER[55:48];
	4'b0111: NUMBER = CIPHER[63:56];
	4'b1000: NUMBER = CIPHER[71:64];
	4'b1001: NUMBER = CIPHER[79:72];
	4'b1010: NUMBER = CIPHER[87:80];
	4'b1011: NUMBER = CIPHER[95:88];
	4'b1100: NUMBER = CIPHER[103:96];
	4'b1101: NUMBER = CIPHER[111:104];
	4'b1110: NUMBER = CIPHER[119:112];
	4'b1111: NUMBER = CIPHER[127:120];
	default: NUMBER = 8'h00;
	endcase
end

endmodule
