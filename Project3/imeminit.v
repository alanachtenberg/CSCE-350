// Texas A&M University          //
// cpsc350 Computer Architecture //
// $Id: imeminit.v,v 1.2 2002/11/19 18:10:59 miket Exp miket $ //

// NOTE:  Expanded these tests to cover all instructions supported by your datapath //

initial	begin
// 
// Test Program 1 - Sums the elements of array A[]
//
   Mem[0] = {6'd0,5'd0,5'd0,5'd5,5'd0,6'd32};
   //			add	$5, $0, $0	# this is the sum
   Mem[1] = {6'd0,5'd0,5'd0,5'd2,5'd0,6'd32};
   //			add	$2, $0, $0	# this is our array index
   Mem[2] = {6'd35,5'd0,5'd3,16'd4};
   //			lw	$3, 4($0)	# $3 = DMem[1] = num to add
   Mem[3] = {6'd0,5'd3,5'd3,5'd3,5'd0,6'd32};
   //			add	$3, $3, $3	# $3 = 2 * DMem[1]
   Mem[4] = {6'd0,5'd3,5'd3,5'd3,5'd0,6'd32};
   //			add	$3, $3, $3	# $3 = 4 * DMem[1]
   Mem[5] = {6'd35,5'd0,5'd7,16'd0};
   //			lw	$7, 0($0)	# $7 = DMem[0] = increment
   Mem[6] = {6'd4,5'd2,5'd3,16'd4};
   //		label:	beq	$2, $3, done	# our loop
   Mem[7] = {6'd35,5'd2,5'd6,16'd8};
   //			lw	$6, 8($2)	# load Array[$2]
   Mem[8] = {6'd0,5'd5,5'd6,5'd5,5'd0,6'd32};
   //			add	$5, $5, $6	# add it into the sum
   Mem[9] = {6'd0,5'd2,5'd7,5'd2,5'd0,6'd32};
   //			add	$2, $2, $7	# next address
   Mem[10] = {6'd4,5'd0,5'd0,-16'd5};
   //			beq	$0, $0, label	# jump to label
   Mem[11] = {6'd43,5'd2,5'd5,16'd8};
   //		done:	sw	$5, 8($2)	# store the sum in DMem[5]
   Mem[12] = {6'd0,5'd0,5'd0,16'd0};
   //			nop			# 
   Mem[13] = {6'd0,5'd0,5'd0,16'd0};
   //			nop			# 
   //
   // Test Program 2
   //
   Mem[14] = {6'd8,5'd0,5'd1,16'd1};
   //			addi	$1, $0, 1	# $1 = 1
   Mem[15] = {6'd0,5'd0,5'd1,5'd2,5'd0,6'd34};
   //			sub	$2, $0, $1	# $2 = -1
   Mem[16] = {6'd0,5'd2,5'd0,5'd5,5'd0,6'd42};
   //			slt	$5, $2, $0	# $5 = 1
   Mem[17] = {6'd0,5'd1,5'd5,5'd6,5'd0,6'd32};     
   //			add	$6, $1, $5      # $6 = 2
   Mem[18] = {6'd0,5'd5,5'd6,5'd7,5'd0,6'd37};
   //			or	$7, $5, $6	# $7 = 3
   Mem[19] = {6'd0,5'd5,5'd7,5'd8,5'd0,6'd34};
   //			sub	$8, $5, $7	# $8 = -2
   Mem[20] = {6'd0,5'd8,5'd7,5'd9,5'd0,6'd36};
   //			and	$9, $8, $7	# $9 = 2
   Mem[21] = {6'd43,5'd0,5'd9,16'd32};
   //			sw	$9, 32($0)	# store $9 in DMem[8]
   Mem[22] = {6'd0,5'd0,5'd0,16'd0};
   //			nop			#
   //
   // Test Program 3 (Same as imeminit_simple_test.v)
   //
   Mem[23] = {32'h200a0001};
   //			addi   $10, $0, 1
   Mem[24] = {32'h200b0002};
   //			addi   $11, $0, 2
   Mem[25] = {32'h014b6022};
   //			sub    $12, $10, $11    # $12 = ffffffff
   Mem[26] = {32'h014c6823};
   //			subu   $13, $10, $12    # $13 = 2
   Mem[27] = {32'h014c7020};
   //			add    $14, $10, $12    # $14 = 0
   Mem[28] = {32'h014c7821};
   //			addu   $15, $10, $12    # $15 = 0
   Mem[29] = {32'h2550ffff};
   //			addiu  $16, $10, -1     # $16 = 0
   Mem[30] = {6'd0,5'd0,5'd0,16'd0};
   //			nop			#
end