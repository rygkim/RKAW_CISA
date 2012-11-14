----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:55:36 11/05/2012 
-- Design Name: 
-- Module Name:    sig_right_shift - Behavioral 
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
-- DOES THIS EDIT COMMIT?
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sig_right_shift is
    Port ( small_hidden : in  STD_LOGIC;
           small_data : in  STD_LOGIC_VECTOR (51 downto 0);
           shift_amt : in  STD_LOGIC_VECTOR (5 downto 0);
           shifted_data : out  STD_LOGIC_VECTOR (54 downto 0));
end sig_right_shift;

architecture Behavioral of sig_right_shift is

begin


end Behavioral;

