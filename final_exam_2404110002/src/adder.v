`timescale 1ns / 1ps

module adder (
	// port list
	clk, 
	rst_n, 
	in1, 
	in2,
	in3,
	in4,
	out
);

// port declaration
input wire clk;
input wire rst_n;
input wire [13:0] in1; // 14-bit operand
input wire [13:0] in2;
input wire [13:0] in3;
input wire [13:0] in4;
output reg [15:0] out; // 16-bit output

/* 1st clock operation */
///////////////////////////////////////////////////////////////////////////////
// 1. add1: in1 + in2
reg [14:0] temp_add1;
always @(posedge clk, negedge rst_n) 
begin
	if ( ~rst_n ) temp_add1 <= 15'b0;
	else temp_add1 <= {1'b0, in1} + {1'b0, in2};
end

// 2. add2: in3+in4
reg [14:0] temp_add2;
always @(posedge clk, negedge rst_n) 
begin
	if ( ~rst_n ) temp_add2 <= 15'b0;
	else temp_add2 <= {1'b0, in3} + {1'b0, in4};
end
///////////////////////////////////////////////////////////////////////////////
/* End of 1st clock operation */


/* 2ed clock operation */
// out: temp_add1 + temp_add2
always @(posedge clk, negedge rst_n) 
begin
	if ( ~rst_n ) out <= 16'b0;
	else out <= {1'b0, temp_add1} + {1'b0, temp_add2};
end
/* End of 2ed clock operation */

	
endmodule
