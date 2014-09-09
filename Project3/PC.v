
module ProgramCounter(Next, Current, Reset_l, startPC,CLK, Jump, ALUzero, Branch, Jumpfield, BranchAddr);
output [31:0] Next;
input [31:0] Current, startPC;
input Reset_l;
input CLK;
input Jump, ALUzero, Branch;
input [25:0]Jumpfield; 
input [31:0]BranchAddr;

reg [31:0] Next;

wire [31:0] BOff,JumpD;
wire [31:0] JumpS;

assign JumpS = Current+32'd4;
assign BOff = BranchAddr<<2;
assign JumpD = {JumpS[31:28], Jumpfield, 2'b00};

always @(posedge Reset_l)
begin
		Next=startPC;
end

always @(negedge CLK)
begin
 
	if (Branch && ALUzero) begin
		Next = Current + 32'd4 + BOff;
		$display("\nBRANCH Next %d",Next);
    end
	else
		if (Jump) 
			Next = JumpD;
		else 
			Next =  Current+32'd4;
 

end
endmodule



