module Convolution_optimize_dic290(
	//input
clk,
rst_n,
in_valid,
weight_valid,
In_IFM_1,
In_Weight_1,
//output
out_valid, 
Out_OFM	

);

input clk, rst_n, in_valid, weight_valid;
input [15:0]In_IFM_1;		
input [15:0]In_Weight_1;

//////////////The output port shoud be registers///////////////////////
output reg out_valid;
output reg[35:0] Out_OFM;
//////////////////////////////////////////////////////////////////////


integer i, j;
reg [5:0]count;
/////// 2 Buffer/////////////
//You have to sue these buffers for the 3-1 & 3-2 /////// 
reg [15:0]IFM_Buffer[0:48] ;   //  Use this buffer to store IFM
reg [15:0]Weight_Buffer[0:8];  //  Use this buffer to store Weight
/////////////////////////////////////


////////Here just an example of how to use IFM_buffer & WEight_Buffer to store data////////
//The storage mechanism can be modified, but not the buffer size cannot be modified
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for (i=0;i<9;i=i+1) 
			Weight_Buffer[i] <= 0;
	end
	else if(weight_valid && count < 9)
		Weight_Buffer[count] <= In_Weight_1;
end
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for (i=0;i<49;i=i+1) 
			IFM_Buffer[i] <= 0;
	end
	else if(in_valid && count < 49) begin
		IFM_Buffer[count]  <= In_IFM_1;
	end                

end
///////////////////////////////////////////////////////

parameter IDLE = 0;
parameter OUT  = 1;


reg cur_state;
reg nxt_state;



reg [15:0]conv_in[0:8];
reg [15:0]conv_in_seq[0:8];


reg [31:0]multi_out[0:8];

reg [33:0]add_3_0;
reg [31:0]add_3_1;
reg [33:0]add_3_2;

always @(*) begin
	case(cur_state)
		IDLE : begin
			if(count == 28) begin
				nxt_state = OUT;
			end
			else begin
				nxt_state = IDLE;
			end
		end

		OUT : begin
			if(count == 0) begin
				nxt_state = IDLE;
			end
			else begin
				nxt_state = OUT;
			end
		end

		default : begin
			nxt_state = IDLE;
		end
	endcase
end


