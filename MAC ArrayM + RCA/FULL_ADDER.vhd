 ----------------------------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Array multiplier + ripple carry adder
  -- URL of the project:
  ---------------------------------------------------------------------------------------------
  -- project_top: mac --Current file: FULL_ADDER ( Full-adder for array multiplier)
  ---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER is
	port(
      A : in std_logic; --Input 1
			B : in std_logic; --Input 1
			C_in : in std_logic; --Carry in
			S : out std_logic; --Result
			C_out : out std_logic --Carry out
		);
end FULL_ADDER;

-- Full adder made of two half adders
architecture structural of FULL_ADDER is

		component half_adder is
			port(
          A : in std_logic;
					B : in std_logic;
					U : out std_logic;
					C : out std_logic
				);
		end component;


		signal half_adder_out : std_logic :='0';
		signal cout1, cout2 : std_logic :='0';
		begin


		half_adder1 : half_adder
			port map( A => A,
					  B => B,
					  U => half_adder_out,
					  C =>cout1
					);

		half_adder2 : half_adder
			port map(
            A => half_adder_out,
						B => C_in,
						U => S,
						C =>cout2
					);

		C_out <= cout1 or cout2;

end structural;
