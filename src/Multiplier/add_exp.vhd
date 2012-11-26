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

entity add_exp is
    Port ( A_EXP : in STD_LOGIC_VECTOR (10 downto 0);
		   B_EXP : in STD_LOGIC_VECTOR (10 downto 0);
		   OUT_EXP : out STD_LOGIC_VECTOR(10 downto 0)
		);
end add_exp;

architecture Structural of add_exp is

component adder3 port(
			A : in STD_LOGIC;
			B : in STD_LOGIC;
			C : in STD_LOGIC;
			SUM : out STD_LOGIC;
			CARRY : out STD_LOGIC
		);
end component;

constant offset : STD_LOGIC_VECTOR (11 downto 0) := "110000000001";
signal carry_lvl1 : STD_LOGIC_VECTOR (11 downto 0);
signal sum : STD_LOGIC_VECTOR (11 downto 0);
signal P : STD_LOGIC_VECTOR(11 downto 1);
signal G : STD_LOGIC_VECTOR(11 downto 1);
signal PG : STD_LOGIC;
signal GG : STD_LOGIC;
signal carry_lvl2 : STD_LOGIC_VECTOR(11 downto 1);
signal i : integer := 0;

begin

P <= sum(11 downto 1) or carry_lvl1(10 downto 0);
G <= sum(11 downto 1) and carry_lvl1(10 downto 0);
PG <= and_reduce(P(5 downto 1));
GG <= G(5) or (G(4) and P(5)) or (G(3) and and_reduce(P(5 downto 4))) or (G(2) and and_reduce(P(5 downto 3))) or (G(1) and and_reduce(P(5 downto 2)));

L1_SUM : for i in 0 to 11 generate
	LAST_BIT : if i=11 generate
		L1_ADD3_LAST: adder3 port map('0', '0', offset(i), sum(i), carry_lvl1(i));
	end generate LAST_BIT;
	REST : if i/=11 generate
		L1_ADD3: adder3 port map(A_EXP(i), B_EXP(i), offset(i), sum(i), carry_lvl1(i));
	end generate REST;
end generate L1_SUM;

L2_CARRY : for i in 1 to 5 generate
	FIRST_BIT : if i=1 generate
		carry_lvl2(i) <= carry_lvl1(0);
		carry_lvl2(i+5) <= G(i+4) or(P(i+4) and (GG or (PG and carry_lvl1(0))));
	end generate FIRST_BIT;
	UPPER_BIT : if i>1 generate
		carry_lvl2(i) <= G(i-1) or (P(i-1) and carry_lvl2(i-1));
		carry_lvl2(i+5) <= G(i+4) or (P(i+4) and carry_lvl2(i+4));
	end generate UPPER_BIT;
end generate L2_CARRY;

carry_lvl2(11) <= G(11) or (P(11) and carry_lvl2(10));

OUT_EXP <= ((carry_lvl2(10 downto 1) & '0') xor sum(10 downto 0)) when carry_lvl2(11) = '1' else
				"00000000000";

end Structural;