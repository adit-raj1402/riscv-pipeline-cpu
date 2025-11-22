📘 RISC-V 5-Stage Pipelined CPU
Verilog | Yosys | Icarus Verilog | EDA Playground Compatible

This repository contains a clean and educational implementation of a 5-stage pipelined RISC-V RV32I CPU, written in SystemVerilog and tested using a hand-written testbench.
It includes pipeline registers, forwarding, hazard detection, branching, load/store, ALU operations, and a small memory model.

A pre-generated Yosys SVG diagram and the result.zip from EDA Playground are included.

🧩 Features

✔ Fully pipelined 5-stage architecture

IF → ID → EX → MEM → WB

✔ RAW hazard detection

✔ Forwarding unit (EX/MEM & MEM/WB)

✔ ALU (add, sub, logic, compare)

✔ Loads and stores (lw, sw)

✔ Branch: BEQ

✔ Jump: JAL

✔ 32 general-purpose registers

✔ Instruction + data memories

✔ Testbench with instruction encoders

✔ Yosys synthesis + SVG diagram generation

✔ Compatible with EDA Playground, Icarus Verilog, Yosys

📁 Repository Structure
riscv-pipeline-cpu/
│
├── design.sv          # CPU implementation (5-stage pipeline)
├── testbench.sv       # Testbench with instruction encoders
├── run.ys             # Yosys script for synthesis + SVG schematic
│
├── result/            # Auto-generated files from EDA Playground
│   ├── cpu_pipeline.svg
│   ├── .cache/
│   ├── run.sh
│   ├── (other system files)
│
├── result.zip         # Full downloadable build output
│
└── README.md          # This file

🔧 How to Run (Locally)
1. Install tools
sudo apt install iverilog yosys

2. Run simulation
iverilog -g2012 design.sv testbench.sv -o cpu.out
vvp cpu.out

3. Generate CPU diagram using Yosys
yosys run.ys


This creates:

cpu_pipeline.svg

🎮 How to Use on EDA Playground

Go to EDAPlayground.com

Select:

Simulator: Icarus Verilog

Tools: Enable Yosys

Upload/paste:

design.sv

testbench.sv

Create a new file run.ys and paste the Yosys script

Check:

✔ “Use run.ys”

✔ Output file name: cpu_pipeline.svg

✔ “Show schema after run”

✔ “Make files downloadable”

Run

The SVG diagram will appear below the output.

🧪 Included Test Program

The testbench automatically encodes these instructions:

addi x1, x0, 5

addi x2, x0, 3

add x3, x1, x2

sw x3, 0(x0)

lw x4, 0(x0)

beq x4, x3, +8 (branch taken)

addi x5, x0, 1 (skipped)

addi x6, x0, 7

jal x7, 8

add x10, x6, x1

It prints register values and memory at the end.

🖼 CPU Diagram (Yosys Generated)

The generated SVG schematic of the CPU datapath is included here:

result/cpu_pipeline.svg


You can view it directly on GitHub after uploading.

📦 Download Pre-Generated Output

Full build output from EDA Playground (uploaded by you):

👉 result.zip

This contains the generated SVG, cache files, and shell scripts.
