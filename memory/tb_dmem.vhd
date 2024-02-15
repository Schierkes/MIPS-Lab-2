-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: Contains the dmem testbench.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;             

  generic(gCLK_HPER   : time := 10 ns);   
end tb_dmem;

architecture behavior of tb_dmem is

constant cCLK_PER  : time := gCLK_HPER * 2;

component mem is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);
	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;

signal s_CLK : std_logic;
signal s_we : std_logic := '1';
signal s_data, s_q : std_logic_vector(31 downto 0) := (others => '0');
signal s_addr : std_logic_vector(9 downto 0) := (others => '0');

begin

  DUT0: mem
  port map(
		clk	=> s_CLK,
		addr	=> s_addr,
		data	=> s_data,
		we	=> s_we,
		q	=> s_q);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  P_TB: process  
  begin

  s_addr <= "0000000000";
   wait for cCLK_PER;

  s_addr <= "0000000001";
   wait for cCLK_PER;

  s_addr <= "0000000010";
   wait for cCLK_PER;

  s_addr <= "0000000011";
   wait for cCLK_PER;

  s_addr <= "0000000100";
   wait for cCLK_PER;

  s_addr <= "0000000101";
   wait for cCLK_PER;

  s_addr <= "0000000110";
   wait for cCLK_PER;

  s_addr <= "0000000111";
   wait for cCLK_PER;

  s_addr <= "0000001000";
   wait for cCLK_PER;

  s_addr <= "0000001001";
   wait for cCLK_PER;

  s_addr <= "0000001010";
   wait for cCLK_PER;
   
---------------------------------------------

  s_addr <= "0100000000"; 
  s_data <= x"FFFFFFFE";
   wait for cCLK_PER;

  s_addr <= "0100000001";
  s_data <= x"FFFFFFFD";
   wait for cCLK_PER;

  s_addr <= "0100000010";
  s_data <= x"FFFFFFFC";
   wait for cCLK_PER;

  s_addr <= "0100000011"; 
  s_data <= x"FFFFFFFB";
   wait for cCLK_PER;

  s_addr <= "0100000100";
  s_data <= x"FFFFFFFA";
   wait for cCLK_PER;

  s_addr <= "0100000101";
  s_data <= x"FFFFFFF9";
   wait for cCLK_PER;

  s_addr <= "0100000110";
  s_data <= x"FFFFFFF8";
   wait for cCLK_PER;

  s_addr <= "0100000111";
  s_data <= x"FFFFFFF7";
   wait for cCLK_PER;

  s_addr <= "0100001000";
  s_data <= x"FFFFFFF6";
   wait for cCLK_PER;

  s_addr <= "0100001001";
  s_data <= x"FFFFFFF5";
   wait for cCLK_PER;

---------------------------------------------

  s_addr <= "0100000000"; 
   wait for cCLK_PER;

  s_addr <= "0100000001"; 
   wait for cCLK_PER;

  s_addr <= "0100000010";
   wait for cCLK_PER;

  s_addr <= "0100000011"; 
   wait for cCLK_PER;

  s_addr <= "0100000100";
   wait for cCLK_PER;

  s_addr <= "0100000101";
   wait for cCLK_PER;

  s_addr <= "0100000110";
   wait for cCLK_PER;

  s_addr <= "0100000111";
   wait for cCLK_PER;

  s_addr <= "0100001000";
   wait for cCLK_PER;

  s_addr <= "0100001001";
   wait for cCLK_PER;

    wait;
  end process;
  
end behavior;