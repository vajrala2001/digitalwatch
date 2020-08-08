module alarm_clock(clk,mode,set,rst,ym0,ym1,yh0,yh1,buzzer,start);
input mode,set,buzzer,rst,clk;

parameter statem0=3'd0;
parameter statem1=3'd1;
parameter stateh0=3'd2;
parameter stateh1=3'd3;
parameter state_start=3'd4;
reg [2:0] cs,ns;
output reg [3:0]ym0,yh0,yh1,ym1;
output reg start;
reg [3:0]dm0,dh0,dh1,dm1;

always@(dm1 or dm0 or dh0 or dh1)
begin
	ym0=dm0;
	ym1=dm1;
	yh0=dh0;
	yh1=dh1;
end

always@(posedge rst or posedge clk)
begin
	if(rst) begin
		dm0=0;
		dm1=0;
		dh0=0;
		dh1=0;
		start=0;
		cs<=statem0;
		end
		else  cs<=ns; 
	end


always@(buzzer)
begin
if(buzzer)
begin
	dm0=0;
	dm1=0;
	dh0=0;
	dh1=0;
end
end


always@( posedge mode or posedge set or cs )
begin
case(cs)
statem0:begin 
	if(mode) ns=statem1;
	else ns=statem0;
	if(set)
		begin 
		dm0=dm0+1;
		if(dm0==4'b1010)dm0=4'b0000;
		end 
	end
statem1:begin
	if(mode) ns=stateh0;
	else ns=statem1;
	if(set)
		begin
		dm1=dm1+1;
		if(dm1==4'b0110)dm1=4'b0000;
		end
	end
stateh0:begin
	if(mode) ns=stateh1;
	else ns=stateh0;
	if(set)
		begin
		dh0=dh0+1;
		if(dh0==4'b1010)dh0=4'b0000;
		end
	end
stateh1:begin
	if(mode) ns=state_start;
	else ns=stateh1;
	if(set)
		begin
		dh1=dh1+1;
		if(dh0>4'b0011 && dh1==4'b0010)dh1=4'b0000;
		if(dh1==4'b0011)dh1=4'b0000;
		end 
	end
state_start:begin
	if(mode) ns=statem1;
	else ns=state_start;
	    begin 
			start=1;         
      	end
      	end
default: begin 
	if(mode) ns=statem1;
	else ns=statem0;
	if(set)
		begin 
		dm0=dm0+1;
		if(dm0==4'b1010)dm0=4'b0000;
		end 
	end
endcase
end
endmodule

/*
module alarm_clock_tb();

reg  mode,set,buzzer,rst,clk;
wire  [3:0]ym0,yh0,yh1,ym1;
wire  start;

alarm_clock test(clk,mode,set,rst,ym0,ym1,yh0,yh1,buzzer,start);

initial
begin
	clk=0;
	forever #5 clk=~clk;
end
initial
begin
	rst=1;mode=0;set=0;buzzer=0; 	
	#5  rst=0;mode=0;set=1;

	#5 set=0; #8  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;	
	#5 set=0; #5  rst=0;mode=0;set=1;
	
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=1; #5 set=1; #5;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;	
	#5 set=0; #5  rst=0;mode=1;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;
	#5 set=0; #5  rst=0;mode=1;set=1;
	#5 set=0; #5  rst=0;mode=0;set=1;	
	#5 set=0; #5  rst=0;mode=0;set=1;
	
end
endmodule*/

