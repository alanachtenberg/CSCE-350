// Texas A&M University          //
// cpsc350 Computer Architecture //
// $Id: dmeminit.v,v 1.2 2002/04/10 02:29:38 miket Exp miket $ //

// NOTE: These file will be expanded //

initial	begin
   Mem[0] = 4;	// increment for array index
   Mem[1] = 3;	// number of elements to add
   Mem[2] = 50;	// element A[0]
   Mem[3] = 40;	// element A[1]
   Mem[4] = 30;	// element A[2]
   Mem[5] = 0;	// sum of the array elements
   Mem[6] = 0;
   Mem[7] = 0;
   Mem[8] = 0;	// result of test program 2
end
