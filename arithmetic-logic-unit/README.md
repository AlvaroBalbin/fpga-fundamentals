# Arithmetic Logic Unit (ALU)

This project implements an **Arithmetic Logic Unit (ALU)** in SystemVerilog as part of a university lab project.  
The ALU executes arithmetic and logic operations defined for the HighRisc processor and supports FPGA testing on the DE1-SoC board.

---

## Contributors

- **Liam Hamp**  
- **Alvaro Balbin**

We implemented and verified the logic in `ArithmeticLogicUnit.sv`.  
All other files were provided as part of the lab environment.


## Files

| File | Description |
|------|--------------|
| `ArithmeticLogicUnit.sv` | Main ALU implementation (developed by us) |
| `InstructionSet.sv` | Defines ISA opcodes, flags, and parameters |
| `AluTb.sv` | Testbench for simulation in Questa |
| `AluFpgaTop.sv` | FPGA top-level module for DE1-SoC |
| `README.md` | Project documentation |

## Demo Video

[![ALU Demonstration](https://img.youtube.com/vi/pAdxFBZjDvc/maxresdefault.jpg)](https://youtu.be/pAdxFBZjDvc)
