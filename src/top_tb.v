`timescale 1ns/1ps
module tb_top;

reg clk, rst;
top uut (.clk(clk), .rst(rst));

initial clk = 0;
always #5 clk = ~clk;

always @(posedge clk) begin
    $display("CLK PC=%0d instr=%h rd=%0d wd=%0d we=%0d | x1=%0d x2=%0d x3=%0d x4=%0d",
        uut.pc_out,
        uut.instr,
        uut.u_rf.rd,
        uut.u_rf.wd,
        uut.u_rf.we,
        uut.u_rf.regs[1],
        uut.u_rf.regs[2],
        uut.u_rf.regs[3],
        uut.u_rf.regs[4]);
end

initial begin
    rst = 1; #10;
    rst = 0;
    #80;
    $finish;
end

endmodule