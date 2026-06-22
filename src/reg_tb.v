module regfile_tb;
    reg clk, we;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] wd;
    wire [31:0] rd1, rd2;

    regfile uut(.clk(clk), .we(we),
                .rs1(rs1), .rs2(rs2),
                .rd(rd), .wd(wd),
                .rd1(rd1), .rd2(rd2));

    // clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== RegFile Testbench ===");

        // write 42 to x1
        we=1; rd=5'd1; wd=32'd42; rs1=5'd1; rs2=5'd0; #10;
        $display("x1 = %0d (expect 42)", rd1);

        // write 100 to x2
        rd=5'd2; wd=32'd100; rs1=5'd2; #10;
        $display("x2 = %0d (expect 100)", rd1);

        // read both x1 and x2 simultaneously
        rs1=5'd1; rs2=5'd2; we=0; #10;
        $display("x1=%0d, x2=%0d (expect 42, 100)", rd1, rd2);

        // try writing to x0 — should stay 0
        we=1; rd=5'd0; wd=32'd999; rs1=5'd0; #10;
        $display("x0 = %0d (expect 0)", rd1);

        $display("=== Done ===");
        $finish;
    end
endmodule