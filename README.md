📘 RISC-V 5-Stage Pipelined CPU
Verilog • SystemVerilog • Yosys • Icarus • EDA Playground Compatible

A clean and educational implementation of a 5-stage pipelined RISC-V RV32I CPU, built using SystemVerilog and verified using a custom testbench.

This CPU includes pipeline registers, forwarding, hazard detection, branching, load/store, ALU, and a simple instruction/data memory model.

A Yosys-generated CPU datapath diagram and the full EDA Playground output (result.zip) are also provided.
## 🔗 Run Online on EDA Playground

You can run and simulate this CPU directly in **EDA Playground**:

[Run this design on EDA Playground](https://www.edaplayground.com/x/bg_J)



🚀 Features
✔️ Fully pipelined 5-stage architecture
IF → ID → EX → MEM → WB

✔️ Hazard support

RAW hazard detection

EX/MEM & MEM/WB forwarding

Pipeline stalling

IF/ID flushing

✔️ Instruction support

addi, add, sub, logical ops

lw, sw

beq

jal

32 general-purpose registers

Immediate sign-extension unit

✔️ Testing + Visualization

Full testbench

Instruction encoders

Yosys synthesis using run.ys

SVG diagram (cpu_pipeline.svg)

Full build output (result.zip)

📂 Repository Structure
riscv-pipeline-cpu/
│
├── design.sv          # Full CPU implementation (5-stage pipeline)
├── testbench.sv       # Testbench with instruction encoder tasks
├── run.ys             # Yosys script (generate svg schematic)
├── cpu_pipeline.svg   # Pre-generated Yosys diagram
├── result.zip         # Full EDA Playground “Make files downloadable” output
└── README.md          # Documentation

🔧 Running Locally
1️⃣ Install dependencies
sudo apt install iverilog yosys

2️⃣ Compile & run simulation
iverilog -g2012 design.sv testbench.sv -o cpu.out
vvp cpu.out

3️⃣ Generate synthesis + schematic
yosys run.ys


Output generated:

cpu_pipeline.svg

🎮 Running on EDA Playground

1️⃣ Go to EDAPlayground.com
2️⃣ Choose:

Simulator: Icarus Verilog

Tools: ✔ Enable Yosys

3️⃣ Create/upload these files:

design.sv

testbench.sv

run.ys

4️⃣ Check the boxes:

✔ Use run.ys

✔ Output file name: cpu_pipeline.svg

✔ Show diagram after run

✔ Make files downloadable

5️⃣ Click Run
The SVG diagram appears below the output.

🧪 Test Program Included

The testbench automatically encodes & runs the following instructions:

addi x1, x0, 5
addi x2, x0, 3
add  x3, x1, x2

sw   x3, 0(x0)
lw   x4, 0(x0)

beq  x4, x3, +8   # branch taken

addi x5, x0, 1   # skipped
addi x6, x0, 7

jal  x7, 8

add  x10, x6, x1


Results (register/memory) are printed at end of simulation.

🖼 CPU Diagram

A high-quality Yosys schematic of the CPU datapath is included:

cpu_pipeline.svg

You can view it directly on GitHub.

📦 Pre-generated Output

A complete EDA Playground build is also included:

👉 result.zip
Contains:

SVG diagram

Cache directory

Yosys logs

Execution shell script

Useful for reproducing the workflow.

🤝 Contributing

This project is designed for learning.
Feel free to open Issues or Pull Requests if you want to:

Add more RISC-V instructions

Improve hazard logic

Add CSR support

Create a better diagram

Add waveform examples

⭐ Acknowledgments

Thanks to open-source tools:
Yosys, Icarus Verilog, EDA Playground, RISC-V community.
