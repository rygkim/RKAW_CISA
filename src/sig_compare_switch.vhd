----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    sig_compare_switch - Behavioral 
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



entity sig_compare_switch is
    Port ( A : in  STD_LOGIC_VECTOR (63 downto 0);
           B : in  STD_LOGIC_VECTOR (63 downto 0);
           Large : out  STD_LOGIC_VECTOR (52 downto 0);
           Small : out  STD_LOGIC_VECTOR (52 downto 0);
           Swap : out  STD_LOGIC);
end sig_compare_switch;

architecture Structural of sig_compare_switch is

signal equal : std_logic_vector(63 downto 0);
signal less : std_logic_vector(63 downto 0);
signal equal_l2 : std_logic_vector (7 downto 0);
signal less_l2 :std_logic_vector (7 downto 0);
signal equal_l3 : std_logic;
signal less_l3 : std_logic;

begin

equal <= 1 & (A(62 downto 0) xnor B(62 downto 0));
less <= 0 & ((not A(62 downto 0)) and B(62 downto 0));

L2: for i in 0 to 7 generate 
	equal_l2(i) <= and equal(((i*8)+7) downto i*8);
	with equal(((i*8)+7) downto i*8) select
		less_l2(i) <= 	less((i*8 + 7)) when "0-------",
						less((i*8 + 6)) when "10------",
						less((i*8 + 5)) when "110-----",
						less((i*8 + 4)) when "1110----",
						less((i*8 + 3)) when "11110---",
						less((i*8 + 2)) when "111110--",
						less((i*8 + 1)) when "1111110-",
						less((i*8)) when "11111110";
end generate L2;

equal_l3 <= and equal_l2;
with equal_l2 select
	less_l3 <= 	less_l2(7) when "0-------",
				less_l2(6) when "10------",
				less_l2(5) when "110-----",
				less_l2(4) when "1110----",
				less_l2(3) when "11110---",
				less_l2(2) when "111110--",
				less_l2(1) when "1111110-",
				less_l2(0) when "11111110";
				
Large <= A(52 downto 0) when less_l3 = '0' else
		 B(52 downto 0);
Small <= B(52 downto 0) when less_l3 = '0' else
		 A(52 downto 0);
Swap <= less_l3;

--process(Ahidden, Bhidden, Asig, Bsig)
--begin
--	if(Ahidden = '1' and Bhidden = '0') then
--		alarge <= '1';
--	elsif(Ahidden = '0' and Bhidden = '1') then
--		alarge <= '0';
--	else
--		if(Asig > Bsig) then --Need to optimize this obviously...
--			alarge <= '1';
--		else
--			alarge <= '0';
--		end if;
--	end if;
--end process;

--Large(52) <= Ahidden when alarge = '1' else Bhidden;
--Large(51 downto 0) <= Asig when alarge = '1' else Bsig;

--Small <= Bsig when alarge <= '1' else Asig;

--Swap <= alarge;


end Structural;

