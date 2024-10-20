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


PC m_PC(
    .clk(),
    .rst(start),
    .pc_i(),
    .pc_o()
);

Adder m_Adder_1(
    .a(),
    .b(),
    .sum()
);

InstructionMemory m_InstMem(
    .readAddr(),
    .inst()
);

Control m_Control(
    .opcode(),
    .branch(),
    .memRead(),
    .memtoReg(),
    .ALUOp(),
    .memWrite(),
    .ALUSrc(),
    .regWrite()
);


Register m_Register(
    .clk(),
    .rst(start),
    .regWrite(),
    .readReg1(),
    .readReg2(),
    .writeReg(),
    .writeData(),
    .readData1(),
    .readData2()
);


ImmGen #(.Width(32)) m_ImmGen(
    .inst(),
    .imm()
);

ShiftLeftOne m_ShiftLeftOne(
    .i(),
    .o()
);

Adder m_Adder_2(
    .a(),
    .b(),
    .sum()
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(),
    .s0(),
    .s1(),
    .out()
);

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(),
    .s0(),
    .s1(),
    .out()
);

ALUCtrl m_ALUCtrl(
    .ALUOp(),
    .funct7(),
    .funct3(),
    .ALUCtl()
);

ALU m_ALU(
    .ALUctl(),
    .A(),
    .B(),
    .ALUOut(),
    .zero()
);

DataMemory m_DataMemory(
    .rst(start),
    .clk(),
    .memWrite(),
    .memRead(),
    .address(),
    .writeData(),
    .readData()
);

Mux2to1 #(.size(32)) m_Mux_WriteData(
    .sel(),
    .s0(),
    .s1(),
    .out()
);
    
endmodule
