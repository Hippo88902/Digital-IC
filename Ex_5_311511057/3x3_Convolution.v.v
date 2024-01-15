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

output reg out_valid;
output reg [20:0] Out_OFM;
reg EXE;
reg [7:0]IFM_1;
reg [7:0]IFM_2;
reg [7:0]IFM_3;
reg [7:0]IFM_4;
reg [7:0]IFM_5;
reg [7:0]IFM_6;
reg [7:0]IFM_7;
reg [7:0]IFM_8;
reg [7:0]IFM_9;
reg [7:0]Weight_1;
reg [7:0]Weight_2;
reg [7:0]Weight_3;
reg [7:0]Weight_4;
reg [7:0]Weight_5;
reg [7:0]Weight_6;
reg [7:0]Weight_7;
reg [7:0]Weight_8;
reg [7:0]Weight_9;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Weight_1 <= 0;
        Weight_2 <= 0;
        Weight_3 <= 0;
        Weight_4 <= 0;
        Weight_5 <= 0;
        Weight_6 <= 0;
        Weight_7 <= 0;
        Weight_8 <= 0;
        Weight_9 <= 0;

        IFM_1 <= 0;
        IFM_2 <= 0;
        IFM_3 <= 0;
        IFM_4 <= 0;
        IFM_5 <= 0;
        IFM_6 <= 0;
        IFM_7 <= 0;
        IFM_8 <= 0;
        IFM_9 <= 0;
    end 
	else begin
        if (weight_valid) begin
            Weight_1 <= In_Weight_1;
            Weight_2 <= In_Weight_2;
            Weight_3 <= In_Weight_3;
            Weight_4 <= In_Weight_4;
            Weight_5 <= In_Weight_5;
            Weight_6 <= In_Weight_6;
            Weight_7 <= In_Weight_7;
            Weight_8 <= In_Weight_8;
            Weight_9 <= In_Weight_9;
        end

        if (in_valid) begin
            IFM_1 <= In_IFM_1;
            IFM_2 <= In_IFM_2;
            IFM_3 <= In_IFM_3;
            IFM_4 <= In_IFM_4;
            IFM_5 <= In_IFM_5;
            IFM_6 <= In_IFM_6;
            IFM_7 <= In_IFM_7;
            IFM_8 <= In_IFM_8;
            IFM_9 <= In_IFM_9;
        end
    end
end


always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
                EXE <= 0;
        else if(in_valid)
                EXE <= 1;
        else
                EXE <= 0;
end

always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
                out_valid <= 0;
        else if(EXE)
                out_valid <= 1;
        else
                out_valid <= 0;
end

always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
                Out_OFM <= 0;
        else if(EXE) begin
                Out_OFM <= IFM_1*Weight_1
                          +IFM_2*Weight_2
                          +IFM_3*Weight_3
                          +IFM_4*Weight_4
                          +IFM_5*Weight_5
                          +IFM_6*Weight_6
                          +IFM_7*Weight_7
                          +IFM_8*Weight_8
                          +IFM_9*Weight_9;
        end
        
        else 
                Out_OFM <= 0;
end
endmodule