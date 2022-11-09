 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Booth multiplier + carry lookahead adder
  -- URL of the project: https://github.com/pedroslo/Digital-MAC-unit
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: mac
  ----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity mac is
    generic ( size: integer :=2); -- MAC number of bits
    Port ( A : in STD_LOGIC_VECTOR (size-1 downto 0); --Input 1
           B : in STD_LOGIC_VECTOR (size-1 downto 0); --Input 2
			  CLK : in std_logic; --Clock
			  RST : in std_logic; --Reset/clear accumulator stored value
           O: inout STD_LOGIC_VECTOR(2*size-1  downto 0)); -- Output
end mac;

architecture Behavioral of mac is
-- Booth Multiplier declaration
component booth_multiplier IS

	GENERIC (x : INTEGER := 4;
		 y : INTEGER := 4);
	
	PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
		  
END component booth_multiplier;
-- Carry lookahead adder declaration
component carry_lookahead_adder is
  generic (
    size : natural := 4
    );
  port (
    i_add1  : in std_logic_vector(2*size-1 downto 0);
    i_add2  : in std_logic_vector(2*size-1 downto 0);
    --
    o_result   : out std_logic_vector(2*size-1 downto 0)
    );
end component carry_lookahead_adder;

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

begin
 -- Multiplier instantiation
    Mult_INST : booth_multiplier
		generic map(
		x => 2,
		y => 2) --Increase the number of bits of the input(multiplier)
      port map (
        m  => A,
        r  => B,
        result => z           
		  
        );
-- Adder instantiation
      Cla_INST : carry_lookahead_adder
		generic map(
		size => 2) --Increase the number of bits of the adder
      port map (
        i_add1  => z,
        i_add2  => O,
        o_result => x               
        );
-- Register instantiation	  
      reg_INST : reg
		generic map(
		n => 4) --Increase the number of bits of the register(2 times the inputs)
      port map (
        clk  => CLK,
        rst  => RST,
        data => x, 
		  q => O		  
        );
		  
end Behavioral;
