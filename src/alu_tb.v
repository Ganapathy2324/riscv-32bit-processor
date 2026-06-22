module tb_alu;
    reg  [31:0] a, b;
    reg  [ 3:0] alu_ctrl;
    wire [31:0] result;
    wire zero;

    // instantiate your ALU
    alu uut (
        .a(a), .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("=== ALU Testbench ===");

        // ADD
        a = 32'd10; b = 32'd5; alu_ctrl = 4'b0000; #10;
        $display("ADD: %0d + %0d = %0d (expect 15)", a, b, result);

        // SUB
        a = 32'd10; b = 32'd5; alu_ctrl = 4'b0001; #10;
        $display("SUB: %0d - %0d = %0d (expect 5)", a, b, result);

        // AND
        a = 32'hFF; b = 32'h0F; alu_ctrl = 4'b0010; #10;
        $display("AND: %0h & %0h = %0h (expect f)", a, b, result);

        // OR
        a = 32'hF0; b = 32'h0F; alu_ctrl = 4'b0011; #10;
        $display("OR:  %0h | %0h = %0h (expect ff)", a, b, result);

        // XOR
        a = 32'hFF; b = 32'hFF; alu_ctrl = 4'b0100; #10;
        $display("XOR: %0h ^ %0h = %0h (expect 0)", a, b, result);

        // SLT
        a = 32'd3; b = 32'd7; alu_ctrl = 4'b0101; #10;
        $display("SLT: %0d < %0d = %0d (expect 1)", a, b, result);

        // SLL
        a = 32'd1; b = 32'd4; alu_ctrl = 4'b0110; #10;
        $display("SLL: %0d << 4 = %0d (expect 16)", a, b, result);

        // SRL
        a = 32'd16; b = 32'd2; alu_ctrl = 4'b0111; #10;
        $display("SRL: %0d >> 2 = %0d (expect 4)", a, b, result);

        // SRA
        a = -32'd8; b = 32'd2; alu_ctrl = 4'b1000; #10;
        $display("SRA: -8 >>> 2 = %0d (expect -2)", $signed(result));

        // ZERO flag
        a = 32'd5; b = 32'd5; alu_ctrl = 4'b0001; #10;
        $display("ZERO flag: 5-5=0, zero=%0d (expect 1)", zero);

        $display("=== Done ===");
        $finish;
    end
endmodule