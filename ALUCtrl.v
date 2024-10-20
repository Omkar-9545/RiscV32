`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:53:28 PM
// Design Name: 
// Module Name: ALUCtrl
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


module ALUCtrl(
    input [1:0] ALUOp,
    input funct7,
    input [2:0] funct3,
    output reg [3:0] ALUCtl
);

    // TODO: implement your ALU ALUCtl here
   // Hint: using ALUOp, funct7, funct3 to select exact operation
    always @(*)
begin
case (ALUOp)
2'b00 : ALUCtl <= 4'b0010;
2'b01 : ALUCtl <= 4'b0110;
2'b10 : case({funct7,funct3})
4'b0000 : ALUCtl <= 4'b0010; // add
4'b1000 : ALUCtl <= 4'b0110; // sub
4'b0111 : ALUCtl <= 4'b0000; // and
4'b0110 : ALUCtl <= 4'b0001; // or
4'b0001 : ALUCtl <= 4'b0011; // sll
4'b0010 : ALUCtl <= 4'b0100; // slt
4'b0011 : ALUCtl <= 4'b0101; // sltu
4'b0100 : ALUCtl <= 4'b0111; // xor
4'b0101 : ALUCtl <= 4'b1000; // srl
4'b1101 : ALUCtl <= 4'b1010; // sra
default : ALUCtl <= 4'bxxxx;
endcase
2'b11 : case({funct7,funct3})
4'b0000 : ALUCtl <= 4'b0010; // addi
4'b0010 : ALUCtl <= 4'b0100; // slti
4'b0011 : ALUCtl <= 4'b0101; // sltui
4'b0100 : ALUCtl <= 4'b0111; // xori
4'b0110 : ALUCtl <= 4'b0001; // ori
4'b0111 : ALUCtl <= 4'b0000; // andi
4'b0001 : ALUCtl <= 4'b0011; // slli
4'b0101 : ALUCtl <= 4'b1000; // srli
4'b1101 : ALUCtl <= 4'b1010; // srai
default : ALUCtl <= 4'bxxxx;
endcase
endcase
end

endmodule
