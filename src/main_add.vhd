----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    main_add - structural
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_add is
    Port ( Smaller : in STD_LOGIC_VECTOR(26 downto 0),
			Larger : in STD_LOGIC_VECTOR(23 downto 0),
			Cin    : in STD_LOGIC,
			Cout   : out STD_LOGIC,
			Sum    : out STD_LOGIC);
end main_add;

architecture Structural of main_add is

begin


end Structural;