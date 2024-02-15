-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--DESCRIPTION: Contains the testbench for SecondDatapath
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;             

entity tb_SecondDatapath is
  generic(gCLK_HPER   : time := 10 ns);
end tb_SecondDatapath;

architecture behavior of tb_SecondDatapath is

constant cCLK_PER  : time := gCLK_HPER * 2;

component SecondDatapath is
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
end component;

signal s_CLK : std_logic;
signal s_RST, s_add_load, s_nAdd_Sub, s_signCtrl, s_ramWE, s_ALUsrc : std_logic := '0';
signal s_RS, s_RT, s_RD : std_logic_vector(4 downto 0) := (others => '0');
signal s_DI : std_logic_vector(15 downto 0) := (others => '0');


begin

  DUT0: SecondDatapath
  port map(i_CLK        	=> s_CLK,
		i_RST	  	=> s_RST,
       	i_RS      	=> s_RS,
       	i_RT      	=> s_RT,
       	i_RD      	=> s_RD,
		i_DI	      	=> s_DI,
		i_add_load    	=> s_add_load,
		i_nAdd_Sub    	=> s_nAdd_Sub,
		i_signCtrl    	=> s_signCtrl,
		i_ramWE	      	=> s_ramWE,
		i_ALUsrc      	=> s_ALUsrc);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
 
  P_TB: process
  begin

-- addi  $25, $0, 0 
   s_RS		<= "00000";
   s_RT		<= "00000";
   s_RD		<= "11001";
   s_DI		<= x"0000";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- addi  $26, $0, 256
   s_RS		<= "00000";
   s_RT		<= "00000";
   s_RD		<= "11010";
   s_DI		<= x"0100";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;


-- lw $1, 0($25)
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00001";
   s_DI		<= x"0000";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw $2, 4($25)
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"0004";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- add $1, $1, $2
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0000";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- sw $1, 0($26)
   s_RS		<= "11010";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"0000";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw      $2,  8($25)         
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"0008";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;


-- add      $1,  $1, $2         
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0002";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- sw    $1,  4($26)         
   s_RS		<= "11010";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"0004";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw      $2,  12($25)        
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"000C";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- add      $1,  $1, $2         
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0003";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- sw    $1,  8($26)        
   s_RS		<= "11010";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"0008";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw      $2,  16($25)      
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"0010";
   s_add_load	<= '1';
   s_nAdd_Sub	<=  '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- add      $1,  $1, $2     
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0000";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- sw    $1,  12($26)        
   s_RS		<= "11010";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"000C";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw      $2,  20($25)         
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"0014";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- add      $1,  $1, $2         
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0002";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- sw    $1,  16($26)         
   s_RS		<= "11010";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"0010";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- lw      $2,  24($25)         
   s_RS		<= "11001";
   s_RT		<= "00000";
   s_RD		<= "00010";
   s_DI		<= x"0018";
   s_add_load	<= '1';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- add      $1,  $1, $2         
   s_RS		<= "00001";
   s_RT		<= "00010";
   s_RD		<= "00001";
   s_DI		<= x"0000";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '0';
    wait for cCLK_PER;

-- addi  $27, $0, 512         
   s_RS		<= "00000";
   s_RT		<= "00001";
   s_RD		<= "11011";
   s_DI		<= x"0200";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '0';
   s_ramWE	<= '0';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;

-- sw      $1,  -4($27)         
   s_RS		<= "11011";
   s_RT		<= "00001";
   s_RD		<= "00000";
   s_DI		<= x"FFFC";
   s_add_load	<= '0';
   s_nAdd_Sub	<= '0';
   s_signCtrl	<= '1';
   s_ramWE	<= '1';
   s_ALUsrc	<= '1';
    wait for cCLK_PER;


    wait;
  end process;
  
end behavior;