--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:27:02 11/16/2012
-- Design Name:   
-- Module Name:   C:/Users/Alec/Documents/EE434/MACFPU_Add/tb_expaddr1.vhd
-- Project Name:  MACFPU_Add
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: exponent_adder
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
 
ENTITY tb_expaddr1 IS
END tb_expaddr1;
 
ARCHITECTURE behavior OF tb_expaddr1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT exponent_adder
    PORT(
         exp_in : IN  std_logic_vector(10 downto 0);
         zlc_in : IN  std_logic_vector(6 downto 0);
         exp_out : OUT  std_logic_vector(10 downto 0);
         null_exp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal exp_in : std_logic_vector(10 downto 0) := (others => '0');
   signal zlc_in : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal exp_out : std_logic_vector(10 downto 0);
   signal null_exp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: exponent_adder PORT MAP (
          exp_in => exp_in,
          zlc_in => zlc_in,
          exp_out => exp_out,
          null_exp => null_exp
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		zlc_in <= "1110000";
      wait for 100 ns;	
		zlc_in <= "0000000";


      -- insert stimulus here 

      wait;
   end process;

END;
