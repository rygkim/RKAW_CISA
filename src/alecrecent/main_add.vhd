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
    Port ( Smaller : in STD_LOGIC_VECTOR(55 downto 0);
			Larger : in STD_LOGIC_VECTOR(52 downto 0);
			Cin    : in STD_LOGIC;
			Cout   : out STD_LOGIC;
			Sum    : out STD_LOGIC_VECTOR(55 downto 0));
end main_add;


architecture Structural of main_add is

procedure A1S
	(	signal temp_sum : in STD_LOGIC_VECTOR(3 downto 0);
		signal cin		: in STD_LOGIC;
		signal sum		: out STD_LOGIC_VECTOR(3 downto 0)
	 ) is
begin
	sum(0) <= cin xor temp_sum(0);
	sum(1) <= (cin and temp_sum(0)) xor temp_sum(1);
	sum(2) <= (cin and temp_sum(0) and temp_sum(1)) xor temp_sum(2);
	sum(3) <= (cin and temp_sum(0) and temp_sum(1) and temp_sum(2)) xor temp_sum(3);
end A1S;

signal G : STD_LOGIC_VECTOR(55 downto 0);
signal P : STD_LOGIC_VECTOR(55 downto 0);
signal GG : STD_LOGIC_VECTOR(13 downto 0);
signal PG : STD_LOGIC_VECTOR(13 downto 0);
signal temp_larger : STD_LOGIC_VECTOR(55 downto 0);
signal temp_sum : STD_LOGIC_VECTOR(55 downto 0);
signal carry : STD_LOGIC_VECTOR(13 downto 0);

signal i : integer := 0;
begin

temp_larger <= Larger & "000";
G <= Smaller and temp_larger;
P <= Smaller or temp_larger;

temp_sum <= Smaller xor temp_larger;
carry(0) <= Cin;

CARRY_CALC: for i in 1 to 13 generate
	carry(i) <= GG(i-1) or (PG(i-1) and carry(i-1));
end generate CARRY_CALC;

DO_SUM: for i in 0 to 13 generate
	A1S(temp_sum((4*i+3) downto (4*i)), carry(i), Sum((4*i+3) downto (4*i)));
end generate DO_SUM;

GROUP_CLA: for i in 0 to 13 generate
	GG(i) <= G(4*i+3) or (G(4*i+2) and P(4*i+3)) or (G(4*i+1) and P(4*i+3) and P(4*i+2)) or (G(4*i) and P(4*i+3) and P(4*i+2) and P(4*i+1));
	PG(i) <= P(4*i) and  P(4*i+1) and P(4*i+2) and P(4*i+3);
end generate GROUP_CLA;

Cout <= G(55) or (P(55) and carry(13));

end Structural;