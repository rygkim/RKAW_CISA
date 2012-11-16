-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY tb_add_basic IS
  END tb_add_basic;

  ARCHITECTURE behavior OF tb_add_basic IS 

  -- Component Declaration
          COMPONENT add_basic
          PORT(
                  Aval : IN std_logic_vector(63 downto 0);
                  Bval : IN std_logic_vector(63 downto 0);       
                  Qval : OUT std_logic_vector(63 downto 0)
                  );
          END COMPONENT;

          SIGNAL Aval :  std_logic_vector(63 downto 0) := (others => '0');
          SIGNAL Bval :  std_logic_vector(63 downto 0) := (others => '0');
			 SIGNAL Qval :  std_logic_vector(63 downto 0);


  BEGIN

  -- Component Instantiation
          uut: add_basic PORT MAP(
                  Aval => Aval,
                  Bval => Bval,
						Qval => Qval
          );
			 


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

			Aval(62 downto 52) <= "01111111111";
			Bval(62 downto 52) <= "01111111111";
        wait for 100 ns; -- wait until global set/reset completes
			Aval(62 downto 52) <= "10000000000";
		wait for 100 ns;
			Bval(62 downto 52) <= "10000000000";
			
		wait for 100 ns;
		Aval(51) <= '1';
		Aval(48) <= '1';
		Bval(62 downto 52) <= "10000000001";
		Bval(51 downto 48) <= "1101";
		

        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
