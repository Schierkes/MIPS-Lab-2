-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: Contains implementation of a register file.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.bus32.Arr;

entity RegisterFile is
	generic(N : integer := 32); 
	 port(i_CLK        : in std_logic;     
		i_RST	   : in std_logic;     
       		i_RS        : in std_logic_vector(4 downto 0);     
       		i_RT         : in std_logic_vector(4 downto 0);    
       		i_RD          : in std_logic_vector(4 downto 0);
			i_DI	      : in std_logic_vector(N-1 downto 0);
			o_Q1  	      : out std_logic_vector(N-1 downto 0); 
       		o_Q2          : out std_logic_vector(N-1 downto 0)); 
end RegisterFile;

architecture struct of RegisterFile is

	component RegFile is

  	 generic(N : integer := 32); 
	 port(i_CLK        : in std_logic;     
       		i_RST        : in std_logic;     
       		i_WE         : in std_logic;     
       		i_D          : in std_logic_vector(N-1 downto 0);     
       		o_Q          : out std_logic_vector(N-1 downto 0));   

	end component;

	component mux32t1 is 
	port(i_S		: in std_logic_vector(4 downto 0);
	     i_D		: in Arr;
	     o_O		: out std_logic_vector(31 downto 0));
	end component;

	component decoder is

	port(i_sel  : in std_logic_vector(4 downto 0);
	     o_Out  : out std_logic_vector(31 downto 0));

	end component;

	signal compbus : Arr := (others => x"00000000");
	signal WEbus	: std_logic_vector(31 downto 0);

	begin

register_select : decoder
	port map(
		i_sel => i_RD,
		o_Out => WEbus);

systemProcess : for i in 1 to N-1 generate
	readWrite : RegFile port map(
	i_CLK	=>	i_CLK,
	i_RST	=>	i_RST,
	i_WE	=>	WEbus(i),  
	i_D	=>	i_DI,  
	o_Q	=>	compbus(i)); 
end generate systemProcess;

RA_mux : mux32t1 
	port map(
		i_S	=>  i_RS,
		i_D	=>  complex_bus,
		o_O	=>  o_Q1);
RB_mux : mux32t1 
	port map(
		i_S	=>  i_RT,
		i_D	=>  complex_bus,
		o_O	=>  o_Q2);

end struct;