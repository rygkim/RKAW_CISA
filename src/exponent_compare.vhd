----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:15:00 11/04/2012 
-- Design Name: 
-- Module Name:    exponent_compare - Behavioral 
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



entity exponent_compare is
    Port ( A : in  STD_LOGIC_VECTOR (10 downto 0);
           B : in  STD_LOGIC_VECTOR (10 downto 0);
           B_GT_A : out	STD_LOGIC;
			  A_GT_B : out	STD_LOGIC;
			  A_EQ_B	: out	STD_LOGIC);
end exponent_compare;

architecture Structural of exponent_compare is

signal bNa : std_logic_vector(10 downto 0);
signal aNb : std_logic_vector(10 downto 0);
signal beqa : std_logic_vector(10 downto 0);
signal compA : std_logic_vector(10 downto 0);
signal compB : std_logic_vector(10 downto 0);
signal agtb, bgta : std_logic;
begin

--aNb <= Aexp_comp and not Bexp_comp;
--bNa <= Bexp_comp and not Aexp_comp;

beqa <= B xnor A;

A_EQ_B <= not(agtb or bgta);

compA(10) <= A(10) and not B(10);
compA(9)  <= beqa(10) and A(9) and not B(9);
compA(8)  <= beqa(10) and beqa(9) and A(8) and not B(8);
compA(7)  <= beqa(10) and beqa(9) and beqa(8) and A(7) and not B(7);
compA(6)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and A(6) and not B(6);
compA(5)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and A(5) and not B(5);
compA(4)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and A(4) and not B(4);
compA(3)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and A(3) and not B(3);
compA(2)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and A(2) and not B(2);
compA(1)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and beqa(2) and A(1) and not B(1);
compA(0)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and beqa(2) and beqa(1) and A(0) and not B(0);

agtb <= compA(10) or compA(9) or compA(8) or compA(7) or compA(6) or compA(5) or compA(4) or compA(3) or compA(2) or compA(1) or compA(0);

compB(10) <= B(10) and not A(10);
compB(9)  <= beqa(10) and B(9) and not A(9);
compB(8)  <= beqa(10) and beqa(9) and B(8) and not A(8);
compB(7)  <= beqa(10) and beqa(9) and beqa(8) and B(7) and not A(7);
compB(6)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and B(6) and not A(6);
compB(5)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and B(5) and not A(5);
compB(4)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and B(4) and not A(4);
compB(3)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and B(3) and not A(3);
compB(2)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and B(2) and not A(2);
compB(1)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and beqa(2) and B(1) and not A(1);
compB(0)  <= beqa(10) and beqa(9) and beqa(8) and beqa(7) and beqa(6) and beqa(5) and beqa(4) and beqa(3) and beqa(2) and beqa(1) and B(0) and not A(0);

bgta <= compB(10) or compB(9) or compB(8) or compB(7) or compB(6) or compB(5) or compB(4) or compB(3) or compB(2) or compB(1) or compB(0);

A_GT_B <= agtb;
B_GT_A <= bgta;

	
end Structural;

