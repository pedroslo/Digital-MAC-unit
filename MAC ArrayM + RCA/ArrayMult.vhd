 ----------------------------------------------------------------------------------------------
  -- Author: Pedro S. Locatelli
  -- Institution: Federal University of Minas Gerais
  -- Name of the project: MAC unit: Array multiplier + ripple carry adder
  -- URL of the project:
  ---------------------------------------------------------------------------------------------
  -- project_top: mac -- Current file: ArrayMult (Array Multiplier employed in mac)
  ---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ArrayMult is
    generic ( size: integer :=7);
    Port ( A_in : in STD_LOGIC_VECTOR (size-1 downto 0); -- Input 1
           X_in : in STD_LOGIC_VECTOR (size-1 downto 0); -- Input 2
           Prod: out STD_LOGIC_VECTOR(2*size-1  downto 0)); -- Result/Product
end ArrayMult;

architecture Behavioral of ArrayMult is
component FA_Block is
    Port ( Ai : in STD_LOGIC;
           Xi : in STD_LOGIC;
           Ai_1 : in STD_LOGIC;
           Ci_in : in STD_LOGIC;
           COut : out STD_LOGIC;
           POut : out STD_LOGIC);
end component;

--Signals 
type Bridge is Array (size downto 0) of STD_LOGIC_VECTOR(size-1 downto 0);
signal COut_Array: Bridge;
signal ProdBit_Array:Bridge; 
signal LSB_portion : std_logic_vector(size-1 downto 0);


-- Mapping and generation
begin
genRow: for j in 0 to size generate
   genBlock:for k in 0 to size-1 generate
        LSBROW0:if(j=0 and k=0) generate
        Row0_Block:FA_Block port map(
                        Ai=>A_in(k),
                        Ai_1=>'0',
                        Ci_in=>'0',
                        Xi=>X_in(0),
                        COut=>COut_Array(j)(k),
                        POut=>LSB_portion(j));
        end generate LSBROW0;
        Row_0: if (j=0 and k<size-1 and k>0) generate --generate the first Row considering C_in =0         
            Row0_Block:FA_Block port map(
                Ai=>A_in(k),
                Ai_1=>'0',
                Ci_in=>'0',
                Xi=>X_in(0),
                COut=>COut_Array(j)(k),
                POut=>ProdBit_Array(j)(k));
            end generate Row_0;
            Row_0End: if (j=0 and k=size-1) generate 
                        Row0_Block:FA_Block port map(
                            Ai=>A_in(k),
                            Ai_1=>'0',
                            Ci_in=>'0',
                            Xi=>X_in(0),
                            COut=>COut_Array(j)(k),
                            POut=>ProdBit_Array(j)(k));
                        end generate Row_0End;
            Row_jLSB: if(j>0 and j<size and k=0) generate
                                LSBBlock:FA_Block port map(
                                    Ai=>A_in(k), 
                                    Xi=>X_in(j),
                                    Ai_1=>ProdBit_Array(j-1)(k+1),
                                    Ci_in=>COut_Array(j-1)(k),
                                    COut=>COut_Array(j)(k),
                                    POut=>LSB_portion(j));
                end generate Row_jLSB;
            
            Row_j: if(j>0 and j<size and k<size-1 and k>0) generate
                Rowj_Block:FA_Block port map(
                    Ai=>A_in(k), 
                    Xi=>X_in(j),
                    Ai_1=>ProdBit_Array(j-1)(k+1),
                    Ci_in=>COut_Array(j-1)(k),
                    COut=>COut_Array(j)(k),
                    POut=>ProdBit_Array(j)(k));
        end generate Row_j;

        Row_jMSB: if(j>0 and j<size and k=size-1) generate
            Rowj_Block:FA_Block port map(
                Ai=>A_in(k), 
                Xi=>X_in(j),
                Ai_1=>'0',
                Ci_in=>COut_Array(j-1)(k),
                COut=>COut_Array(j)(k),
                POut=>ProdBit_Array(j)(k));
        end generate Row_jMSB;
        Row_end0: if (j=size and k=0) generate
                    
                    RowEnd_0Block:FA_Block port map(
                        Ai=>COut_Array(j-1)(k), 
                        Xi=>COut_Array(j-1)(k),
                        Ai_1=>ProdBit_Array(j-1)(k+1),
                        Ci_in=>'0',
                        COut=>COut_Array(j)(k),
                        POut=>ProdBit_Array(j)(k));
            end generate Row_end0;
            
        Row_end: if (j=size and k<size-2 and k>0) generate

                
                RowEnd_Block:FA_Block port map(
                    Ai=>COut_Array(j-1)(k), 
                    Xi=>COut_Array(j-1)(k),
                    Ai_1=>ProdBit_Array(j-1)(k+1),
                    Ci_in=>COut_Array(j)(k-1),
                    COut=>COut_Array(j)(k),
                    POut=>ProdBit_Array(j)(k));
        end generate Row_end;
        --Generating last set adders, number equivalent to MSB
        RowEnd_MSB: if (j=size and k=size-2) generate --
            Final_Block: FA_Block port map(
                    Ai=>COut_Array(j-1)(k), 
                    Xi=>COut_Array(j-1)(k),
                    Ai_1=>ProdBit_Array(j-1)(k+1),
                    Ci_in=>COut_Array(j)(k-1),
                    COut=>ProdBit_Array(j)(k+1),
                    POut=>ProdBit_Array(j)(k));
        end generate RowEnd_MSB;
        
    end generate genBlock;
 end generate genRow;
 
--Calculating Final result
Prod<=ProdBit_Array(size)(size-1 downto 0) & LSB_portion;


end Behavioral;