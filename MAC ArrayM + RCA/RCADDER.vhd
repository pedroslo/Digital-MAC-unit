 ----------------------------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Array multiplier + ripple carry adder
  -- URL of the project:
  ---------------------------------------------------------------------------------------------
  -- project_top: mac --Current file: RCADDER (Ripple carry adder employed in mac)
  ---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RCADDER is
  generic (
    WIDTH : natural := 2
    );
  port (
    X  : in std_logic_vector(WIDTH-1 downto 0); --Input 1
    Y  : in std_logic_vector(WIDTH-1 downto 0); --Input 2
    C_in : in std_logic; --Carry in
    --
    RESULT   : out std_logic_vector(WIDTH-1 downto 0); --Result of sum
    OVERFLOW  : out std_logic -- overflow flag
    );
end RCADDER;


architecture RTL of RCADDER is

  component FULL_ADDER is
    port (
        A : in std_logic;
        B : in std_logic;
        C_in : in std_logic;
        S : out std_logic;
        C_out : out std_logic
      );
  end component;


  signal CARRY : std_logic_vector(WIDTH downto 0);
  signal SUM   : std_logic_vector(WIDTH-1 downto 0);


begin

  CARRY(0) <= C_in;                    -- no carry input on first full adder
  OVERFLOW <= CARRY(WIDTH);
--Full adders in series, forming RCA topology
  FULL_ADDERS : for i in 0 to WIDTH-1 generate
    i_FULL_ADDER_INST : FULL_ADDER
      port map (
        A  => X(i),
        B  => Y(i),
        C_in => CARRY(i),
        S  => RESULT(i),
        C_out => CARRY(i+1)
        ); 
  end generate FULL_ADDERS;


end RTL;
