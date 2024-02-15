------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: Can extend a 16 bit integer with 0s or 1s.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity BitWidthExtender is 
	port(i_S		: in std_logic;
	     i_in		: in std_logic_vector(15 downto 0);
	     o_Out		: out std_logic_vector(31 downto 0));
end BitWidthExtender;

architecture data of BitWidthExtender is

component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal s_inBetween : std_logic_vector(15 downto 0);

begin

loop1: for i in 0 to 15 generate

G_and1 : andg2 port map(
	i_A	=> i_in(i),
	i_B	=> '1',
	o_F	=> o_Out(i));
	
end generate loop1;

loop2: for i in 16 to 31 generate

G_and2 : andg2 port map(
	i_A	=> i_S,
	i_B	=> '1',
	o_F	=> o_Out(i));

end generate loop2;

end data;