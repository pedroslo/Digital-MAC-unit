 -----------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Booth multiplier + carry lookahead adder
  -- URL of the project:
  ----------------------------------------------------------------------------
  -- project_top: mac --Current file: carry_lookahead_adder
  ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
 
entity carry_lookahead_adder is
  generic (
    size : natural := 4
    );
  port (
    i_add1  : in std_logic_vector(2*size-1 downto 0); --Input 1
    i_add2  : in std_logic_vector(2*size-1 downto 0); --Input 2
    --
    o_result   : out std_logic_vector(2*size-1 downto 0) -- Result
    );
end carry_lookahead_adder;
 
 
architecture rtl of carry_lookahead_adder is
 
  component full_adder is
    port (
      i_bit1  : in  std_logic;
      i_bit2  : in  std_logic;
      i_carry : in  std_logic;
      o_sum   : out std_logic;
      o_carry : out std_logic);
  end component full_adder;
  
  -- Intermediate signals to control adder operation
  signal w_P : std_logic_vector(2*size-1 downto 0); -- Propagate singal
  signal w_G : std_logic_vector(2*size-1 downto 0); -- Generate signal
  signal w_C : std_logic_vector(2*size downto 0);   -- Carry signal
 
  signal w_SUM  : std_logic_vector(2*size-1 downto 0);
 
begin
 
  -- Full Adders "in series' declaration
  GEN_FULL_ADDERS : for ii in 0 to 2*size-1 generate
    FULL_ADDER_INST : full_adder
      port map (
        i_bit1  => i_add1(ii),
        i_bit2  => i_add2(ii),
        i_carry => w_C(ii),        
        o_sum   => w_SUM(ii),
        o_carry => open
        );
  end generate GEN_FULL_ADDERS;
 

  GEN_CLA : for jj in 0 to 2*size-1 generate
    w_G(jj)   <= i_add1(jj) and i_add2(jj); -- Generate (G) singals:  Gi=Ai*Bi
    w_P(jj)   <= i_add1(jj) or i_add2(jj); -- Propagate (P) signals: Pi=Ai+Bi
    w_C(jj+1) <= w_G(jj) or (w_P(jj) and w_C(jj)); -- Carry (C) Signals 
  end generate GEN_CLA;
     
  w_C(0) <= '0'; 
 
  o_result <= w_SUM;  
   
end rtl;