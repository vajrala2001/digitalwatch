`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 03:26:35 PM
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div(clk_in,clk);
input clk_in;
output reg clk;
reg [26:0]count;

always@(posedge clk_in)
begin
    count=count+1;
    if (count==27'd50000000)
        clk=0;
    else if (count==27'd100000000)
    begin
        clk=1;
        count=0;
    end
    
end
endmodule


