//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 04:16:35 PM
// Design Name: 
// Module Name: timer1
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


module timer1(clk,en,s1,s2,s3,s4,led);
input[3:0] s1,s2,s3,s4;
input clk,en;
output led;
reg[3:0] z1,z2,z3,z4;

assign clk1=en&&clk;

always@(en)
begin
z1=s1;
z2=s2;
z3=s3;
z4=s4;
end

always@(posedge clk1)
begin
if(z1==4'b0000&&((z2||z3||z4)!=4'b0000))
z1=4'b1001;
else if(z1!=4'b0000)
z1=z1-4'b0001;
else
z1=z1;
end

always@(posedge z1[3])
begin
if(z2==4'b0000&&((z3||z4)!=4'b0000))
z2=4'b0101;
else if(z2!=4'b0000)
z2=z2-4'b0001;
else 
z2=z2;
end

always@(posedge z2[2])
begin
if(z3==4'b0000&&(z4!=4'b0000))
z3=4'b1001;
else if(z3!=4'b0000)
z3=z3-4'b0001;
else
z3=z3;
end

always@(posedge z3[3])
begin
if(z4!=4'b0000)
z4=z4-4'b0001;
else
z4=z4;
end

assign  led=((z1||z2||z3||z4))?0:1;


endmodule

module timer1_testbench();
reg clk,en;
reg[3:0] s1,s2,s3,s4;
wire led;

timer1 test(clk,en,s1,s2,s3,s4,led);
initial begin
clk=1'b0;
forever #5 clk=~clk;
end

initial begin
en=0;s1=4'b0111;s2=4'b0100;s3=4'b0111;s4=4'b0001;
#10 en=1;
end

endmodule
