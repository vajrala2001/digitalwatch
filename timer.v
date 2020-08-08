module timer(clk_in,rst,start,mode,y1,y2,y3,y4,led1);
input clk_in,rst,start,mode;
output led1;
output reg[3:0] y1,y2,y3,y4;   
reg[3:0] x1,x2,x3,x4;
reg[2:0] c_s,n_s;
reg enp;
wire clk;

parameter s_0=3'b000;
parameter s_1=3'b001;
parameter s_2=3'b010;
parameter s_3=3'b011;
parameter s_4=3'b100;
parameter s_5=3'b101;

clk_div c1(clk_in,clk);

always@(x1 or x2 or x3 or x4)
begin
    y1=x1;
    y2=x2;
    y3=x3;
    y4=x4;
end
always@(posedge clk,posedge rst)
begin
if(rst) c_s<=s_0;
else c_s<=n_s;
end

always@(c_s or start or mode) 
begin
case(c_s)
s_0 : begin
      enp=1'b0;
      x1=4'b0000;
      x2=4'b0000;
      x3=4'b0000;
      x4=4'b0000;
      if(mode) n_s=s_1;
      else n_s=s_0;
      end
s_1 : if(mode) begin
               n_s=s_2;
               end
      else begin
           n_s=s_1;
           if(start) x1=x1+4'b0001;
           else x1=x1;
           end
s_2 : if(mode) begin
               n_s=s_3;
               end
      else begin
           n_s=s_2;
           if(start) x2=x2+4'b0001;
           else x2=x2;
           end
s_3 : if(mode) begin
               n_s=s_4;
               end
      else begin
           n_s=s_3;
           if(start) x3=x3+4'b0001;
           else x3=x3;
           end
s_4 : if(mode) begin
               n_s=s_5;
               end
      else begin
           n_s=s_4;
           if(start) x4=x4+4'b0001;
           else x4=x4;
           end
s_5 : if(mode) begin
               n_s=s_0;
               end
      else begin
           n_s=s_5;
           if(start) enp=1'b1;
           else enp=1'b0;
           end
endcase
end

timer1 t1(clk,enp,x1,x2,x3,x4,led1);

endmodule
        
       
/*module timer_testbench();

reg clk,rst,start,mode;
wire[3:0] y1,y2,y3,y4;
wire led1;

timer test(clk,rst,start,mode,y1,y2,y3,y4,led1);

initial begin
clk=1'b0;
forever #5 clk=~clk;
end

initial begin
rst=1;start=0;mode=0;
#10 rst=0;mode=1;
#10 mode=0;start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#10 start=0;mode=1;
#10 mode=0;start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#10 start=0;mode=1;
#10 mode=0;start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#7 start=0;#3 start=1;
#10 start=0;mode=1;
#10 mode=0;start=1;
#10 mode=0;start=0;
#10 mode=1;
#10 mode=0;start=1;

end
endmodule*/










