 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: booth multiplier + ripple carry adder
  -- URL of the project: https://github.com/pedroslo/Digital-MAC-unit
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: mac
  ----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity mac is
    generic ( size: integer :=4); -- MAC Number of bits
    Port ( A : in STD_LOGIC_VECTOR (size-1 downto 0); --Input 1
           B : in STD_LOGIC_VECTOR (size-1 downto 0); --Input 2
			  CLK : in std_logic; --Clock
			  RST : in std_logic; --Reset/clear accumulator stored value
           O: inout STD_LOGIC_VECTOR(2*size-1  downto 0)); -- Output
end mac;

architecture Behavioral of mac is
-- Array Multiplier declaration
component ArrayMult is
    generic ( size: integer :=4);
    Port ( A_in : in STD_LOGIC_VECTOR (size-1 downto 0);
           X_in : in STD_LOGIC_VECTOR (size-1 downto 0);
           Prod: out STD_LOGIC_VECTOR(2*size-1  downto 0));
end component ArrayMult;
-- Ripple carry adder declaration
component RCADDER is
  generic (
    WIDTH : natural := 8
    );
  port (
    X  : in std_logic_vector(WIDTH-1 downto 0);
    Y  : in std_logic_vector(WIDTH-1 downto 0);
    C_in : in std_logic;
    --
    RESULT   : out std_logic_vector(WIDTH-1 downto 0);
    OVERFLOW  : out std_logic
    );
end component RCADDER;


component reg is
	generic(
		n	:	integer := 8								-- Data width
	);
	port(
		clk		:	in	std_logic;							-- Clock signal
		rst		:	in	std_logic;							-- Reset signal
		data	:	in	std_logic_vector(n - 1 downto 0);	-- input data
		q		:	out	std_logic_vector(n - 1 downto 0)	-- output data
	);
end component reg;

signal z : std_logic_vector(2*size-1 downto 0);
--signal y : std_logic_vector(2*size downto 0);
signal x : std_logic_vector(2*size-1 downto 0);
signal inst : std_logic :='0';

begin
 -- Multiplier instantiation
    Mult_INST : ArrayMult
		generic map(
		size => 4) --Increase the number of bits of the input(multiplier)
      port map (
        A_in  => A,
        X_in  => B,
        Prod => z           
		  
        );
-- Adder instantiation
      Cla_INST : RCADDER
		generic map(
		WIDTH => 8) --Increase the number of bits of the adder(2 times the inputs)
      port map (
        X  => z,
        Y  => O,
		  C_in => inst, 
        RESULT => x,
		  OVERFLOW => inst 		  
        );
-- Register instantiation	  
      reg_INST : reg
		generic map(
		n => 8) --Increase the number of bits of the register(2 times the inputs)
      port map (
        clk  => CLK,
        rst  => RST,
        data => x, 
		  q => O		  
        );
		  
end Behavioral;
