//////////////////////////////////////////////////////////////////////////////////
// Module Name: TrafficLight : Traffic Light Controller System with VGA
// Submodule: ButtonFSM, MP_Timer_Controller(Timer), Display_Controller(7sDecoder/7sDisplayer), VGADisplayer
//////////////////////////////////////////////////////////////////////////////////


module TrafficLight(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
    input                   btnL,       // Left   Button
    input                   btnR,       // Right  Button
    //====================================================
    //=======           Output                      ======
    //====================================================
   /* //-----------Display_Controller-----
        //-----------VGADisplayer--------
    output     [3:0]        vgaRed, 
    output     [3:0]        vgaBlue,
    output     [3:0]        vgaGreen,
    output                  Hsync,
    output                  Vsync,*/
        //-----------ssDisplayer----------
    output     [6:0]        seg,         // Number
    output     [3:0]        an,          // Mux for 4 number 
    output                  dp,          // Dot point
    output     [15:0]       led          // 16 green LEDs
    );
    
    wire clk25; //25 MHz clock
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    
//=======================================
//=======          TODO            ======
//=======================================
	
	wire set;
	assign rst = sw[15];
	assign set = sw[14];
	
	wire dL;
	wire dR;
	wire dU;
	wire dD;	
	ButtonFSM left(clk25, rst, btnL, dL);
	ButtonFSM right(clk25, rst, btnR, dR);
	ButtonFSM up(clk25, rst, btnU, dU);
	ButtonFSM down(clk25, rst, btnD, dD);
	
	wire [3:0] phase;
	wire [7:0] s_num;
	//wire [2:0] car;
	//wire [3:0] man;
	
	AES_Encoder aes_en(clk25, rst, set, dU, dD, dL, dR, phase, s_num);
	DisplayController discon(clk25, rst, set, phase, s_num, seg, an, dp, led);
	//VGADisplayer vga(clk25, rst, car, man, vgaRed, vgaBlue, vgaGreen, Hsync, Vsync);

    
endmodule
