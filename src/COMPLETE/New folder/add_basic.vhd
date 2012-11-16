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
	
	COMPONENT complementer
	PORT(
		DATA : IN std_logic_vector(55 downto 0);
		EN : IN std_logic;          
		DOUT : OUT std_logic_vector(55 downto 0);
		COUT : OUT std_logic
		);
	END COMPONENT;
	

	COMPONENT sig_compare_switch
	PORT(
		A : IN std_logic_vector(63 downto 0);
		B : IN std_logic_vector(63 downto 0);          
		Large : OUT std_logic_vector(52 downto 0);
		Small : OUT std_logic_vector(52 downto 0);
		ExpLarge : OUT std_logic_vector(10 downto 0);
		ExpSmall : OUT std_logic_vector(10 downto 0);
		Swap : OUT std_logic
		);
	END COMPONENT;


	COMPONENT sig_right_shift
	PORT(
		small_hidden : IN std_logic;
		small_data : IN std_logic_vector(51 downto 0);
		shift_amt : IN std_logic_vector(5 downto 0);          
		stickyout : OUT std_logic;
		shifted_data : OUT std_logic_vector(54 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT main_add
	PORT(
		Smaller : IN std_logic_vector(55 downto 0);
		Larger : IN std_logic_vector(52 downto 0);
		Cin : IN std_logic;          
		Cout : OUT std_logic;
		Sum : OUT std_logic_vector(55 downto 0)
		);
	END COMPONENT;

	COMPONENT zlc_counter
	PORT(
		Sum2 : IN std_logic_vector(54 downto 0);
		Ahidden : IN std_logic;
		Bhidden : IN std_logic;          
		Count : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	COMPONENT sig_left_shift
	PORT(
		shift_in : IN std_logic_vector(54 downto 0);
		ZLC_shift : IN std_logic_vector(6 downto 0);          
		shift_out : OUT std_logic_vector(52 downto 0)
		);
	END COMPONENT;

	COMPONENT exponent_adder
	PORT(
		exp_in : IN std_logic_vector(10 downto 0);
		zlc_in : IN std_logic_vector(6 downto 0);          
		exp_out : OUT std_logic_vector(10 downto 0);
		null_exp : OUT std_logic
		);
	END COMPONENT;

signal Aexp : std_logic_vector(10 downto 0);
signal Bexp : std_logic_vector(10 downto 0);
--signal Aman : std_logic_vector(51 downto 0);
--signal Bman : std_logic_vector(51 downto 0);
signal Asign : std_logic;
signal Bsign : std_logic;
signal s_AGTB : std_logic;
--signal s_BGTA : std_logic;
--signal s_AEQB : std_logic;
signal s_Ah	  : std_logic;
signal s_Bh	  : std_logic;
signal s_exp  : std_logic_vector(10 downto 0);
signal s_shift : std_logic_vector(5 downto 0);
signal s_large : std_logic_vector(52 downto 0);
signal s_small : std_logic_vector(52 downto 0);
--signal s_swap : std_logic;
signal comp_en : std_logic;
signal s_shifted : std_logic_vector(54 downto 0);
signal sig_add_cin : std_logic;
signal s_comped : std_logic_vector(55 downto 0);
signal s_explarge : std_logic_vector(10 downto 0);
signal s_expsmall : std_logic_vector(10 downto 0);
signal s_stickybit : std_logic;
signal combine : std_logic_vector(55 downto 0);
signal main_add_cout :std_logic;
signal main_add_sum : std_logic_vector(55 downto 0);
signal sum_bus : std_logic_vector(54 downto 0);
signal s_zlc_count : std_logic_vector(6 downto 0);
signal s_leftshift : std_logic_vector(52 downto 0);
signal s_nullsel : std_logic;
begin

Asign <= Aval(63);
Bsign <= Bval(63);

Aexp <= Aval(62 downto 52);
Bexp <= Bval(62 downto 52);

--Aman <= Aval(51 downto 0);
--Bman <= Bval(51 downto 0);
--Execute Comparison of Aexp and Bexp


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
		A => Aval,
		B => Bval,
		Large => s_large,
		Small => s_small,
		ExpLarge => s_explarge,
		ExpSmall => s_expsmall,
		Swap => s_AGTB
	);
	
	Inst_sig_right_shift: sig_right_shift PORT MAP(
		small_hidden => s_small(52),
		small_data => s_small(51 downto 0),
		shift_amt => s_shift,
		stickyout => s_stickybit,
		shifted_data => s_shifted
	);
	
	combine <= (s_shifted & s_stickybit);
	Inst_complementer: complementer PORT MAP(
		DATA => combine,
		EN => comp_en,
		DOUT => s_comped,
		COUT => sig_add_cin
	);
	
	Inst_main_add: main_add PORT MAP(
		Smaller => s_comped,
		Larger => s_large,
		Cin => sig_add_cin,
		Cout => main_add_cout,
		Sum => main_add_sum
	);
	
sum_bus(54) <= comp_en xor main_add_cout;
sum_bus(53 downto 0) <= main_add_sum(55 downto 2);

	Inst_zlc_counter: zlc_counter PORT MAP(
		Sum2 => sum_bus,
		Ahidden => s_Ah,
		Bhidden => s_Bh,
		Count => s_zlc_count
	);
	
	
	Inst_sig_left_shift: sig_left_shift PORT MAP(
		shift_in => sum_bus,
		ZLC_shift => s_zlc_count,
		shift_out => s_leftshift
	);
	
	Inst_exponent_adder: exponent_adder PORT MAP(
		exp_in => s_exp,
		zlc_in => s_zlc_count,
		exp_out => Qval(62 downto 52),
		null_exp => s_nullsel
	);
	
--Rectify exponents so they are equal, calculate shift for mantissa (can shift by maxiumum of 63 bits ONLY!)

Qval(51 downto 0) <= s_leftshift(51 downto 0) when s_nullsel = '0' else s_leftshift(52 downto 1);

Qval(63) <= Asign when s_AGTB = '1' else Bsign;
comp_en <= Asign xor Bsign;

end Behavioral;

