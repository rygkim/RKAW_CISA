--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:05:10 11/16/2012
-- Design Name:   
-- Module Name:   C:/Users/Alec/Documents/EE434/MACFPU_Add/tb_comp.vhd
-- Project Name:  MACFPU_Add
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: complementer
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
 
ENTITY tb_comp IS
END tb_comp;
 
ARCHITECTURE behavior OF tb_comp IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT complementer
    PORT(
         DATA : IN  std_logic_vector(55 downto 0);
         EN : IN  std_logic;
         DOUT : OUT  std_logic_vector(55 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DATA : std_logic_vector(55 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic_vector(55 downto 0);
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: complementer PORT MAP (
          DATA => DATA,
          EN => EN,
          DOUT => DOUT,
          COUT => COUT
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		EN <= '1';


      -- insert stimulus here 

      wait;
   end process;

END;
