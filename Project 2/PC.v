
module ProgramCounter(Next, Current, Reset_l, startPC,CLK);
output [31:0] Next;
input [31:0] Current, startPC;
input Reset_l;
input CLK;

reg [31:0] Next;

always @(negedge CLK)
begin
 if (Reset_l==0)
	Next<=startPC;
 else
 Next <= Current+32'd4;
end
endmodule
