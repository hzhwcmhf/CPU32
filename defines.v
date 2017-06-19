`define DEBUG_MODE

//****** Global Definitions ******
`define Enable 				1'b1
`define Disable 			1'b0
`define ZeroWord			32'd0

//****** Instruction Definitions ******
`define INS_NOP				32'd0

`define ALU_NOP_OP			4'd0	        
`define ALU_ADD_OP			4'd1			
`define ALU_SUB_OP			4'd2
`define ALU_DATA2_OP		4'd3
`define ALU_AND_OP			4'd4
`define ALU_OR_OP			4'd5
`define ALU_XOR_OP			4'd6
`define ALU_NOR_OP			4'd7
`define ALU_SLL_OP			4'd8
`define ALU_SRL_OP			4'd9
`define ALU_SRA_OP			4'd10
`define ALU_JAL_OP			4'd11

`define MEM_NOP_OP			3'd0
`define MEM_LOAD_WORD		3'd1
`define MEM_LOAD_HALF		3'd2
`define MEM_LOAD_BYTE		3'd3
`define MEM_SAVE_WORD		3'd4
`define MEM_SAVE_HALF		3'd5
`define MEM_SAVE_BYTE		3'd6


//ALUDara2Src
`define reg2    2'd0
`define imm     2'd1
`define PC    	2'd2

//INS
`define OP_ADD		{6'd0,15'bxxxxxxxxxxxxxxx,11'd0}
`define OP_ADDI		{6'd1,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_SUB		{6'd0,15'bxxxxxxxxxxxxxxx,11'd2}
`define OP_LUI		{6'd3,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_AND		{6'd0,15'bxxxxxxxxxxxxxxx,11'd8}
`define OP_ANDI		{6'd4,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_OR		{6'd0,15'bxxxxxxxxxxxxxxx,11'd9}
`define OP_ORI		{6'd5,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_XOR		{6'd0,15'bxxxxxxxxxxxxxxx,11'd10}
`define OP_XORI		{6'd6,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_NOR		{6'd0,15'bxxxxxxxxxxxxxxx,11'd11}
`define OP_SLL		{6'd0,15'bxxxxxxxxxxxxxxx,5'bxxxxx,6'd16}
`define OP_SRL		{6'd0,15'bxxxxxxxxxxxxxxx,5'bxxxxx,6'd17}
`define OP_SRA		{6'd0,15'bxxxxxxxxxxxxxxx,5'bxxxxx,6'd18}
`define OP_LW		{6'd16,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_LH		{6'd18,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_LB		{6'd20,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_SW		{6'd24,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_SH		{6'd26,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_SB		{6'd28,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_BEQ		{6'd32,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_BNE		{6'd33,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_BLT		{6'd34,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_BLE		{6'd35,10'bxxxxxxxxxx,16'bxxxxxxxxxxxxxxxx}
`define OP_J		{6'd40,26'bxxxxxxxxxxxxxxxxxxxxxxxxxx}
`define OP_JAL		{6'd41,26'bxxxxxxxxxxxxxxxxxxxxxxxxxx}
`define OP_JR		{6'd42,26'bxxxxxxxxxxxxxxxxxxxxxxxxxx}

`define DEFAULT_isJump	         	1'b0
`define DEFAULT_ALUoperation    	`ALU_NOP_OP
`define DEFAULT_ALUdata2Src			`reg2
`define DEFAULT_ALUToReg			1'b0
`define DEFAULT_memOp				`MEM_NOP_OP
`define DEFAULT_MemToReg			1'b0
`define DEFAULT_RegWrite			1'b0
`define DEFAULT_WriteRegDst		4'b0000

//FLOW_CONTROLLER
`define NO_PAUSE_REQUEST 1'd0
`define ID_PAUSE_REQUEST 1'd1

`define NORMAL_OP 2'd0
`define RST_OP 2'd1
`define PAUSE_OP 2'd2
