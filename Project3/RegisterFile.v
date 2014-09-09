

module RegisterFile(Read1, Read2, Writedata, Raddr1, Raddr2, Waddr, RegWr, CLK, RESET);
    output [31:0] Read1;
    output [31:0] Read2;
    input [31:0] Writedata;
	input [4:0] Raddr1, Raddr2, Waddr;
    input RegWr, CLK, RESET;
    reg [31:0] registers [0:31];
	
	always @(posedge RESET)
		begin
		registers[0]=0;
		registers[1]=0;
		registers[2]=0;
		registers[3]=0;
		registers[4]=0;
		registers[5]=0;
		registers[6]=0;
		registers[7]=0;
		registers[8]=0;
		registers[9]=0;
		registers[10]=0;
		registers[11]=0;
		registers[12]=0;
		registers[13]=0;
		registers[14]=0;
		registers[15]=0;
		registers[16]=0;
		registers[17]=0;
		registers[18]=0;
		registers[19]=0;
		registers[20]=0;
		registers[21]=0;
		registers[22]=0;
		registers[23]=0;
		registers[24]=0;
		registers[25]=0;
		registers[26]=0;
		registers[27]=0;
		registers[28]=0;
		registers[29]=0;
		registers[30]=0;
		registers[31]=0;
	end
	
	assign Read1 =registers[Raddr1];
	
	assign Read2 =registers[Raddr2];
	
	

	
    always @(negedge CLK) 
	begin
        if(RegWr==1)
		begin
            registers[Waddr] = Writedata;
			$display("----------------------------------\nREGWRITE Reg %d current %d new %d\n----------------------------------" ,Waddr, registers[Waddr], Writedata );
		end
			 
    end
	/*
	always @ (CLK)
	 begin
	 $display("----------------------------------------------\n");
	 $display("time %0d\t \n", $time);
	 $display("Reg10 %d " ,registers[10] );
	 $display("Reg11 %d " ,registers[11] );
	 $display("Reg12 %d " ,registers[12] );
	 $display("Reg13 %d " ,registers[13] );
	 $display("Reg14 %d " ,registers[14] );
	 $display("Reg15 %d " ,registers[15] );
	 $display("Reg16 %d " ,registers[16] );
	end
	 */
endmodule
