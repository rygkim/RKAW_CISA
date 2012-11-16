----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:31 11/05/2012 
-- Design Name: 
-- Module Name:    zlc_counter - structural
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



entity zlc_counter is
    Port ( Sum2 : in STD_LOGIC_VECTOR (54 downto 0);
			Ahidden : in STD_LOGIC;
			Bhidden : in STD_LOGIC;
			Count : out STD_LOGIC_VECTOR(6 downto 0));
end zlc_counter;

architecture Structural of zlc_counter is

signal enable : STD_LOGIC;
signal inverted : STD_LOGIC_VECTOR(63 downto 0);
signal zlc_l2 : STD_LOGIC_VECTOR(63 downto 0);
signal zlc_l3 : STD_LOGIC_VECTOR(47 downto 0);
signal zlc_l4 : STD_LOGIC_VECTOR(31 downto 0);
signal zlc_l5 : STD_LOGIC_VECTOR(19 downto 0);
signal zlc_l6 : STD_LOGIC_VECTOR(11 downto 0);
signal zlc_l7 : STD_LOGIC_VECTOR(6 downto 0);

begin

enable <= Sum2(53) or Ahidden or Bhidden;
inverted <= not (Sum2 & "000000000");

L2: for i in 0 to 31 generate
	zlc_l2(2*i) <= inverted(2*i+1) and (not inverted(2*i)); --Verified
	zlc_l2(2*i+1) <= inverted(2*i+1) and inverted(2*i);     --Verified
end generate L2;

L3: for i in 0 to 15 generate
	zlc_l3(3*i) <= zlc_l2(4*i+2) or (zlc_l2(4*i+3) and zlc_l2(4*i)); --Verified
	zlc_l3(3*i+1) <= zlc_l2(4*i+3) and (not zlc_l2(4*i+1));			  --Verified
	zlc_l3(3*i+2) <= zlc_l2(4*i+3) and zlc_l2(4*i+1);					  --Verified
end generate L3;

L4: for i in 0 to 7 generate
	zlc_l4(4*i) <= zlc_l3(6*i+3) or(zlc_l3(6*i+5) and zlc_l3(6*i));		--Verified
	zlc_l4(4*i+1) <= zlc_l3(6*i+4) or (zlc_l3(6*i+5) and zlc_l3(6*i+1)); --Verified
	zlc_l4(4*i+2) <= zlc_l3(6*i+5) and (not zlc_l3(6*i+2));					--Verified
	zlc_l4(4*i+3) <= zlc_l3(6*i+5) and zlc_l3(6*i+2);							--Verified
end generate L4;

L5: for i in 0 to 3 generate
	zlc_l5(5*i) <= zlc_l4(8*i+4) or(zlc_l4(8*i+7) and zlc_l4(8*i));		--Verified
	zlc_l5(5*i+1) <= zlc_l4(8*i+5) or (zlc_l4(8*i+7) and zlc_l4(8*i+1));	--Verified
	zlc_l5(5*i+2) <= zlc_l4(8*i+6) or (zlc_l4(8*i+7) and zlc_l4(8*i+2)); --Verified
	zlc_l5(5*i+3) <= zlc_l4(8*i+7) and (not zlc_l4(8*i+3));					--Verified
	zlc_l5(5*i+4) <= zlc_l4(8*i+7) and zlc_l4(8*i+3);							--Verified
end generate L5;

L6: for i in 0 to 1 generate
	zlc_l6(6*i) <= zlc_l5(10*i+5) or (zlc_l5(10*i+9) and zlc_l5(10*i));		--Verified
	zlc_l6(6*i+1) <= zlc_l5(10*i+6) or (zlc_l5(10*i+9) and zlc_l5(10*i+1));
	zlc_l6(6*i+2) <= zlc_l5(10*i+7) or (zlc_l5(10*i+9) and zlc_l5(10*i+2));
	zlc_l6(6*i+3) <= zlc_l5(10*i+8) or (zlc_l5(10*i+9) and zlc_l5(10*i+3));
	zlc_l6(6*i+4) <= zlc_l5(10*i+9) and (not zlc_l5(10*i+4));
	zlc_l6(6*i+5) <= zlc_l5(10*i+9) and zlc_l5(10*i+4);
end generate L6;

zlc_l7(0) <= zlc_l6(6) or (zlc_l6(11) and zlc_l6(0));
zlc_l7(1) <= zlc_l6(7) or (zlc_l6(11) and zlc_l6(1));
zlc_l7(2) <= zlc_l6(8) or (zlc_l6(11) and zlc_l6(2));
zlc_l7(3) <= zlc_l6(9) or (zlc_l6(11) and zlc_l6(3));
zlc_l7(4) <= zlc_l6(10) or (zlc_l6(11) and zlc_l6(4));
zlc_l7(5) <= zlc_l6(11) and (not zlc_l6(5));
zlc_l7(6) <= zlc_l6(11) and zlc_l6(5);

with enable select
	count <= zlc_l7 when '1', "0000001" when '0';

end Structural;
