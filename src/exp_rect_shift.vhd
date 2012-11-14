----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:59:07 11/04/2012 
-- Design Name: 
-- Module Name:    exp_rect_shift - Behavioral 
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

--using A GT B, determine if operation will be A-B or B-A
--e.g. A>B => A-B, else B-A. we don't care about A=B since output
--will be zero. 

--!! ALEC: If this is to be sequential, DO take into account A=B since
--			  Combinatorial subtraction can be skipped.

entity exp_rect_shift is
    Port ( A : in  STD_LOGIC_VECTOR (10 downto 0);
           B : in  STD_LOGIC_VECTOR (10 downto 0);
			  A_GT_B : in STD_LOGIC;
			  A_hidden : out STD_LOGIC;
			  B_hidden : out STD_LOGIC;
           EXP : out  STD_LOGIC_VECTOR (10 downto 0);
           SHIFT : out  STD_LOGIC_VECTOR (5 downto 0));
end exp_rect_shift;

architecture Behavioral of exp_rect_shift is

	COMPONENT absolute
	PORT(
		A : IN std_logic_vector(10 downto 0);
		B : IN std_logic_vector(10 downto 0);          
		S : OUT std_logic_vector(10 downto 0)
		);
	END COMPONENT;


signal absdif : std_logic_vector(10 downto 0);
signal nullA : std_logic;
signal nullB : std_logic;
signal expnull : std_logic;
signal loadA : std_logic_vector(10 downto 0);
signal loadB : std_logic_vector(10 downto 0);

begin

EXP <= A when A_GT_B = '1' else B; --Select the GREATER of the two exponents


	Inst_absolute: absolute PORT MAP(
		A => loadA,
		B => loadB,
		S => absdif
	);
	
loadA(10 downto 1) <= A(10 downto 1);
loadB(10 downto 1) <= B(10 downto 1);
loadA(0) <= '1' when (nullA = '1' and expnull = '1') else A(0);
loadB(0) <= '1' when (nullB = '1' and expnull = '1') else B(0);	


	
nullA <= '1' when A = "00000000000" else '0';
nullB <= '1' when B = "00000000000" else '0';

expnull <= nullA xor nullB; -- only want to preload a 1 to A or B if either or is null, if both don't do anything

process(absdif, expnull) begin
	if(absdif > "00000111111") then
		if (expnull = '1') then
			SHIFT <= "111110";
		else
			SHIFT <= "111111";
		end if;
	else
			SHIFT <= absdif(5 downto 0);
	end if;

end process;

A_hidden <= not nullA;
B_hidden <= not nullB;


end Behavioral;




