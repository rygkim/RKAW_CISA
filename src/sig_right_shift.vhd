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
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sig_right_shift is
    Port ( small_hidden : in  STD_LOGIC;
           small_data : in  STD_LOGIC_VECTOR (51 downto 0);
           shift_amt : in  STD_LOGIC_VECTOR (5 downto 0);
    		  stickyout : out STD_LOGIC;
           shifted_data : out  STD_LOGIC_VECTOR (54 downto 0));
end sig_right_shift;

architecture structural of sig_right_shift is

signal sticky : std_logic;
signal r0, r1, r2, r3, r4, r5, r6 : std_logic_vector(54 downto 0);
signal init : std_logic_vector(52 downto 0);

begin

init <= small_hidden & small_data;

r6 <= init & "00";

with shift_amt(5) select r5 <= r6 when '0', "00000000000000000000000000000000" & r5(54 downto 32) when others;
with shift_amt(4) select r4 <= r5 when '0', "0000000000000000" & r5(54 downto 16) when others;
with shift_amt(3) select r3 <= r4 when '0', "00000000" & r4(54 downto 8) when others;
with shift_amt(2) select r2 <= r3 when '0', "0000" & r3(54 downto 4) when others;  
with shift_amt(1) select r1 <= r2 when '0', "00" & r2(54 downto 2) when others;
with shift_amt(0) select r0 <= r1 when '0', "0" & r1(54 downto 1) when others;

shifted_data <= r0;

sticky <= 

end structural;

