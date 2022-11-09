 ----------------------------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Array multiplier + ripple carry adder
  -- URL of the project:
  ---------------------------------------------------------------------------------------------
  -- project_top: mac --Current file: Half_adder ( half-adder for array multiplier full-adder
  ---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is

		port(	A : in std_logic;
				B : in std_logic;
				U : out std_logic;
				C : out std_logic
			);
end half_adder;

architecture dataflow of half_adder is

begin

	U <= A xor B;
	C <= A and B;


end dataflow;
