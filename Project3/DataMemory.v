
module DataMem (ReadD, Addr, WriteD, MemR, MemW, CLK, Reset_l);
	input [31:0] Addr, WriteD;
	input MemR, MemW, CLK, Reset_l;
	output [31:0] ReadD;
	reg [31:0] ReadD;
	reg [31:0] Data[4095:0]; //Memory
	integer i;
	

		
	initial	begin
	   Data[0] = 4;	// increment for array index
	   Data[1] = 3;	// number of elements to add
	   Data[2] = 50;	// element A[0]
	   Data[3] = 40;	// element A[1]
	   Data[4] = 30;	// element A[2]
	   Data[5] = 0;	// sum of the array elements
	   Data[6] = 0;
	   Data[7] = 0;
	   Data[8] = 0;	// result of test program 2
	end

	always @ (posedge CLK)
	begin
	if (MemR==1)
			ReadD = Data[Addr>>2];
	end
	
	always @ (negedge CLK)
	begin
		if (MemW==1)
		begin
			Data[Addr>>2] <= WriteD;
			$display("\nSTORE WORD  old MEM[%d]= %d new data= %d\n",Addr>>2 ,Data[Addr>>2], WriteD);
		end
	end
	
	
endmodule
