module digitalwatch(clk_in,mode,mode1,set,rst,buzzer,dis0,dis1,dis2,dis3,led1, start_set);
input clk_in,mode,set,rst,mode1;
reg [3:0]countm0,counth0;
reg [3:0]counth1;
reg [3:0]countm1;
reg [3:0] ssm0,ssm1,ssh0,ssh1; // the outputs that should be displayed on seven segment
reg clk;
reg[2:0] cs,ns;
output reg  buzzer,led1;// for alarm and timer
reg [2:0] flag;
output reg [6:0] dis0,dis1,dis2,dis3;
reg  start_alarm;

reg [3:0] cntm0, cntm1, cnth0, cnth1;//setting watch
reg [3:0]ym0,yh0,yh1,ym1;  //for alarm
reg[3:0] s1_cnt, s2_cnt, s4_cnt, s8_cnt; //for stopwatch
reg[6:0] y1,y2,y3,y4;  //for timer
reg mode1_alarm,mode1_set,mode1_sw,mode1_timer;
reg set_alarm,set_sw,set_timer,set_set;
output reg start_set; 

parameter s0=3'd0;
parameter s1=3'd1;
parameter s2=3'd2;
parameter s3=3'd3;
parameter s4=3'd4;

watch_set wset(clk_in,rst,mode1_set, set_set, cntm0, cntm1, cnth0, cnth1,start_set);//setting watch
timer t(clk_in,rst,set_timer,mode1_timer,y1,y2,y3,y4,led1);//timer
sw stop(set_sw,rst,clk_in, s1_cnt, s2_cnt, s4_cnt, s8_cnt); //stopwatch
alarm_clock a(clk_in,mode1_alarm,set_alarm,rst, alarm,ym0,ym1,yh0,yh1,buzzer,start_alarm); //alarm clock
//seven segemnt output
disp ssegm0(dis0,ssm0);
disp ssegm1(dis1,ssm1);
disp ssegh0(dis2,ssh0);
disp ssegh1(dis3,ssh1);


clk_div c(clk_in,clk);

always@(posedge clk)
begin


	
	if(countm0==4'b1010)
		begin 
			countm1=countm1+1;
			countm0=4'b0000;
		end


	else if(countm1==4'b0110)
		begin
			counth0=counth0+1;
			countm1=4'b0000;
		end


	else if(counth0==4'b1010)
		begin
			counth1=counth1+1;
			counth0=4'b0000;
		end
	else if(counth1==4'b0010 && counth0==4'b0100)
		begin
			countm0=4'b0000;
			countm1=4'b0000;
			counth0=4'b0000;
			counth1=4'b0000;
		end
    else countm0=countm0+1;
end

always@(posedge mode, posedge set , posedge start_alarm,cs,posedge start_set)
begin
    case (cs)
    s0: begin
            flag=3'd0;
            if(mode) begin ns=s1;end
            else
            begin
                ns=s0;
            end
        end
    s1: begin
            flag=3'd1;
            if(mode) ns=s2;
            else ns=s1;
            if(start_set)  begin
            countm0=cntm0;
            countm1=cntm1;
            counth0=cnth0;
            counth1=cnth1; end
        end
    s2: begin   
            flag=3'd2;
            if(mode)  ns=s3;
            else    ns=s2;
        end
        
    s3: begin
            flag=3'd3;
                if(mode) ns=s4;
                else
                begin
                     ns=s3;
                    if(start_alarm==1&&(countm0==ym0 || countm1==ym1 || counth0==yh0 || counth1==yh1)) buzzer=1;
                end
        end
     s4: begin
            flag=3'd4;
            if(mode) ns=s0;
            else ns=s4;
            end
     default: ns=s0;
    endcase
    end


 always@(flag)
 begin
     case(flag)
     0:begin //dw
         ssm0=countm0;
         ssm1=countm1;
         ssh0=counth0;
         ssh1=counth1;
         mode1_alarm=0; mode1_set=0; mode1_sw=0; mode1_timer=0 ;
         set_alarm=0; set_sw=0; set_timer=0; set_set=0;
     end
     1:begin//set
        ssm0=cntm0;
        ssm1=cntm1;
        ssh0=cnth0;
        ssh1=cnth1;
        mode1_set=mode1;
        set_set=set;
        mode1_alarm=0; mode1_sw=0; mode1_timer=0 ;
        set_alarm=0; set_sw=0; set_timer=0;
     end 

     2:begin  //stopwatch
         ssm0=s1_cnt;
         ssm1=s2_cnt;
         ssh0=s4_cnt;
         ssh1=s8_cnt;
         mode1_sw=mode1;
         set_sw=set;
         mode1_alarm=0; mode1_set=0; mode1_timer=0 ;
         set_alarm=0; set_timer=0; set_set=0;
         
     end
     3:begin //alarm
         ssm0=ym0;
         ssm1=ym1;
         ssh0=yh0;
         ssh1=yh1;
         mode1_alarm=mode1;
         set_alarm=set;
         mode1_set=0; mode1_sw=0; mode1_timer=0 ;
         set_sw=0; set_timer=0; set_set=0;
     end
     4:timer; //timer
     default:begin
         ssm0=y1;
         ssm1=y2;
         ssh0=y3;
         ssh1=y4;
         mode1_timer=mode1;
         set_timer=set;
         mode1_alarm=0; mode1_set=0; mode1_sw=0;
         set_alarm=0; set_sw=0; set_set=0;
     end
     endcase
end 

endmodule