f = open("id.csv")  
fout = open("id_code.v",'w')
line = f.readline() 
line = f.readline()  
while line:  
	signals=line.split(',')
	fout.write("`OP_"+signals[0]+':begin\n')
	fout.write('	`ifdef DEBUG_MODE\n')
	fout.write('	$display("ins: ' + signals[0] +'");\n')
	fout.write('	`endif\n')
	
	if signals[3]!="":
		fout.write("	immNumber_o = Imm_"+signals[3]+";\n")
	if signals[4]!="":
		fout.write("	ALUdata2Src_o = `"+signals[4]+";\n")
	fout.write("	ALUoperation_o = `"+signals[5]+";\n")
	if signals[6]!="":
		fout.write("	ALUToReg_o = 1'b"+signals[6]+";\n")
	if signals[8]!="":
		fout.write("	MemToReg_o = 1'b"+signals[8]+";\n")
	if signals[9]!="":
		fout.write("	memOp_o = `"+signals[9]+";\n")
	if signals[10]!="":
		fout.write("	RegWrite_o = 1'b"+signals[10]+";\n")
	if signals[11]!="":
		if signals[11] == 'r31':
			fout.write("	WriteRegDst_o = 5'd31;\n")
		else:
			fout.write("	WriteRegDst_o = "+signals[11]+";\n")
	if signals[12]!="":
		fout.write("	isJump_o = 1'b" + signals[12] + ";\n")
	if signals[13]!="":
		if signals[13][0]=="B":
			sign = signals[13][1:].strip()
			fout.write("	jumpAddr_o = pcPlusOne_i + (regData1_o"+sign+"regData2_o?Imm_16S:32'd1);\n")
		elif signals[13].strip()=="J":
			fout.write("	jumpAddr_o = Imm_26U;\n")
		elif signals[13].strip()=="JR":
			fout.write("	jumpAddr_o = regData1_o;\n")
		
	fout.write("end\n");
	print line
	line = f.readline()  
f.close()  