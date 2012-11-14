----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:36:31 11/05/2012 
-- Design Name: 
-- Module Name:    complementer - Behavioral 
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


entity complementer is
    Port ( DATA : in  STD_LOGIC_VECTOR (54 downto 0);
           EN : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (54 downto 0);
           COUT : out  STD_LOGIC);
end complementer;

architecture Behavioral of complementer is

begin

--DOUT <= not(DATA) when EN = '1' else DATA; --Check to see if MUX based is faster in Synopsys...
DOUT_XOR : for i in 0 to 54 generate
  DOUT(i) <= DATA(i) xor EN;  
end generate DOUT_XOR;
COUT <= EN;


end Behavioral;

