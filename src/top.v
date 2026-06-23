module top (
    input clk,
    input rst
);

// ─── Wires ───────────────────────────────
wire [31:0] pc_out, pc_next;
wire [31:0] instr;
wire [31:0] rd1, rd2;
wire [31:0] imm;
wire [31:0] alu_b;
wire [31:0] alu_result;
wire [31:0] dmem_rd;
wire [31:0] wb_data;
wire        zero;

// Control signals
wire        reg_write, alu_src;
wire        mem_write, mem_read, mem_to_reg;
wire        branch;
wire [1:0]  alu_op;
wire [3:0]  alu_ctrl;

// ─── PC Next Logic ───────────────────────
assign pc_next =
    (branch && zero) ?
    (pc_out + (imm << 1)) :
    (pc_out + 32'd4);

// ─── Program Counter ─────────────────────
pc u_pc (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc_out(pc_out)
);

// ─── Instruction Memory ──────────────────
imem u_imem (
    .addr(pc_out),
    .instr(instr)
);

// ─── Control Unit ────────────────────────
control u_ctrl (
    .opcode(instr[6:0]),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .branch(branch),
    .alu_op(alu_op)
);

// ─── Register File ───────────────────────
regfile u_rf (
    .clk(clk),
    .we(reg_write),
    .rs1(instr[19:15]),
    .rs2(instr[24:20]),
    .rd(instr[11:7]),
    .wd(wb_data),
    .rd1(rd1),
    .rd2(rd2)
);

// ─── Immediate Generator ─────────────────
imm_gen u_immgen (
    .instr(instr),
    .imm(imm)
);

// ─── ALU Input Mux ───────────────────────
assign alu_b = alu_src ? imm : rd2;

// ─── Temporary ALU Control ───────────────
assign alu_ctrl =
    (alu_op == 2'b01) ? 4'b0001 :   // SUB for BEQ
                        4'b0000;    // ADD for others

// ─── ALU ─────────────────────────────────
alu u_alu (
    .a(rd1),
    .b(alu_b),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
);

// ─── Data Memory ─────────────────────────
dmem u_dmem (
    .clk(clk),
    .we(mem_write),
    .addr(alu_result),
    .wd(rd2),
    .rd(dmem_rd)
);

// ─── Write Back Mux ──────────────────────
assign wb_data =
    mem_to_reg ? dmem_rd :
                 alu_result;

endmodule