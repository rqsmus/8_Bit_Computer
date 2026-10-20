# 8-Bit Computer in VHDL

A small 8-bit computer built in VHDL as a personal project to learn more about digital logic, computer architecture, and FPGA synthesis.

## Overview

The computer implements a simple instruction set with a control unit, ALU, program counter, ROM, RAM, registers, flags, and a shared 8-bit data bus. Instructions are fetched and executed over multiple clock cycles.

The ALU supports addition, subtraction, bitwise logic, bitwise NOT, and logical shifts. The instruction set also includes memory access, jumps, conditional branches, input/output, and HALT.

## Design Approach

The project started at the gate level, with basic logic gates used to build components such as a latch, D flip-flop, registers, multiplexers, and an adder. These components were then combined to build the ALU and CPU.

While taking DTU's *02203 Design of Digital Systems* course (elective course chosen and still on going), I gained a better understanding of VHDL and how synthesis tools interpret a hardware description. This led me to compare my original structural register implementation with a behavioural RTL implementation using clocked VHDL processes.

The comparison showed a significant reduction in LUT usage when using inferred registers, while the number of dedicated FPGA flip-flops increased. This was a useful lesson in how describing hardware differently can affect the resulting implementation.

The original structural register implementation is retained in the project as a reference for comparing the two approaches.

## Current Implementation

- **Language:** VHDL
- **Architecture:** 8-bit datapath and instruction set
- **Memory:** 256-byte data RAM and a separate program ROM
- **ALU:** Arithmetic, logic, and shift operations with zero, negative, and carry flags
- **Verification:** Simulation and manual waveform inspection
- **Synthesis:** 174 LUTs and 62 flip-flops in the latest reported synthesis run

The design has been tested in simulation and serves as a baseline for further development. It has not yet been fully optimized, and the reported resource usage depends on the target FPGA and synthesis settings.

## Repository Structure

- `src/` — VHDL source files for the CPU and its components.
- `docs/` — Instruction set definitions and documentation explaining the source files.

For more details about the individual components, see [Source Files](docs/source-files.md).

## Potential Future Work

- Create a Python script to convert assembly instructions into ROM and RAM initialization data.
- Investigate memory inference and the implementation of the shared data bus.
- Explore further synthesis optimizations and compare resource usage.
- Improve automated testing of instruction execution.
