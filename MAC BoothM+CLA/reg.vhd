 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Booth multiplier + carry lookahead adder
  -- URL of the project:
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: reg (register/accumulator)
  ----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic(
		n	:	integer := 8								-- Data width
	);
	port(
		clk		:	in	std_logic;							-- Clock signal
		rst		:	in	std_logic;							-- Reset signal
		data	:	in	std_logic_vector(n - 1 downto 0);	-- input data
		q		:	out	std_logic_vector(n - 1 downto 0)	-- output data
	);
end reg;

architecture behavioral of reg is
begin
	
	process(rst, clk, data)
	begin
		
		-- Reset if rst = 0
		if rst = '0' then
			q <= (others => '0');
		elsif rising_edge(clk) then -- register data on clocks rising edge
			q <= data;
		end if;
		
	end process;
	
end behavioral;