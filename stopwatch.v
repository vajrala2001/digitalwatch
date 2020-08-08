`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 03:10:40 PM
// Design Name: 
// Module Name: stopwatch
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


module sw(start,rst,clk_in, s1_cnt, s2_cnt, s4_cnt, s8_cnt);

input rst,clk_in,start;
//output reg[6:0] s1,s2,s4,s8;
wire clk;

output reg[3:0] s1_cnt, s2_cnt, s4_cnt, s8_cnt;
reg s1_start, s2_start, s4_start, s8_start;

clk_div swc(clk_in,clk);

always@(posedge clk)
    begin
        if(start)
            s1_start = ~s1_start;
        else s1_start=s1_start;
        if(rst)
            begin 
                s1_start=0;
                s8_cnt=0;
                s4_cnt=0;
                s2_cnt=0;
                s1_cnt=0;
            end
            
          else s1_start=s1_start;

    end

//counter for s1 display
always@(posedge clk)
begin
    if(s1_start)
    begin
        
        if(s1_cnt == 4'b1010)
            begin
                s2_start = 1; 
                s1_cnt = 0;
            end
        else
            s1_cnt = s1_cnt + 1;
            
    end

    else
        s2_start = 0;
end

//counter for s2 display
always@(posedge clk)
begin
    if(s2_start)
    begin
        
        s2_start=0;
        if(s2_cnt == 4'b1010)
        begin
            s4_start=1;
            s2_cnt=0;
        end
        
        else
            s2_cnt=s2_cnt+1;
    end
    
    else
        s4_start=0;
end


//counter for s4 display
always@(posedge clk)
begin
    if(s4_start)
    begin
        
        s4_start=0;
        if(s4_cnt == 4'b1010)
        begin
            s8_start=1;
            s4_cnt=0;
        end
        
        else
            s4_cnt=s4_cnt+1;
    end 

    else
        s8_start=0;

end

//counter for s8 display
always@(posedge clk)
begin
    if(s8_start)
    begin
        
        s8_start=0;
        if(s8_cnt == 4'b0111)
        begin
            s8_cnt=0;
            s4_cnt=0;
            s2_cnt=0;
            s1_cnt=0;
            s1_start=1;
        end
        else
            s8_cnt=s8_cnt+1;        
    end
    else
        s8_cnt=s8_cnt;
end
endmodule

