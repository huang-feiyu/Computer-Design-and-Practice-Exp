`timescale 1ns / 1ps

module alu(
    input      [31:0] rd1_i   ,
    input      [31:0] rd2_i   ,
    input      [31:0] pc_i    ,
    input      [31:0] ext_i   ,
    input             aSel_i  ,
    input             bSel_i  ,
    input      [3 :0] aluSel_i,

    output reg [31:0] aluC_o
);

wire [31:0] a = (aSel_i == param.ASEL_R) ? rd1_i : pc_i ;
wire [31:0] b = (bSel_i == param.BSEL_R) ? rd2_i : ext_i;

always @(*) begin
    case (aluSel_i)
        param.ALUSEL_ADD: aluC_o = a + b ;
        param.ALUSEL_SUB: aluC_o = a - b ;
        param.ALUSEL_AND: aluC_o = a & b ;
        param.ALUSEL_OR : aluC_o = a | b ;
        param.ALUSEL_XOR: aluC_o = a ^ b ;
        param.ALUSEL_SLL: aluC_o = a << b; // NOTE: naive shift-op might be wrong
        param.ALUSEL_SRL: aluC_o = a >> b;
        param.ALUSEL_SRA: aluC_o = $signed(a) >>> b;
        param.ALUSEL_LUI: aluC_o = b; // rd <- {imm[31:12], 12'b0}
        default:          aluC_o = aluC_o;
    endcase
end


endmodule