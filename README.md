# Digital-MAC-unit
This repository contains conventional Digital MAC units, implemented in VHDL. Each folder contais all the files needed to implement the MAC units ( adders, multipliers, registers).
All circuits are generic, meaning that they can be simulated for any number of bits.

# MAC unit: Array Multiplier + Ripple Carry Adder

## Implementation
The first MAC unit consists of an array multiplier and a ripple carry adder (RCA), which are one of the most simple designs for those circuits. This MAC unit consumes less power and area, however, due to its simplicity, it performs poorly and cannot multiply negative numbers. Both sub-circuits can be designed by using half-adders and full-adders and some AND gates, for partial product generation.

The **components** used in this project, which can be found in the folders, are:
* Half Adder;
* Full Adder;
* Ripple Carry Adder (Generic implementation);
* Array Multiplier (Generic implementation); 
* Register (Generic implementation);

## Simulation
An RTL view of the circuit, considering a 4-bit MAC unit (4 bits inputs, 8 bits adder/register) is shown below

![picture](https://i.imgur.com/UB2niSU.png)

The MAC unit simulation can also be seen below. It was carried out in Intel Quartus + ModelSim:

![picture](https://i.imgur.com/1uPsOxD.png)

# MAC unit: Booth Multiplier + Carry lookahead adder
## Implementation
The second MAC unit designed is a bit more complex and optimized in terms of performance, containing a Booth multiplier and a carry lookahead adder (CLA). However, to have better performance it tends to consume more power and area. Another advantage of this implementation is that it can multiply and add both negative and positive numbers.

The **components** used in this project, which can be found in the folders, are:
* Full Adder;
* Carry Lookahead Adder (Generic implementation);
* Booth Multiplier (Generic implementation); 
* Register (Generic implementation);

## Simulation
An RTL view of the circuit, considering a 2-bit MAC unit (2 bits inputs, 4 bits adder/register) is shown below

![picture](https://i.imgur.com/HwX1Hpu.png)

The MAC unit simulation can also be seen below. It was carried out in Intel Quartus + ModelSim considering a 4 bit MAC unit:

![picture](https://i.imgur.com/3NWhsjF.png)
