 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Array multiplier + ripple carry adder
  -- URL of the project:
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: FA_Block (Array multiplier full-adder)
  ----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FA_Block is
    Port ( Ai : in STD_LOGIC; --Input 1
           Xi : in STD_LOGIC; --Input 1
           Ai_1 : in STD_LOGIC; -- Intermediate signal
           Ci_in : in STD_LOGIC; --Carry in
           COut : out STD_LOGIC; --Carry out
           POut : out STD_LOGIC); --Result
end FA_Block;

-- Full adder made of just logic gates
architecture Behavioral of FA_Block is
Signal Bi:STD_LOGIC;
begin
Bi<=Ai AND Xi; --multiply two single bits
POut<=Ai_1 xor Ci_in xor Bi;
COut<=(Ai_1 and Bi) or (Ai_1 and Ci_in) or (Bi and Ci_in);
end Behavioral;