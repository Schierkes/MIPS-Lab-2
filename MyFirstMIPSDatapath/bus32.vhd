-------------------------------------------------------------------------
-- Sophie Waterman Hines
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- DESCRIPTION: Makes my life easier by making an array of vectors for
-- future files :)
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

package bus32 is
	type Arr is array (31 downto 0) of std_logic_vector(31 downto 0);
end package bus32;