always @(*) begin
    // default <begin>
	for(i = 0; i < 9; i = i + 1) begin
		conv_in[i] = 0;
	// default <end>	
	end
	case(count)
		25 : begin
			conv_in[0] = IFM_Buffer[0];
			conv_in[1] = IFM_Buffer[1];
			conv_in[2] = IFM_Buffer[2];
			conv_in[3] = IFM_Buffer[7];
			conv_in[4] = IFM_Buffer[8];
			conv_in[5] = IFM_Buffer[9];
			conv_in[6] = IFM_Buffer[14];
			conv_in[7] = IFM_Buffer[15];
			conv_in[8] = IFM_Buffer[16];
		end
		26 : begin
			conv_in[0] = IFM_Buffer[1];
			conv_in[1] = IFM_Buffer[2];
			conv_in[2] = IFM_Buffer[3];
			conv_in[3] = IFM_Buffer[8];
			conv_in[4] = IFM_Buffer[9];
			conv_in[5] = IFM_Buffer[10];
			conv_in[6] = IFM_Buffer[15];
			conv_in[7] = IFM_Buffer[16];
			conv_in[8] = IFM_Buffer[17];
		end
		27 : begin
			conv_in[0] = IFM_Buffer[2];
			conv_in[1] = IFM_Buffer[3];
			conv_in[2] = IFM_Buffer[4];
			conv_in[3] = IFM_Buffer[9];
			conv_in[4] = IFM_Buffer[10];
			conv_in[5] = IFM_Buffer[11];
			conv_in[6] = IFM_Buffer[16];
			conv_in[7] = IFM_Buffer[17];
			conv_in[8] = IFM_Buffer[18];
		end
		28 : begin
			conv_in[0] = IFM_Buffer[3];
			conv_in[1] = IFM_Buffer[4];
			conv_in[2] = IFM_Buffer[5];
			conv_in[3] = IFM_Buffer[10];
			conv_in[4] = IFM_Buffer[11];
			conv_in[5] = IFM_Buffer[12];
			conv_in[6] = IFM_Buffer[17];
			conv_in[7] = IFM_Buffer[18];
			conv_in[8] = IFM_Buffer[19];
		end
		29 : begin
			conv_in[0] = IFM_Buffer[4];
			conv_in[1] = IFM_Buffer[5];
			conv_in[2] = IFM_Buffer[6];
			conv_in[3] = IFM_Buffer[11];
			conv_in[4] = IFM_Buffer[12];
			conv_in[5] = IFM_Buffer[13];
			conv_in[6] = IFM_Buffer[18];
			conv_in[7] = IFM_Buffer[19];
			conv_in[8] = IFM_Buffer[20];
		end

		
		30 : begin
			conv_in[0] = IFM_Buffer[7];
			conv_in[1] = IFM_Buffer[8];
			conv_in[2] = IFM_Buffer[9];
			conv_in[3] = IFM_Buffer[14];
			conv_in[4] = IFM_Buffer[15];
			conv_in[5] = IFM_Buffer[16];
			conv_in[6] = IFM_Buffer[21];
			conv_in[7] = IFM_Buffer[22];
			conv_in[8] = IFM_Buffer[23];
		end
		31 : begin
			conv_in[0] = IFM_Buffer[8];
			conv_in[1] = IFM_Buffer[9];
			conv_in[2] = IFM_Buffer[10];
			conv_in[3] = IFM_Buffer[15];
			conv_in[4] = IFM_Buffer[16];
			conv_in[5] = IFM_Buffer[17];
			conv_in[6] = IFM_Buffer[22];
			conv_in[7] = IFM_Buffer[23];
			conv_in[8] = IFM_Buffer[24];
		end
		32 : begin
			conv_in[0] = IFM_Buffer[9];
			conv_in[1] = IFM_Buffer[10];
			conv_in[2] = IFM_Buffer[11];
			conv_in[3] = IFM_Buffer[16];
			conv_in[4] = IFM_Buffer[17];
			conv_in[5] = IFM_Buffer[18];
			conv_in[6] = IFM_Buffer[23];
			conv_in[7] = IFM_Buffer[24];
			conv_in[8] = IFM_Buffer[25];
		end
		33 : begin
			conv_in[0] = IFM_Buffer[10];
			conv_in[1] = IFM_Buffer[11];
			conv_in[2] = IFM_Buffer[12];
			conv_in[3] = IFM_Buffer[17];
			conv_in[4] = IFM_Buffer[18];
			conv_in[5] = IFM_Buffer[19];
			conv_in[6] = IFM_Buffer[24];
			conv_in[7] = IFM_Buffer[25];
			conv_in[8] = IFM_Buffer[26];
		end
		34 : begin
			conv_in[0] = IFM_Buffer[11];
			conv_in[1] = IFM_Buffer[12];
			conv_in[2] = IFM_Buffer[13];
			conv_in[3] = IFM_Buffer[18];
			conv_in[4] = IFM_Buffer[19];
			conv_in[5] = IFM_Buffer[20];
			conv_in[6] = IFM_Buffer[25];
			conv_in[7] = IFM_Buffer[26];
			conv_in[8] = IFM_Buffer[27];
		end


		35 : begin
			conv_in[0] = IFM_Buffer[14];
			conv_in[1] = IFM_Buffer[15];
			conv_in[2] = IFM_Buffer[16];
			conv_in[3] = IFM_Buffer[21];
			conv_in[4] = IFM_Buffer[22];
			conv_in[5] = IFM_Buffer[23];
			conv_in[6] = IFM_Buffer[28];
			conv_in[7] = IFM_Buffer[29];
			conv_in[8] = IFM_Buffer[30];
		end
		36 : begin
			conv_in[0] = IFM_Buffer[15];
			conv_in[1] = IFM_Buffer[16];
			conv_in[2] = IFM_Buffer[17];
			conv_in[3] = IFM_Buffer[22];
			conv_in[4] = IFM_Buffer[23];
			conv_in[5] = IFM_Buffer[24];
			conv_in[6] = IFM_Buffer[29];
			conv_in[7] = IFM_Buffer[30];
			conv_in[8] = IFM_Buffer[31];
		end
		37 : begin
			conv_in[0] = IFM_Buffer[16];
			conv_in[1] = IFM_Buffer[17];
			conv_in[2] = IFM_Buffer[18];
			conv_in[3] = IFM_Buffer[23];
			conv_in[4] = IFM_Buffer[24];
			conv_in[5] = IFM_Buffer[25];
			conv_in[6] = IFM_Buffer[30];
			conv_in[7] = IFM_Buffer[31];
			conv_in[8] = IFM_Buffer[32];
		end
		38 : begin
			conv_in[0] = IFM_Buffer[17];
			conv_in[1] = IFM_Buffer[18];
			conv_in[2] = IFM_Buffer[19];
			conv_in[3] = IFM_Buffer[24];
			conv_in[4] = IFM_Buffer[25];
			conv_in[5] = IFM_Buffer[26];
			conv_in[6] = IFM_Buffer[31];
			conv_in[7] = IFM_Buffer[32];
			conv_in[8] = IFM_Buffer[33];
		end
		39 : begin
			conv_in[0] = IFM_Buffer[18];
			conv_in[1] = IFM_Buffer[19];
			conv_in[2] = IFM_Buffer[20];
			conv_in[3] = IFM_Buffer[25];
			conv_in[4] = IFM_Buffer[26];
			conv_in[5] = IFM_Buffer[27];
			conv_in[6] = IFM_Buffer[32];
			conv_in[7] = IFM_Buffer[33];
			conv_in[8] = IFM_Buffer[34];
		end


		40 : begin
			conv_in[0] = IFM_Buffer[21];
			conv_in[1] = IFM_Buffer[22];
			conv_in[2] = IFM_Buffer[23];
			conv_in[3] = IFM_Buffer[28];
			conv_in[4] = IFM_Buffer[29];
			conv_in[5] = IFM_Buffer[30];
			conv_in[6] = IFM_Buffer[35];
			conv_in[7] = IFM_Buffer[36];
			conv_in[8] = IFM_Buffer[37];
		end
		41 : begin
			conv_in[0] = IFM_Buffer[22];
			conv_in[1] = IFM_Buffer[23];
			conv_in[2] = IFM_Buffer[24];
			conv_in[3] = IFM_Buffer[29];
			conv_in[4] = IFM_Buffer[30];
			conv_in[5] = IFM_Buffer[31];
			conv_in[6] = IFM_Buffer[36];
			conv_in[7] = IFM_Buffer[37];
			conv_in[8] = IFM_Buffer[38];
		end
		42 : begin
			conv_in[0] = IFM_Buffer[23];
			conv_in[1] = IFM_Buffer[24];
			conv_in[2] = IFM_Buffer[25];
			conv_in[3] = IFM_Buffer[30];
			conv_in[4] = IFM_Buffer[31];
			conv_in[5] = IFM_Buffer[32];
			conv_in[6] = IFM_Buffer[37];
			conv_in[7] = IFM_Buffer[38];
			conv_in[8] = IFM_Buffer[39];
		end
		43 : begin
			conv_in[0] = IFM_Buffer[24];
			conv_in[1] = IFM_Buffer[25];
			conv_in[2] = IFM_Buffer[26];
			conv_in[3] = IFM_Buffer[31];
			conv_in[4] = IFM_Buffer[32];
			conv_in[5] = IFM_Buffer[33];
			conv_in[6] = IFM_Buffer[38];
			conv_in[7] = IFM_Buffer[39];
			conv_in[8] = IFM_Buffer[40];
		end
		44 : begin
			conv_in[0] = IFM_Buffer[25];
			conv_in[1] = IFM_Buffer[26];
			conv_in[2] = IFM_Buffer[27];
			conv_in[3] = IFM_Buffer[32];
			conv_in[4] = IFM_Buffer[33];
			conv_in[5] = IFM_Buffer[34];
			conv_in[6] = IFM_Buffer[39];
			conv_in[7] = IFM_Buffer[40];
			conv_in[8] = IFM_Buffer[41];
		end


		45 : begin
			conv_in[0] = IFM_Buffer[28];
			conv_in[1] = IFM_Buffer[29];
			conv_in[2] = IFM_Buffer[30];
			conv_in[3] = IFM_Buffer[35];
			conv_in[4] = IFM_Buffer[36];
			conv_in[5] = IFM_Buffer[37];
			conv_in[6] = IFM_Buffer[42];
			conv_in[7] = IFM_Buffer[43];
			conv_in[8] = IFM_Buffer[44];
		end
		46 : begin
			conv_in[0] = IFM_Buffer[29];
			conv_in[1] = IFM_Buffer[30];
			conv_in[2] = IFM_Buffer[31];
			conv_in[3] = IFM_Buffer[36];
			conv_in[4] = IFM_Buffer[37];
			conv_in[5] = IFM_Buffer[38];
			conv_in[6] = IFM_Buffer[43];
			conv_in[7] = IFM_Buffer[44];
			conv_in[8] = IFM_Buffer[45];
		end
		47 : begin
			conv_in[0] = IFM_Buffer[30];
			conv_in[1] = IFM_Buffer[31];
			conv_in[2] = IFM_Buffer[32];
			conv_in[3] = IFM_Buffer[37];
			conv_in[4] = IFM_Buffer[38];
			conv_in[5] = IFM_Buffer[39];
			conv_in[6] = IFM_Buffer[44];
			conv_in[7] = IFM_Buffer[45];
			conv_in[8] = IFM_Buffer[46];
		end
		48 : begin
			conv_in[0] = IFM_Buffer[31];
			conv_in[1] = IFM_Buffer[32];
			conv_in[2] = IFM_Buffer[33];
			conv_in[3] = IFM_Buffer[38];
			conv_in[4] = IFM_Buffer[39];
			conv_in[5] = IFM_Buffer[40];
			conv_in[6] = IFM_Buffer[45];
			conv_in[7] = IFM_Buffer[46];
			conv_in[8] = IFM_Buffer[47];
		end
		49 : begin
			conv_in[0] = IFM_Buffer[32];
			conv_in[1] = IFM_Buffer[33];
			conv_in[2] = IFM_Buffer[34];
			conv_in[3] = IFM_Buffer[39];
			conv_in[4] = IFM_Buffer[40];
			conv_in[5] = IFM_Buffer[41];
			conv_in[6] = IFM_Buffer[46];
			conv_in[7] = IFM_Buffer[47];
			conv_in[8] = IFM_Buffer[48];
		end

	endcase
