----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    fp_mult - structural
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
use IEEE.STD_LOGIC_MISC.ALL;

entity fp_mult is
    Port ( A : in STD_LOGIC_VECTOR (63 downto 0);
		   B : in STD_LOGIC_VECTOR (63 downto 0);
		   Y : out STD_LOGIC_VECTOR(63 downto 0)
		);
end fp_mult;

architecture Structural of fp_mult is

begin

end Structural;