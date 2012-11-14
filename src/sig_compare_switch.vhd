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
    Port ( Asig : in  STD_LOGIC_VECTOR (51 downto 0);
           Bsig : in  STD_LOGIC_VECTOR (51 downto 0);
           Ahidden : in  STD_LOGIC;
           Bhidden : in  STD_LOGIC;
           Large : out  STD_LOGIC_VECTOR (52 downto 0);
           Small : out  STD_LOGIC_VECTOR (51 downto 0);
           Swap : out  STD_LOGIC);
end sig_compare_switch;

architecture Behavioral of sig_compare_switch is

signal alarge : std_logic;

begin

process(Ahidden, Bhidden, Asig, Bsig)
begin
	if(Ahidden = '1' and Bhidden = '0') then
		alarge <= '1';
	elsif(Ahidden = '0' and Bhidden = '1') then
		alarge <= '0';
	else
		if(Asig > Bsig) then --Need to optimize this obviously...
			alarge <= '1';
		else
			alarge <= '0';
		end if;
	end if;
end process;

Large(52) <= Ahidden when alarge = '1' else Bhidden;
Large(51 downto 0) <= Asig when alarge = '1' else Bsig;

Small <= Bsig when alarge <= '1' else Asig;

Swap <= alarge;


end Behavioral;

