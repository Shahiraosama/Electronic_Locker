`timescale 1ns/1ps
module Electronic_Lock_TB();
reg Button_0_tb;
reg Button_1_tb;
reg clk_tb;
reg rst_tb;
wire unlock_tb;

localparam T=20;
always 
begin
#(T/2) clk_tb = ~clk_tb;
end

Electronic_Lock DUT (
.clk(clk_tb),
.rst(rst_tb),
.unlock(unlock_tb),
.Button_0(Button_0_tb),
.Button_1(Button_1_tb)
);

initial 
begin
$dumpfile("Locker.vcd");
$dumpvars;

initialize();

reset();

press_buttons(5'b10100,5'b01011); //the first input is for button 0 and the second input is for button 1

wait(unlock_tb)
$display("Locker is unlocked at Time %d ns",$time);

$finish;
end

task initialize;
begin
clk_tb=1'b0;
Button_0_tb = 1'b0;
Button_1_tb=1'b0;
end
endtask

task reset;
begin
rst_tb=1'b1;
#1 
rst_tb=1'b0;
#1
rst_tb=1'b1;

end
endtask

task press_buttons(
  input  reg   [4:0]     button0,
  input  reg   [4:0]     button1
);
  
  integer   i ;
  
begin
  for(i=0;i<5;i=i+1)
   begin
     @(negedge clk_tb) 
     Button_0_tb = button0[i] ;
     Button_1_tb = button1[i] ;
   end   
 end
endtask    


endmodule
