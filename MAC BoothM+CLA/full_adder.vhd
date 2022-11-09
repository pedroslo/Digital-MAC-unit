 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Booth multiplier + carry lookahead adder
  -- URL of the project:
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: full_adder (full-adder used in CLA)
  ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity full_adder is
  port (
    i_bit1  : in std_logic; --Input 1
    i_bit2  : in std_logic; --Input 2
    i_carry : in std_logic; --Carry in
    --
    o_sum   : out std_logic; --Result
    o_carry : out std_logic  --Carry out
    );
end full_adder;
 
 
architecture rtl of full_adder is
 
  signal w_WIRE_1 : std_logic;
  signal w_WIRE_2 : std_logic;
  signal w_WIRE_3 : std_logic;
   
begin
 
  w_WIRE_1 <= i_bit1 xor i_bit2;
  w_WIRE_2 <= w_WIRE_1 and i_carry;
  w_WIRE_3 <= i_bit1 and i_bit2;
 
  o_sum   <= w_WIRE_1 xor i_carry;
  o_carry <= w_WIRE_2 or w_WIRE_3;
 
 
end rtl;