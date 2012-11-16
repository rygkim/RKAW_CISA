----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:19:55 11/16/2012 
-- Design Name: 
-- Module Name:    sig_left_shift - Behavioral 
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


entity sig_left_shift is
    Port ( shift_in : in  STD_LOGIC_VECTOR (53 downto 0);
           ZLC_shift : in  STD_LOGIC_VECTOR (6 downto 0);
           shift_out : out  STD_LOGIC_VECTOR (52 downto 0));
end sig_left_shift;

architecture Behavioral of sig_left_shift is

signal L1,L2,L3,L4,L5,L6,L7,L8 : STD_LOGIC_VECTOR(55 downto 0);


begin

L1 <= "00" & shift_in; --Do right shift by 2 immediately to buffer 2 LSB
--Then all following shifts may be left shifts to recover from right shift
--This performs a total left shift of ZLC_shift - 2.
L2 <= L1 when ZLC_shift(0) = '0' else (L1(54 downto 0) & '0');
L3 <= L2 when ZLC_shift(1) = '0' else (L2(53 downto 0) & "00");
L4 <= L3 when ZLC_shift(2) = '0' else (L3(51 downto 0) & "0000");
L5 <= L4 when ZLC_shift(3) = '0' else (L4(47 downto 0) & "00000000");
L6 <= L5 when ZLC_shift(4) = '0' else (L5(39 downto 0) & "0000000000000000");
L7 <= L6 when ZLC_shift(5) = '0' else (L5(23 downto 0) & "00000000000000000000000000000000");
L8 <= L7 when ZLC_shift(6) = '0' else (others => '0');

shift_out <= L8(54 downto 2); -- Drop MSB since its implicit in the final result
										-- Drop 2 LSB since they were buffers for initial right shift.
end Behavioral;

