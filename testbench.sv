// Code your testbench here
// or browse Examples
// testbench.sv
`timescale 1ns/1ps
module tb;
    reg clk = 0;
    reg reset = 1;

    wire [31:0] dbg_pc;
    cpu uut (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc)
    );

    always #5 clk = ~clk; // 100MHz-ish simulated

    // instruction encoders (simple helpers)
    function [31:0] enc_addi(input [4:0] rd, input [4:0] rs1, input [11:0] imm12);
        enc_addi = {imm12, rs1, 3'b000, rd, 7'b0010011};
    endfunction

    function [31:0] enc_add(input [4:0] rd, input [4:0] rs1, input [4:0] rs2);
        enc_add = {7'b0000000, rs2, rs1, 3'b000, rd, 7'b0110011};
    endfunction

    function [31:0] enc_sw(input [4:0] rs1, input [4:0] rs2, input [11:0] imm12);
        enc_sw = {imm12[11:5], rs2, rs1, 3'b010, imm12[4:0], 7'b0100011};
    endfunction

    function [31:0] enc_lw(input [4:0] rd, input [4:0] rs1, input [11:0] imm12);
        enc_lw = {imm12, rs1, 3'b010, rd, 7'b0000011};
    endfunction

    function [31:0] enc_beq(input [4:0] rs1, input [4:0] rs2, input [12:0] imm13);
        enc_beq = {imm13[12], imm13[10:5], rs2, rs1, 3'b000, imm13[4:1], imm13[11], 7'b1100011};
    endfunction

    function [31:0] enc_jal(input [4:0] rd, input [19:0] imm20);
        enc_jal = {imm20[19], imm20[9:0], imm20[10], imm20[18:11], rd, 7'b1101111};
    endfunction

    initial begin
        integer i;
        // clear regs and dmem
        for (i = 0; i < 32; i = i + 1) uut.regs[i] = 32'd0;
        for (i = 0; i < 1024; i = i + 1) uut.dmem[i] = 8'd0;
        // load program into imem
        uut.imem[0]  = enc_addi(5'd1, 5'd0, 12'd5);
        uut.imem[1]  = enc_addi(5'd2, 5'd0, 12'd3);
        uut.imem[2]  = enc_add(5'd3, 5'd1, 5'd2);
        uut.imem[3]  = enc_sw(5'd0, 5'd3, 12'd0);
        uut.imem[4]  = enc_lw(5'd4, 5'd0, 12'd0);
        uut.imem[5]  = enc_beq(5'd4,5'd3,13'd8); // branch forward 8 -> to word at addr 28
        uut.imem[6]  = enc_addi(5'd5, 5'd0, 12'd1);
        uut.imem[7]  = enc_addi(5'd6, 5'd0, 12'd7);
        uut.imem[8]  = enc_jal(5'd7, 20'd8);
        uut.imem[9]  = enc_addi(5'd8, 5'd0, 12'd9);
        uut.imem[10] = enc_addi(5'd9, 5'd0, 12'd10);
        uut.imem[11] = enc_add(5'd10,5'd6,5'd1);
        for (i = 12; i < 256; i = i + 1) uut.imem[i] = 32'h00000013; // NOP

        // release reset
        #12;
        reset = 0;

        // optional VCD dump for GTKWave
        $dumpfile("trace.vcd");
        $dumpvars(0, tb);

        // run a little while
        #2000;

        // display regs and memory
        $display("Registers after run:");
        for (i = 0; i < 12; i = i + 1) $display("x%0d = %0d", i, uut.regs[i]);

        $display("Dmem[0..3] (bytes): %0d %0d %0d %0d", uut.dmem[0], uut.dmem[1], uut.dmem[2], uut.dmem[3]);

        $finish;
    end
endmodule
