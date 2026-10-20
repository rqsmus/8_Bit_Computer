# Source Files

This document gives a short overview of the VHDL files and how they fit together.

## Main Files

- `eight_bit_pc.vhd` — The top-level module that connects the CPU components together.
- `control_unit.vhd` — Controls the fetch and execution steps for each instruction.
- `PC.vhd` — The program counter, which keeps track of the next instruction address.
- `ROM.vhd` — Stores the program instructions.
- `ram.vhd` — Stores data that the program can read and write.
- `alu.vhd` — Performs arithmetic, logic, and shift operations.
- `8bit_adder.vhd` — An 8-bit adder used for arithmetic operations.
- `adder.vhd` — The adder component used to build the 8-bit adder.

## Registers and Logic Components

- `bit8_register_inferred.vhd` — An 8-bit register described using clocked VHDL, allowing the synthesis tool to infer FPGA flip-flops.
- `8bit_register.vhd` — An 8-bit register built from smaller register components.
- `1bit_registar.vhd` — A 1-bit register built using the project's structural logic components.
- `DFlipFlop.vhd` — A D flip-flop built using two latches.
- `DLatch.vhd` — A latch built from basic logic gates.
- `MUX.vhd` — A multiplexer used to select between input signals.
- `and_gate.vhd` — AND gate.
- `nand_gate.vhd` — NAND gate.
- `nor_gate.vhd` — NOR gate.
- `or_gate.vhd` — OR gate.
- `xor_gate.vhd` — XOR gate.

## Simulation

- `eight_bit_pc_tb.vhd` — The testbench used to simulate the computer and inspect its behaviour in waveforms.

The project contains both structural and inferred register implementations. The structural versions were useful for learning how registers can be built from basic logic components, while the inferred version was used to investigate how synthesis tools map VHDL into FPGA resources.
