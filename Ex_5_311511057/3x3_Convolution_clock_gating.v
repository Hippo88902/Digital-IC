//synopsys translate_off
`include "asap7sc7p5t_SEQ_RVT_TT_08302018.v"
//synopsys translate_on

module Convolution(
	//input
clk,
rst_n,
in_valid,
weight_valid,
In_IFM_1,
In_IFM_2,
In_IFM_3,
In_IFM_4,
In_IFM_5,
In_IFM_6,
In_IFM_7,
In_IFM_8,
In_IFM_9,
In_Weight_1,
In_Weight_2,
In_Weight_3,
In_Weight_4,
In_Weight_5,
In_Weight_6,
In_Weight_7,
In_Weight_8,
In_Weight_9,
//output
out_valid, 
Out_OFM	

);

input clk, rst_n, in_valid, weight_valid;
input [7:0]In_IFM_1;		
input [7:0]In_IFM_2;		
input [7:0]In_IFM_3;		
input [7:0]In_IFM_4;		
input [7:0]In_IFM_5;		
input [7:0]In_IFM_6;		
input [7:0]In_IFM_7;		
input [7:0]In_IFM_8;		
input [7:0]In_IFM_9;		
input [7:0]In_Weight_1;
input [7:0]In_Weight_2;
input [7:0]In_Weight_3;
input [7:0]In_Weight_4;
input [7:0]In_Weight_5;
input [7:0]In_Weight_6;
input [7:0]In_Weight_7;
input [7:0]In_Weight_8;
input [7:0]In_Weight_9;

//////////////The output port shoud be registers///////////////////////
output reg out_valid;
output reg[21:0] Out_OFM;
//////////////////////////////////////////////////////////////////////
integer i;
reg in_valid_reg;
reg [7:0]weight_reg[0:8];
reg [7:0]ifm_reg   [0:8];

wire input_clk[0:8];
wire weight_clk;

// ICGx3_ASAP7_75t_R input_clk  (.CLK(clk), .ENA(0), .SE(in_valid),     .GCLK(input_clk));
ICGx3_ASAP7_75t_R input_clk0  (.CLK(clk), .ENA(0), .SE(In_IFM_1 != ifm_reg[0]),     .GCLK(input_clk[0]));
ICGx3_ASAP7_75t_R input_clk1  (.CLK(clk), .ENA(0), .SE(In_IFM_2 != ifm_reg[1]),     .GCLK(input_clk[1]));
ICGx3_ASAP7_75t_R input_clk2  (.CLK(clk), .ENA(0), .SE(In_IFM_3 != ifm_reg[2]),     .GCLK(input_clk[2]));
ICGx3_ASAP7_75t_R input_clk3  (.CLK(clk), .ENA(0), .SE(In_IFM_4 != ifm_reg[3]),     .GCLK(input_clk[3]));
ICGx3_ASAP7_75t_R input_clk4  (.CLK(clk), .ENA(0), .SE(In_IFM_5 != ifm_reg[4]),     .GCLK(input_clk[4]));
ICGx3_ASAP7_75t_R input_clk5  (.CLK(clk), .ENA(0), .SE(In_IFM_6 != ifm_reg[5]),     .GCLK(input_clk[5]));
ICGx3_ASAP7_75t_R input_clk6  (.CLK(clk), .ENA(0), .SE(In_IFM_7 != ifm_reg[6]),     .GCLK(input_clk[6]));
ICGx3_ASAP7_75t_R input_clk7  (.CLK(clk), .ENA(0), .SE(In_IFM_8 != ifm_reg[7]),     .GCLK(input_clk[7]));
ICGx3_ASAP7_75t_R input_clk8  (.CLK(clk), .ENA(0), .SE(In_IFM_9 != ifm_reg[8]),     .GCLK(input_clk[8]));
ICGx3_ASAP7_75t_R w_clk       (.CLK(clk), .ENA(0), .SE(weight_valid),               .GCLK(weight_clk));


always @(posedge input_clk[0] or negedge rst_n) 
begin
    ifm_reg[0] <= (!rst_n) ? 0 : In_IFM_1;
end

always @(posedge input_clk[1] or negedge rst_n) 
begin
    ifm_reg[1] <= (!rst_n) ? 0 : In_IFM_2;
end

always @(posedge input_clk[2] or negedge rst_n) 
begin
    ifm_reg[2] <= (!rst_n) ? 0 : In_IFM_3;
end

always @(posedge input_clk[3] or negedge rst_n) 
begin
    ifm_reg[3] <= (!rst_n) ? 0 : In_IFM_4;
end

always @(posedge input_clk[4] or negedge rst_n) 
begin
    ifm_reg[4] <= (!rst_n) ? 0 : In_IFM_5;
end

always @(posedge input_clk[5] or negedge rst_n) 
begin
    ifm_reg[5] <= (!rst_n) ? 0 : In_IFM_6;
end

always @(posedge input_clk[6] or negedge rst_n) 
begin
    ifm_reg[6] <= (!rst_n) ? 0 : In_IFM_7;
end

always @(posedge input_clk[7] or negedge rst_n) 
begin
    ifm_reg[7] <= (!rst_n) ? 0 : In_IFM_8;
end

always @(posedge input_clk[8] or negedge rst_n) 
begin
    ifm_reg[8] <= (!rst_n) ? 0 : In_IFM_9;
end
//-------------------------------------------------
always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[0] <= (!rst_n) ? 0 : In_Weight_1;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[1] <= (!rst_n) ? 0 : In_Weight_2;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[2] <= (!rst_n) ? 0 : In_Weight_3;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[3] <= (!rst_n) ? 0 : In_Weight_4;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[4] <= (!rst_n) ? 0 : In_Weight_5;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[5] <= (!rst_n) ? 0 : In_Weight_6;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[6] <= (!rst_n) ? 0 : In_Weight_7;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[7] <= (!rst_n) ? 0 : In_Weight_8;
end

always @(posedge weight_clk or negedge rst_n) 
begin
    weight_reg[8] <= (!rst_n) ? 0 : In_Weight_9;
end

always @(posedge clk or negedge rst_n) 
begin
    if(!rst_n) 
    begin
        in_valid_reg <= 0;
    end else 
    begin
        in_valid_reg <= in_valid;
    end
end

ICGx3_ASAP7_75t_R out_clk (.CLK(clk), .ENA(0), .SE(in_valid_reg || out_valid), .GCLK(o_clk));

always @(posedge o_clk or negedge rst_n) 
begin
    if(!rst_n) 
    begin
        out_valid <= 0;
        Out_OFM <= 0;
    end else 
    begin
        out_valid <= in_valid_reg;
        Out_OFM <= ifm_reg[0]*weight_reg[0] + ifm_reg[1]*weight_reg[1] + ifm_reg[2]*weight_reg[2]
                 + ifm_reg[3]*weight_reg[3] + ifm_reg[4]*weight_reg[4] + ifm_reg[5]*weight_reg[5]
                 + ifm_reg[6]*weight_reg[6] + ifm_reg[7]*weight_reg[7] + ifm_reg[8]*weight_reg[8];
    end
end


endmodule