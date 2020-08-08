module watch_set(clk_in, rst, mode1, set, cntm0, cntm1, cnth0, cnth1,start_set);
input mode1, set,clk_in,rst;

output reg [3:0] cntm0, cntm1, cnth0, cnth1;
output reg start_set;
reg [2:0] cs ,ns;

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;

always@(posedge rst, posedge clk_in)
begin
    if(rst) begin cs<=s0; cntm0=0; cntm1=0; cnth0=0; cnth1=0; end
    else cs<=ns;
end

always@(mode1, set, cs)

begin
    case(cs)
    s0: begin
        start_set=0;
        if(mode1) ns=s1;
        else ns=s0; 
        if(set) 
        begin
            cntm0=cntm0+1;
            if(cntm0==4'd10) cntm0=0;
        end
        end
    s1: begin
        start_set=0;
        if(mode1) ns=s2;
        else ns=s1;
        if(set)
        begin
            cntm1=cntm1+1;
            if(cntm1==4'd6) cntm1=0;
        end
        end
    s2: begin
        start_set=0;
        if(mode1) ns=s3;
        else ns=s2;
        if(set) 
        begin
            cnth0=cnth0+1;
            if(cnth0==4'd10) cnth0=0;
        end
        end
    s3: begin
        start_set=0;
        if(mode1) ns=s4;
        else ns=s3;
        if(set)
        begin
            cnth1=cnth1+1;
            if(cnth0 > 4'd3 && cnth1==4'd2) 
                cnth1=0 ;
            else 
                begin
                if(cnth1==4'd10) 
                    cnth1=0;
                end
        end
        end
    s4: begin
        if(mode1) ns=s0;
        else ns=s4;
        start_set=1;
        end
    default:begin ns=s0; cntm0=0; cntm1=0; cnth0=0; cnth1=0; end
    endcase
end
endmodule

module tb_watch_set();

reg mode1, set, clk, rst;
wire [3:0] cntm0, cntm1, cnth0, cnth1;
wire start_set;

watch_set tb(clk, rst, mode1, set, cntm0, cntm1, cnth0, cnth1,start_set);

initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin
rst=1;
set=0;
mode1=0;    
#10 
rst=0;
//mode1=0;#10;
//mode1=1;#10;
//mode1=0;#10;

set=0; #20;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;

mode1=0; #10;
mode1=1;set=0; #10;
mode1=0;#10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1; #10;
mode1=0;set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1; #10;
mode1=0;set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1; #10;



mode1=0;#10;
mode1=1;#10;
mode1=0;#10;
//mode1=0;#10;
set=0; #20;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=0; #10;
mode1=1;set=0; #10;
mode1=0;#10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1; #10;
mode1=0;set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1; #10;   
mode1=0;set=0; #10;
set=1; #10;
set=0; #10;
set=1; #10;
set=0; #10;
mode1=1;
end
endmodule