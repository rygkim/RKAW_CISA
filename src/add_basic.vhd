----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:09:05 11/04/2012 
-- Design Name: 
-- Module Name:    add_basic - Behavioral 
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


entity add_basic is
    Port ( Aval : in  STD_LOGIC_VECTOR (63 downto 0);
           Bval : in  STD_LOGIC_VECTOR (63 downto 0);
           Qval : out  STD_LOGIC_VECTOR (63 downto 0));
end add_basic;

architecture Behavioral of add_basic is

	COMPONENT exponent_compare
	PORT(
		A : IN std_logic_vector(10 downto 0);
		B : IN std_logic_vector(10 downto 0);          
		B_GT_A : OUT std_logic;
		A_GT_B : OUT std_logic;
		A_EQ_B : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT exp_rect_shift
	PORT(
		A : IN std_logic_vector(10 downto 0);
		B : IN std_logic_vector(10 downto 0);
		A_GT_B : IN std_logic;          
		A_hidden : OUT std_logic;
		B_hidden : OUT std_logic;
		EXP : OUT std_logic_vector(10 downto 0);
		SHIFT : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT sig_compare_switch
	PORT(
		Asig : IN std_logic_vector(51 downto 0);
		Bsig : IN std_logic_vector(51 downto 0);
		Ahidden : IN std_logic;
		Bhidden : IN std_logic;          
		Large : OUT std_logic_vector(52 downto 0);
		Small : OUT std_logic_vector(51 downto 0);
		Swap : OUT std_logic
		);
	END COMPONENT;

	COMPONENT complementer
	PORT(
		DATA : IN std_logic_vector(54 downto 0);
		EN : IN std_logic;          
		DOUT : OUT std_logic_vector(54 downto 0);
		COUT : OUT std_logic
		);
	END COMPONENT;





signal Aexp : std_logic_vector(10 downto 0);
signal Bexp : std_logic_vector(10 downto 0);
signal Aman : std_logic_vector(51 downto 0);
signal Bman : std_logic_vector(51 downto 0);
signal Asign : std_logic;
signal Bsign : std_logic;
signal s_AGTB : std_logic;
signal s_BGTA : std_logic;
signal s_AEQB : std_logic;
signal s_Ah	  : std_logic;
signal s_Bh	  : std_logic;
signal s_exp  : std_logic_vector(10 downto 0);
signal s_shift : std_logic_vector(5 downto 0);
signal s_large : std_logic_vector(52 downto 0);
signal s_small : std_logic_vector(51 downto 0);
signal s_swap : std_logic;
signal comp_en : std_logic;
signal s_shifted : std_logic_vector(54 downto 0);
signal sig_add_cin : std_logic;
signal s_comped : std_logic_vector(54 downto 0);

begin

Asign <= Aval(63);
Bsign <= Bval(63);

Aexp <= Aval(62 downto 52);
Bexp <= Bval(62 downto 52);

Aman <= Aval(51 downto 0);
Bman <= Bval(51 downto 0);
--Execute Comparison of Aexp and Bexp

	Inst_exponent_compare: exponent_compare PORT MAP(
		A => Aexp,
		B => Bexp,
		B_GT_A => s_BGTA,
		A_GT_B => s_AGTB,
		A_EQ_B => s_AEQB
	);
	

	Inst_exp_rect_shift: exp_rect_shift PORT MAP(
		A => Aexp,
		B => Bexp,
		A_GT_B => s_AGTB,
		A_hidden => s_Ah,
		B_hidden => s_Bh,
		EXP => s_exp,
		SHIFT => s_shift
	);
	
	
	Inst_sig_compare_switch: sig_compare_switch PORT MAP(
		Asig => Aman,
		Bsig => Bman,
		Ahidden => s_Ah,
		Bhidden => s_Bh,
		Large => s_large,
		Small => s_small,
		Swap => s_swap
	);
	
	Inst_complementer: complementer PORT MAP(
		DATA => s_shifted,
		EN => comp_en,
		DOUT => s_comped,
		COUT => sig_add_cin
	);
	
--Rectify exponents so they are equal, calculate shift for mantissa (can shift by maxiumum of 63 bits ONLY!)


Qval(63) <= Asign when s_swap = '1' else Bsign;
comp_en <= Asign xor Bsign;

end Behavioral;

