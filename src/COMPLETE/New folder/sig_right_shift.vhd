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
signal or32 : std_logic;
signal or16 : std_logic;
signal or8  : std_logic;
signal or4  : std_logic;
signal or2  : std_logic;

begin

init <= small_hidden & small_data;
--init <= small_data & '0';
r6 <= init & "00";

with shift_amt(5) select r5 <= r6 when '0', "00000000000000000000000000000000" & r6(54 downto 32) when others;
with shift_amt(4) select r4 <= r5 when '0', "0000000000000000" & r5(54 downto 16) when others;
with shift_amt(3) select r3 <= r4 when '0', "00000000" & r4(54 downto 8) when others;
with shift_amt(2) select r2 <= r3 when '0', "0000" & r3(54 downto 4) when others;  
with shift_amt(1) select r1 <= r2 when '0', "00" & r2(54 downto 2) when others;
with shift_amt(0) select r0 <= r1 when '0', "0" & r1(54 downto 1) when others;

shifted_data <= r0;

or32 <= r6(31) or r6(30) or r6(29) or r6(28) or r6(27) or r6(26) or r6(25) or r6(24)
	  or r6(23) or r6(22) or r6(21) or r6(20) or r6(19) or r6(18) or r6(17) or r6(16)
     or r6(15) or r6(14) or r6(13) or r6(12) or r6(11) or r6(10) or r6(9)  or r6(8)
     or r6(7)  or r6(6)  or r6(5)  or r6(4)  or r6(3)  or r6(2)  or r6(1)  or r6(0);
	  
or16 <= r5(15) or r5(14) or r5(13) or r5(12) or r5(11) or r5(10) or r5(9)  or r5(8) 
     or r5(7)  or r5(6)  or r5(5)  or r5(4)  or r5(3)  or r5(2)  or r5(1)  or r5(0);
	  
or8  <= r4(7)  or r4(6)  or r4(5)  or r4(4)  or r4(3)  or r4(2)  or r4(1)  or r4(0);

or4  <= r3(3)  or r3(2)  or r3(1)  or r3(0);

or2  <= r2(1)  or r2(0);

sticky <= (or32 and shift_amt(5)) or (or16 and shift_amt(4)) or (or8 and shift_amt(3)) or
			 (or4 and shift_amt(2)) or (or2 and shift_amt(1)) or (r1(0) and shift_amt(0));
           
stickyout <= sticky;


end structural;

