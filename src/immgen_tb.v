`timescale 1ns/1ps

module tb_imm_gen;

reg  [31:0] instr;
wire [31:0] imm;

imm_gen uut (
    .instr(instr),
    .imm(imm)
);

initial begin

    $dumpfile("imm_gen.vcd");
    $dumpvars(0, tb_imm_gen);

    // I-Type : ADDI x1,x0,10
    instr = 32'h00A00093;
    #10;
    $display("I-Type Imm = %0d", imm);

    // S-Type : SW offset = 16
    instr = 32'h00512823;
    #10;
    $display("S-Type Imm = %0d", imm);

    // B-Type : Example branch
    instr = 32'h00208863;
    #10;
    $display("B-Type Imm = %0d", imm);

    // U-Type : LUI
    instr = 32'h123450B7;
    #10;
    $display("U-Type Imm = %h", imm);

    // J-Type : JAL
    instr = 32'h008000EF;
    #10;
    $display("J-Type Imm = %0d", imm);

    $finish;

end

endmodule