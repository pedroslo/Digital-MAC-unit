# Digital-MAC-unit
This repository contains conventional Digital MAC units, implemented in VHDL. Each folder contais all the files needed to implement the MAC units ( adders, multipliers, registers).
All circuits are generic, meaning that they can be simulated for any number of bits.

# MAC unit: Array Multiplier + Ripple Carry Adder
The first MAC unit consists of an array multiplier and a ripple carry adder (RCA), which are one of the most simple designs for those circuits. This MAC unit consumes less power and area, however, due to its simplicity, it performs poorly and cannot multiply negative numbers. Both sub-circuits can be designed by using half-adders and full-adders and some AND gates, for partial product generation.

An RTL view of the circuit, considering a 4-bit MAC unit is shown below


# MAC unit: Booth Multiplier + Carry lookahead adder

The second MAC unit designed is a bit more complex and optimized in terms of performance, containing a Booth multiplier and a carry lookahead adder (CLA)
