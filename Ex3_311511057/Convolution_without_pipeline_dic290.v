module Convolution_without_pipeline_dic290(
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
reg [7:0] count;  // Counter for weight buffer
reg [7:0] n_out;  // Counter for IFM buffer
integer i;        // Loop iterator

/////// 2 Buffers for IFM and Weight ///////////
reg [15:0] IFM_Buffer [0:48];    // Buffer to store IFM data
reg [15:0] Weight_Buffer [0:8];  // Buffer to store Weight data
/////////////////////////////////////

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

// Calculate weighted sum for convolution
assign Adder = (I0 * Weight_Buffer[0]) + (I1 * Weight_Buffer[1]) + (I2 * Weight_Buffer[2]) +
              (I3 * Weight_Buffer[3]) + (I4 * Weight_Buffer[4]) + (I5 * Weight_Buffer[5]) +
              (I6 * Weight_Buffer[6]) + (I7 * Weight_Buffer[7]) + (I8 * Weight_Buffer[8]);

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
        count <= 0;
        for (i = 0; i < 49; i = i + 1)
            IFM_Buffer[i] <= 0;
    end
    else begin
        if (in_valid) begin
            if (count < 49) begin
                count <= count + 1;
                IFM_Buffer[count] <= In_IFM_1;
            end
        end
        else count <= 0;
    end
end

// Output the calculated data
// Output data & valid
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        n_out <= 0;
        Out_OFM <= 36'd0;
        out_valid <= 1'd0;
    end
    else if (count > 24) begin
        Out_OFM <= Adder;
        out_valid <= 1'd1;
        if (n_out % 7 == 4) n_out <= n_out + 3;
        else n_out <= n_out + 1;
    end
    else begin
        Out_OFM <= 36'd0;
        out_valid <= 1'd0;
        n_out <= 0;
    end
end

endmodule

