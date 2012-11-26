----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    mant_mult - structural
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

entity mant_mult is
    Port ( A : in STD_LOGIC_VECTOR (52 downto 0);
		   B : in STD_LOGIC_VECTOR (52 downto 0);
			A_IMP : in STD_LOGIC;
			B_IMP : in STD_LOGIC;
		   Y : out STD_LOGIC_VECTOR(52 downto 0)
		);
end mant_mult;

architecture Structural of mant_mult is

type partial is array(0 downto 17) of STD_LOGIC_VECTOR(60 downto 0);

signal multiplier : STD_LOGIC_VECTOR(54 downto 0);
signal multiplicand : STD_LOGIC_VECTOR(53 downto 0);
signal select_m : STD_LOGIC_VECTOR(17 downto 0);
signal select_2m : STD_LOGIC_VECTOR(17 downto 0);
signal select_3m : STD_LOGIC_VECTOR(17 downto 0);
signal select_4m : STD_LOGIC_VECTOR(17 downto 0);

signal i : integer;
signal j : integer;

signal P : STD_LOGIC_VECTOR(53 downto 1);
signal G : STD_LOGIC_VECTOR(53 downto 1);
signal carry : STD_LOGIC_VECTOR(54 downto 1);
signal M3 : STD_LOGIC_VECTOR(55 downto 0);
signal S : STD_LOGIC_VECTOR(17 downto 0);

signal partial_prod : partial;

begin

multiplier <= A_IMP & A & '0';
multiplicand <= B_IMP & B;

BOOTH_DECODER : for i in 0 to 17 generate
	select_m(i) <= not ((multiplier(3*i) xnor multiplier(3*i+1)) or (multiplier(3*i+2) xor multiplier(3*i+3))); 
	select_2m(i) <= not ((multiplier(3*i) xor multiplier(3*i+1)) or (multiplier(3*i+1) xnor multiplier(3*i+2)));
	select_3m(i) <= not ((multiplier(3*i) xnor multiplier(3*i+1)) or (multiplier(3*i+2) xnor multiplier(3*i+3)));
	select_4m(i) <= not ((multiplier(3*i) xor multiplier(3*i+1)) or (multiplier(3*i+1) xor multiplier(3*i+2)) or (multiplier(3*i+2) xnor multiplier(3*i+3)));
	S(i) <= multiplier(3*i+3);
end generate BOOTH_DECODER;

M3(0) <= multiplicand(0);

--SPEED THIS UP
CALC_M3 : for i in 1 to 53 generate
	G(i) <= multiplicand(i) and multiplicand(i-1);
	P(i) <= multiplicand(i) or multiplicand(i-1);
	FIRST : if i=1 generate
		carry(i) <= G(i);
		M3(i) <= multiplicand(i) xor multiplicand(i-1);
	end generate FIRST_CARRY;
	REST : if i>1 generate
		carry(i) <= G(i) or (P(i) and carry(i-1));
		M3(i) <= (multiplicand(i) xor multiplicand(i-1) xor carry(i-1));
	end generate REST_CARRY;
end generate CALC_M3;

M3(54) <= (multiplicand(53) xor carry(53));
carry(54) <= (multiplicand(53) and carry(53));
M3(55) <= carry(54);

CALC_PARTIAL : for i in 0 to 17 generate
	DETERM_PARTIAL : for j in 1 to 56 generate
		NUM1 : if j=1 generate
			partial_prod(i)(j) <= (((multiplicand(j-1) and select_m(i)) or (M3(j-1) and select_3m(i)) or ('0')) xor S(i));
		end generate NUM1;
		NUM2 : if j=2 generate
			partial_prod(i)(j) <= (((multiplicand(j-1) and select_m(i)) or (M3(j-1) and select_3m(i)) or (multiplicand(j-2) and select_2m(i)) or ('0')) xor S(i));
		end generate NUM2;
		NUM55 : if j=55 generate
			partial_prod(i)(j) <= ((('0') or (M3(j-1) and select_3m(i)) or (multiplicand(j-2) and select_2m(i)) or (multiplicand(j-3) and select_4m(i))) xor S(i));
		end generate NUM55;
		NUM56 : if j=56 generate
			partial_prod(i)(j) <= ((('0') or (M3(j-1) and select_3m(i)) or (multiplicand(j-3) and select_4m(i))) xor S(i));
		end generate NUM56;
		OTHER : if (j>1 and j<55) generate
			partail_prod(i)(j) <= (((multiplicand(j-1) and select_m(i)) or (M3(j-1) and select_3m(i)) or (multiplicand(j-2) and select_2m(i)) or (multiplicand(j-3) and select_4m(i))) xor S(i));
		end generate OTHER;
	end generate DETERM_PARTIAL;
	FIRST_PARTIAL : if i=0 generate
		partial_prod(i)(0) <= S(i);
		partial_prod(i)(57) <= S(i);
		partial_prod(i)(58) <= S(i);
		partial_prod(i)(59) <= S(i);
		partial_prod(i)(60) <= not S(i);
	end generate FIRST_PARTIAL;
	LAST_PARTIAL : if i=17 generate
		partial_prod(i)(60 downto 57) <= "0000";
		partial_prod(i)(0) <= '0';
	end generate LAST_PARTIAL;
	OTHER_PARTIAL : if (i>0 and i<17) generate
		partial_prod(i)(60) <= '0';
		partial_prod(i)(59 downto 58) <= "11";
		partial_prod(i)(57) <= not S(i);
		partial_prod(i)(0) <= S(i);
	end generate OTHER_PARTIAL;
end generate CALC_PARTIAL;

end Structural;