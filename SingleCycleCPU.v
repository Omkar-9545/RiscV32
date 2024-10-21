`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:47:12 PM
// Design Name: 
// Module Name: SingleCycleCPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SingleCycleCPU(
    input clk,
    input start
);

// When input start is zero, cpu should reset
// When input start is high, cpu start running

// TODO: connect wire to realize SingleCycleCPU
// The following provides simple template,
parameter width=32; 
wire addVal=32'h04;

wire [width-1:0] PC_in,PC_out,addOut,immAddress,rd1,rd2;
wire [width-1:0] shiftOut,immOut,inst,Operand2,ALUOut,mem_read_data,reg_write_data;
wire branch,memRead,memtoReg,memWrite,ALUSrc,regWrite,zero,funct7;
wire [1:0] ALUOp;
wire [6:0] opcode;
wire [3:0] ALUCtl;
wire [2:0] funct3;
wire [4:0] readReg1,readReg2,writeReg;

PC m_PC(
    .clk(clk),
    .rst(start),
    .pc_i(PC_in),
    .pc_o(PC_out)
);

Adder m_Adder_1(
    .a(PC_out),
    .b(addVal),
    .sum(addOut)
);

InstructionMemory m_InstMem(
    .readAddr(PC_out),
    .inst(inst)
);

assign opcode = inst[6:0];

Control m_Control(
    .opcode(opcode),
    .branch(branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp(ALUOp),
    .memWrite(memWrite),
    .ALUSrc(ALUSrc),
    .regWrite(regWrite)
);

assign readReg1 = inst[19:15];
assign readReg2 = inst[24:20];
assign writeReg = inst[11:7];

Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(regWrite),
    .readReg1(readReg1),
    .readReg2(readReg2),
    .writeReg(writeReg),
    .writeData(reg_write_data),
    .readData1(rd1),
    .readData2(rd2)
);


ImmGen #(.Width(32)) m_ImmGen(
    .inst(inst),
    .imm(immOut)
);

ShiftLeftOne m_ShiftLeftOne(
    .i(immOut),
    .o(shiftOut)
);

Adder m_Adder_2(
    .a(PC_out),
    .b(shiftOut),
    .sum(immAddress)
);

assign PC_Mux_Sel = branch & zero;

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(PC_Mux_Sel),
    .s0(addOut),
    .s1(immAddress),
    .out(PC_in)
);

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(ALUSrc),
    .s0(rd2),
    .s1(immOut),
    .out(Operand2)
);

assign funct7 = inst[30];
assign funct3 = inst[14:12];

ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(funct7),
    .funct3(funct3),
    .ALUCtl(ALUCtl)
);

ALU m_ALU(
    .ALUCtl(ALUCtl),
    .A(rd1),
    .B(Operand2),
    .ALUOut(ALUOut),
    .zero(zero)
);

DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(ALUOut),
    .writeData(rd2),
    .readData(mem_read_data)
);

Mux2to1 #(.size(32)) m_Mux_WriteData(
    .sel(memtoReg),
    .s0(ALUOut),
    .s1(mem_read_data),
    .out(reg_write_data)
);
    
endmodule
