module imem (
    input  [31:0] addr,
    output [31:0] instr
);

reg [31:0] mem [0:255]; // 256 words = 1KB

initial begin
    $readmemh("src/prog.hex", mem);
end

assign instr = mem[addr[9:2]]; // word-aligned

endmodule