end

always @(posedge clk) begin
	// if(!rst_n) begin
	// 	for(i = 0; i < 9; i = i + 1) begin
	// 		conv_in_seq[i] <= 0;
	// 	end
	// end
	// else begin
		for(i = 0; i < 9; i = i + 1) begin
			conv_in_seq[i] <= conv_in[i];
		end
	// end
end



always @(posedge clk) begin
	// if(!rst_n) begin
	// 	for(i = 0; i < 9; i = i + 1) begin
	// 		multi_out[i] <= 0;
	// 	end
	// end
	// else begin
		for(i = 0; i < 9; i = i + 1) begin
			multi_out[i] <= conv_in_seq[i] * Weight_Buffer[i];
		end
	// end

end

always @(posedge clk) begin
    // if(!rst_n) begin
    //     add_3_0 <= 0;
    //     add_3_1 <= 0;
    //     add_3_2 <= 0;
    // end
    // else begin
        add_3_0 <= multi_out[0] + multi_out[1] + multi_out[2] + multi_out[3];
        add_3_1 <= multi_out[4];
        add_3_2 <= multi_out[5] + multi_out[6] + multi_out[7] + multi_out[8];
    // end

end


always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		count <= 0;

		cur_state <= IDLE;
	end
	else begin
		count <= (in_valid) ? count + 1 : (count < 52 && count > 0) ? count + 1 : 0;

		cur_state <= nxt_state;
	end
end


always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		out_valid <= 0;
		Out_OFM <= 0;
	end
	else begin
		out_valid <= (nxt_state == OUT) ? 1 : 0;
		Out_OFM <= add_3_0 + add_3_1 + add_3_2;
	end
end



endmodule