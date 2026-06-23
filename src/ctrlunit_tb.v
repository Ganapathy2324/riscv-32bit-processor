`timescale 1ns/1ps
module tb_control;
reg  [6:0] opcode;
wire reg_write;
wire alu_src;
wire mem_write;
wire mem_read;
wire mem_to_reg;
wire branch;
wire [1:0] alu_op;
control uut (
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .branch(branch),
    .alu_op(alu_op)
);
initial begin
    $dumpfile("control.vcd");
    $dumpvars(0, tb_control);
    // R-Type
    opcode = 7'b0110011;
    #10;
    $display("R-Type -> RegWrite=%b ALUSrc=%b ALUOp=%b",
             reg_write, alu_src, alu_op);
    // ADDI
    opcode = 7'b0010011;
    #10;
    $display("ADDI -> RegWrite=%b ALUSrc=%b ALUOp=%b",
             reg_write, alu_src, alu_op);
    // LW
    opcode = 7'b0000011;
    #10;
    $display("LW -> MemRead=%b MemToReg=%b RegWrite=%b",
             mem_read, mem_to_reg, reg_write);
    // SW
    opcode = 7'b0100011;
    #10;
    $display("SW -> MemWrite=%b",
             mem_write);
    // BEQ
    opcode = 7'b1100011;
    #10;
    $display("BEQ -> Branch=%b ALUOp=%b",
             branch, alu_op);
    $finish;
end
endmodule