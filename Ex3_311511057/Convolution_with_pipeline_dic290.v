module Convolution_with_pipeline_dic290(
    input clk, rst_n,            // Clock and asynchronous active-low reset
    input in_valid, weight_valid, // Valid signals for input IFM and Weight
    input [15:0] In_IFM_1,       // Input data for IFM
    input [15:0] In_Weight_1,    // Input data for Weight
    output reg out_valid,        // Output valid signal
    output reg [35:0] Out_OFM    // Output data for OFM
);

// Intermediate wires for IFM elements
wire [15:0] I0, I1, I2, I3, I4, I5, I6, I7, I8;
// Intermediate wire for weighted sum
wire [35:0] Adder;
// Counters for indexing
reg [7:0] count, n_out;
integer i;

/////// 2 Buffers for IFM and Weight ///////////
reg [15:0] IFM_Buffer [0:48];    // Buffer to store IFM data
reg [15:0] Weight_Buffer [0:8];  // Buffer to store Weight data
/////////////////////////////////////

/////// Pipeline registers ///////
reg [31:0] pipe1 [0:8];
reg [32:0] pipe2 [0:4];
reg [33:0] pipe3 [0:2];
reg [34:0] pipe4 [0:1];

// Connect IFM elements from buffers
assign I0 = IFM_Buffer[n_out];
assign I1 = IFM_Buffer[n_out+1];
assign I2 = IFM_Buffer[n_out+2];
assign I3 = IFM_Buffer[n_out+7];
assign I4 = IFM_Buffer[n_out+8];
assign I5 = IFM_Buffer[n_out+9];
assign I6 = IFM_Buffer[n_out+14];
assign I7 = IFM_Buffer[n_out+15];
assign I8 = IFM_Buffer[n_out+16];
assign Adder = pipe4[0] + pipe4[1];

//////// Example of using IFM_buffer & Weight_Buffer to store data ////////
// Storage mechanism can be modified, but not the buffer size
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 9; i = i + 1)
            Weight_Buffer[i] <= 0;
    end
    else if (weight_valid && count < 9)
        Weight_Buffer[count] <= In_Weight_1;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        n_out <= 0;
        count <= 0;
        for (i = 0; i < 49; i = i + 1)
            IFM_Buffer[i] <= 0;
    end
    else begin
        if (in_valid) begin
            count <= count + 1;
            if (count < 49) IFM_Buffer[count] <= In_IFM_1;
        end
        else if (out_valid == 0 || count > 52) count <= 0;
        else count <= count + 1;

        if (count > 24) begin
            if (n_out % 7 == 4) n_out <= n_out + 3;
            else n_out <= n_out + 1;
        end
        else n_out <= 0;
    end
end

// Output the calculated data
// Output data & valid
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Out_OFM <= 36'd0;
        out_valid <= 1'd0;
    end
    else if (count > 28) begin
        Out_OFM <= Adder;
        out_valid <= 1'd1;
    end
    else begin
        Out_OFM <= 36'd0;
        out_valid <= 1'd0;
    end
end

// Pipeline stages for convolution calculation
always @(posedge clk) begin
    pipe1[0] <= I0 * Weight_Buffer[0];
    pipe1[1] <= I1 * Weight_Buffer[1];
    pipe1[2] <= I2 * Weight_Buffer[2];
    pipe1[3] <= I3 * Weight_Buffer[3];
    pipe1[4] <= I4 * Weight_Buffer[4];
    pipe1[5] <= I5 * Weight_Buffer[5];
    pipe1[6] <= I6 * Weight_Buffer[6];
    pipe1[7] <= I7 * Weight_Buffer[7];
    pipe1[8] <= I8 * Weight_Buffer[8];
    pipe2[0] <= pipe1[0] + pipe1[1];
    pipe2[1] <= pipe1[2] + pipe1[3];
    pipe2[2] <= pipe1[4] + pipe1[5];
    pipe2[3] <= pipe1[6] + pipe1[7];
    pipe2[4] <= pipe1[8];
    pipe3[0] <= pipe2[0] + pipe2[1];
    pipe3[1] <= pipe2[2] + pipe2[3];
    pipe3[2] <= pipe2[4];
    pipe4[0] <= pipe3[0] + pipe3[1];
    pipe4[1] <= pipe3[2];
end

endmodule

