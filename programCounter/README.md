## Program Counter

The Program Counter (PC) is a 16-bit register that holds the address of the next instruction in a processor. On each clock cycle, it increments by 1 unless another operation is enabled.  

- **Clock:** All operations occur on the rising edge.  
- **Reset:** Sets the counter value to 0.  
- **LoadEnable + LoadValue:** Loads a specific value into the counter.  
- **OffsetEnable + Offset:** Adds or subtracts a signed offset to the counter value.  
- **CounterValue:** 16-bit signed output showing the current program counter value.  

When none of the control signals are active, the PC simply increments sequentially.  
Demonstration of the Program Counter:  

[![Program Counter](https://img.youtube.com/vi/hbINJOWStqY/0.jpg)](https://youtube.com/shorts/hbINJOWStqY?feature=share)