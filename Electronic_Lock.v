module Electronic_Lock(
input wire Button_0,Button_1,
input wire clk,rst,
output wire unlock
);
localparam s0=3'b000;
localparam s1=3'b001;
localparam s2=3'b011;
localparam s3=3'b010;
localparam s4=3'b110;
localparam s5=3'b111;

reg [2:0] current_state,next_state;
always@(posedge clk or negedge rst)
begin
if (!rst)
begin
current_state <= s0;

end

else
begin

current_state <= next_state;

end

end

always @(*)
begin

case(current_state)

s0:
begin

if (Button_1)
begin

next_state=s1;

end

else

begin

next_state=current_state;

end

end

s1:

begin

if (Button_0)

begin

next_state=s0;

end

else if(Button_1)

begin

next_state=s2;

end

else

begin

next_state=s1;

end

end

s2:

begin

if (Button_0)

begin

next_state=s3;

end

else if(Button_1)

begin

next_state=s0;

end

else

begin

next_state=s2;

end

end

s3:

begin

if (Button_0)

begin

next_state=s0;

end

else if(Button_1)

begin

next_state=s4;

end

else

begin

next_state=s3;

end


end

s4:

begin

if (Button_0)

begin

next_state=s5;

end

else if(Button_1)

begin

next_state=s0;

end

else

begin

next_state=s4;

end

end

s5:

begin

next_state=s0;

end

default:

begin

next_state=s0;

end


endcase


end
assign unlock=(current_state == s5);
endmodule
