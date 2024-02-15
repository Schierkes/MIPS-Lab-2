-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: Contains test for the N-bit register.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;             

entity tb_FirstDatapath is
  generic(gCLK_HPER   : time := 10 ns);  
end tb_FirstDatapath;

architecture behavior of tb_FirstDatapath is

constant cCLK_PER  : time := gCLK_HPER * 2;

component FirstDatapath is
	generic(N : integer := 32); 
	 port(i_CLK        : in std_logic;     
		i_RST	   : in std_logic;    
       	i_RS        : in std_logic_vector(4 downto 0);     
       	i_RT         : in std_logic_vector(4 downto 0);    
       	i_RD          : in std_logic_vector(4 downto 0); 
		i_DI	      : in std_logic_vector(N-1 downto 0); 
		i_nAdd_Sub    : in std_logic;
		i_ALUsrc      : in std_logic);

end component;

signal s_CLK : std_logic;
signal s_RST, s_nAdd_Sub, s_ALUsrc : std_logic := '0';
signal s_RS, s_RT, s_RD : std_logic_vector(4 downto 0) := (others => '0');
signal s_DI : std_logic_vector(31 downto 0) := (others => '0');

begin

  DUT0: FirstDatapath
  port map(
		i_CLK		=> s_CLK,
		i_RST		=> s_RST,
		i_RS		=> s_RS,
		i_RT		=> s_RT,
		i_RD		=> s_RD,
		i_DI		=> s_DI,
		i_nAdd_Sub	=> s_nAdd_Sub,
		i_ALUsrc	=> s_ALUsrc);

            
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  P_TB: process
  begin
    -- addi $1 $0 1
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00001";
	s_DI		<= x"00000001";
    wait for cCLK_PER;

  -- addi $2 $0 2
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00010";
	s_DI		<= x"00000002";
    wait for cCLK_PER;

  -- addi $3 $0 3
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00011";
	s_DI		<= x"00000003";
    wait for cCLK_PER;

  -- addi $4 $0 4
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00100";
	s_DI		<= x"00000004";
    wait for cCLK_PER;

 -- addi $5 $0 5
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00101";
	s_DI		<= x"00000005";
    wait for cCLK_PER;

 -- addi $6 $0 6
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00110";
	s_DI		<= x"00000006";
    wait for cCLK_PER;

-- addi $7 $0 7
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "00111";
	s_DI		<= x"00000007";
    wait for cCLK_PER;

-- addi $8 $0 8
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "01000";
	s_DI		<= x"00000008";
    wait for cCLK_PER;

-- addi $9 $0 9
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "01001";
	s_DI		<= x"00000009";
    wait for cCLK_PER;

-- addi $10 $0 10
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "01010";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;


-- add $11 $1 $2
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "00001";
	s_RT		<= "00010";
	s_RD		<= "01011";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;


-- sub $12 $11 $3 ::::  $12 = $11 - $3
	s_nAdd_Sub	<=  '1';
	s_ALUsrc	<= '1';
	s_RS		<= "01011";
	s_RT		<= "00011";
	s_RD		<= "01100";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;


-- add $13, $12, $4 :::: $13 = $12 + $4 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "01100";
	s_RT		<= "00100";
	s_RD		<= "01101";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- sub $14, $13, $5 :::: $14 = $13 - $5 
	s_nAdd_Sub	<=  '1';
	s_ALUsrc	<= '1';
	s_RS		<= "01101";
	s_RT		<= "00101";
	s_RD		<= "01110";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- add $15, $14, $6 :::: $15 = $14 + $6 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "01110";
	s_RT		<= "00110";
	s_RD		<= "01111";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- sub $16, $15, $7 :::: $16 = $15 - $7
	s_nAdd_Sub	<=  '1';
	s_ALUsrc	<= '1';
	s_RS		<= "01111";
	s_RT		<= "00111";
	s_RD		<= "10000";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- add $17, $16, $8 :::: $17 = $16 + $8 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "10000";
	s_RT		<= "01000";
	s_RD		<= "10001";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- sub $18, $17, $9 :::: $18 = $17 - $9 
	s_nAdd_Sub	<=  '1';
	s_ALUsrc	<= '1';
	s_RS		<= "10001";
	s_RT		<= "01001";
	s_RD		<= "10010";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- add $19, $18, $10 :::: $19 = $18 + $10 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "10010";
	s_RT		<= "01010";
	s_RD		<= "10011";
	s_DI		<= x"0000000A";
    wait for cCLK_PER;

-- addi $20, $0, -35 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '0';
	s_RS		<= "00000";
	s_RD		<= "10100";
	s_DI		<= x"FFFFFFDD";
    wait for cCLK_PER;

-- add $21, $19, $20 
	s_nAdd_Sub	<=  '0';
	s_ALUsrc	<= '1';
	s_RS		<= "10011";
	s_RT		<= "10100";
	s_RD		<= "10101";
	s_DI		<= x"00000000";
    wait for cCLK_PER;

    wait;
  end process;
end behavior;
