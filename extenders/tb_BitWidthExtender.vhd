-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for the BitWidthExtender
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_BitWidthExtender is
  generic(gCLK_HPER   : time := 50 ns);
end tb_BitWidthExtender;

architecture behavior of tb_BitWidthExtender is
  
  constant cCLK_PER  : time := gCLK_HPER * 2;

component BitWidthExtender is 
	port(i_S		: in std_logic;
	     i_in		: in std_logic_vector(15 downto 0);
	     o_Out		: out std_logic_vector(31 downto 0));
end component;

  signal s_CLK : std_logic;
  signal s_S 	: std_logic;
  signal s_in 	: std_logic_vector(15 downto 0);
  signal s_Out	: std_logic_vector(31 downto 0);

begin

  DUT: BitWidthExtender
  port map(i_S	=> s_S, 
           i_in	=> s_in,
	   o_Out	=> s_Out);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  P_TB: process
  begin

   s_S <= '0';
   s_in <= "0000000000000000";
    wait for cCLK_PER;

   s_S <= '0';
   s_in <= "0000000000000001";
    wait for cCLK_PER;

   s_S <= '0';
   s_in <= x"FFFF";
    wait for cCLK_PER;

   s_S <= '1';
   s_in <= x"FFFF";
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;