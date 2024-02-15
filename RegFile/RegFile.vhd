-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--DESCRIPTION: Contains implementing of regfile
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity RegFile is
	generic(N : integer := 32); --Generic i/o data width
	 port(i_CLK        : in std_logic;     -- for clock input
       		i_RST        : in std_logic;     -- for reset input
       		i_WE         : in std_logic;     -- for write enable input
       		i_D          : in std_logic_vector(N-1 downto 0);     -- for data input
       		o_Q          : out std_logic_vector(N-1 downto 0));   -- for data output

end RegFile;

architecture struct of RegFile is

	component dffg is
  	   port(i_CLK        : in std_logic;     -- clock input
       		i_RST        : in std_logic;     -- reset input
       		i_WE         : in std_logic;     -- write input
      		i_D          : in std_logic;     -- data input
       		o_Q          : out std_logic);   -- data output
	end component;

begin

systemProcess : for i in 0 to N-1 generate
	readWrite : dffg port map(
	i_CLK	=>	i_CLK,
	i_RST	=>	i_RST,
	i_WE	=>	i_WE,
	i_D	=>	i_D(i),
	o_Q	=>	o_Q(i));

end generate systemProcess;

end struct;