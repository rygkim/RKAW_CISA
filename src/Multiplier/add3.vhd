----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    add_exp - structural
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

entity adder3 is
	port(A : in STD_LOGIC;
			B : in STD_LOGIC;
			C : in STD_LOGIC;
			SUM : out STD_LOGIC;
			CARRY : out STD_LOGIC
		);
end adder3;
architecture Structural of adder3 is 
begin
	SUM <= (A xor B xor C);
	CARRY <= not ((A nand B) and (B nand C) and (A nand C));
end Structural;