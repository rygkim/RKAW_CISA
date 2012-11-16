--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:54:25 11/14/2012
-- Design Name:   
-- Module Name:   C:/Users/Alec/Documents/EE434/MACFPU_Add/tb_shifter.vhd
-- Project Name:  MACFPU_Add
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sig_right_shift
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_shifter IS
END tb_shifter;
 
ARCHITECTURE behavior OF tb_shifter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sig_right_shift
    PORT(
         small_hidden : IN  std_logic;
         small_data : IN  std_logic_vector(51 downto 0);
         shift_amt : IN  std_logic_vector(5 downto 0);
         stickyout : OUT  std_logic;
         shifted_data : OUT  std_logic_vector(54 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal small_hidden : std_logic := '0';
   signal small_data : std_logic_vector(51 downto 0) := (others => '0');
   signal shift_amt : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal stickyout : std_logic;
   signal shifted_data : std_logic_vector(54 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sig_right_shift PORT MAP (
          small_hidden => small_hidden,
          small_data => small_data,
          shift_amt => shift_amt,
          stickyout => stickyout,
          shifted_data => shifted_data
        );



   -- Stimulus process
   stim_proc: process
   begin		
	
		small_data <= "1011011001101011101001011001110011001110010101001001";
      -- hold reset state for 100 ns.
		small_hidden <= '1';
		shift_amt <= "000000";
      wait for 100 ns;	
		shift_amt <= "000001";
		wait for 100 ns;	
		shift_amt <= "000010";
      wait for 100 ns;	
		shift_amt <= "000011";
		wait for 100 ns;	
		shift_amt <= "000100";
		wait for 100 ns;	
		shift_amt <= "000101";
		wait for 100 ns;	
		shift_amt <= "000110";
		wait for 100 ns;	
		shift_amt <= "000111";
		wait for 100 ns;	
		shift_amt <= "001000";
		wait for 100 ns;	
		shift_amt <= "001001";
		wait for 100 ns;	
		shift_amt <= "001010";
		wait for 100 ns;	
		shift_amt <= "001011";
		wait for 100 ns;	
		shift_amt <= "001100";
		wait for 100 ns;	
		shift_amt <= "001101";
		wait for 100 ns;	
		shift_amt <= "001110";
		wait for 100 ns;	
		shift_amt <= "001111";
		wait for 100 ns;	
		shift_amt <= "010000";
		wait for 100 ns;	
		shift_amt <= "010001";
		wait for 100 ns;	
		shift_amt <= "010010";
		wait for 100 ns;	
		shift_amt <= "010011";
		wait for 100 ns;	
		shift_amt <= "010100";
		wait for 100 ns;	
		shift_amt <= "010101";
		wait for 100 ns;	
		shift_amt <= "010110";
		wait for 100 ns;	
		shift_amt <= "010111";
		wait for 100 ns;	
		shift_amt <= "011000";
		wait for 100 ns;	
		shift_amt <= "011001";
		wait for 100 ns;	
		shift_amt <= "011010";
		wait for 100 ns;	
		shift_amt <= "011011";
		wait for 100 ns;	
		shift_amt <= "011100";
		wait for 100 ns;	
		shift_amt <= "011101";
		wait for 100 ns;	
		shift_amt <= "011110";
		wait for 100 ns;	
		shift_amt <= "011111";
		wait for 100 ns;
		shift_amt <= "100000";
      wait for 100 ns;	
		shift_amt <= "100001";
		wait for 100 ns;	
		shift_amt <= "100010";
      wait for 100 ns;	
		shift_amt <= "100011";
		wait for 100 ns;	
		shift_amt <= "100100";
		wait for 100 ns;	
		shift_amt <= "100101";
		wait for 100 ns;	
		shift_amt <= "100110";
		wait for 100 ns;	
		shift_amt <= "100111";
		wait for 100 ns;	
		shift_amt <= "101000";
		wait for 100 ns;	
		shift_amt <= "101001";
		wait for 100 ns;	
		shift_amt <= "101010";
		wait for 100 ns;	
		shift_amt <= "101011";
		wait for 100 ns;	
		shift_amt <= "101100";
		wait for 100 ns;	
		shift_amt <= "101101";
		wait for 100 ns;	
		shift_amt <= "101110";
		wait for 100 ns;	
		shift_amt <= "101111";
		wait for 100 ns;	
		shift_amt <= "110000";
		wait for 100 ns;	
		shift_amt <= "110001";
		wait for 100 ns;	
		shift_amt <= "110010";
		wait for 100 ns;	
		shift_amt <= "110011";
		wait for 100 ns;	
		shift_amt <= "110100";
		wait for 100 ns;	
		shift_amt <= "110101";
		wait for 100 ns;	
		shift_amt <= "110110";
		wait for 100 ns;	
		shift_amt <= "110111";
		wait for 100 ns;	
		shift_amt <= "111000";
		wait for 100 ns;	
		shift_amt <= "111001";
		wait for 100 ns;	
		shift_amt <= "111010";
		wait for 100 ns;	
		shift_amt <= "111011";
		wait for 100 ns;	
		shift_amt <= "111100";
		wait for 100 ns;	
		shift_amt <= "111101";
		wait for 100 ns;	
		shift_amt <= "111110";
		wait for 100 ns;	
		shift_amt <= "111111";
      -- insert stimulus here 

      wait;
   end process;

END;
