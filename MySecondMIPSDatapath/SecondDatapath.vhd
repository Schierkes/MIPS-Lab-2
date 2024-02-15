-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.bus32.Arr;

entity SecondDatapath is
	 port(i_CLK        : in std_logic;     
		i_RST	   : in std_logic;     
       		i_RS        : in std_logic_vector(4 downto 0);    
       		i_RT         : in std_logic_vector(4 downto 0);     
       		i_RD          : in std_logic_vector(4 downto 0); 
			i_DI	      : in std_logic_vector(15 downto 0); 
			i_add_load    : in std_logic;
			i_nAdd_Sub    : in std_logic;
			i_signCtrl    : in std_logic;
			i_ramWE	      : in std_logic;
			i_ALUsrc      : in std_logic);
end SecondDatapath;

architecture struct of SecondDatapath is

component Registerfile 
	generic(N : integer := 32); 
	 port(i_CLK        : in std_logic;     
		i_RST	   : in std_logic;     
       	i_RS        : in std_logic_vector(4 downto 0); 
       	i_RT         : in std_logic_vector(4 downto 0);
       	i_RD          : in std_logic_vector(4 downto 0); 
		i_DI	      : in std_logic_vector(N-1 downto 0); 
		o_Q1  	      : out std_logic_vector(N-1 downto 0); 
       	o_Q2          : out std_logic_vector(N-1 downto 0));  

	end component;

component mux2t1_N 
  	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
 	 port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component Add_Sub
	generic(N : integer := 32); --Generic i/o data width
	port(	iA	: in std_logic_vector(N-1 downto 0);
		iB	: in std_logic_vector(N-1 downto 0);
		nAdd_Sub	: in std_logic;
		oSum	: out std_logic_vector(N-1 downto 0));
end component;


component BitWidthExtender is 
	port(i_S		: in std_logic;
	     i_in		: in std_logic_vector(15 downto 0);
	     o_Out		: out std_logic_vector(31 downto 0));
end component;

component mem is
	generic 
		(DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10);
	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component;

	signal s_A : std_logic_vector(32-1 downto 0);
	signal s_B : std_logic_vector(32-1 downto 0);
	signal s_Opperand : std_logic_vector(32-1 downto 0);
	signal s_AdderOut : std_logic_vector(32-1 downto 0); 
	signal s_extendedImm : std_logic_vector(32-1 downto 0);
	signal s_ramOut	     : std_logic_vector(32-1 downto 0);
	signal s_regWrite    : std_logic_vector(32-1 downto 0);
	
begin

bitextension : BiWidthExtender
	port map(
		i_S	=> i_signCtrl,
		i_in	=> i_DI,
		o_Out	=> s_extendedImm);


ALUSRC : mux2t1_N
	port map(
		i_S  => i_ALUsrc,
		i_D0 => s_B,
		i_D1 => s_extendedImm,
		o_O  => s_Opperand);


c_registerfile :  RegisterFile 
	port map(
	i_CLK	=> i_CLK,
	i_RST	=> i_RST,
       	i_RS	=> i_RS,       
       	i_RT    => i_RT,
       	i_RD    => i_RD,     
	i_DI	=> s_regWrite,      
	o_Q1  	=> s_A,   
       	o_Q2    => s_B);   -- Data value output 2 (RT)

adder : Add_Sub 
	port map(
		iA		=> s_A,
		iB		=> s_Opperand,
		nAdd_Sub	=> i_nAdd_Sub,
		oSum		=> s_AdderOut);

regWriteCtrl : mux2t1_N     -- 0 to store value from the adder, 1 to store value from memory
	port map(
		i_S	=> i_add_load,
		i_D0	=> s_adderOut,
		i_D1	=> s_ramOut,
		o_O	=> s_regWrite);

ram : mem
	port map(
		clk	=> i_CLK,
		addr	=> s_AdderOut(11 downto 2),
		data	=> s_B,
		we	=> i_ramWE,
		q	=> s_ramOut);


end struct;