----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:48:54 11/16/2012 
-- Design Name: 
-- Module Name:    exponent_adder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exponent_adder is
    Port ( exp_in : in  STD_LOGIC_VECTOR (10 downto 0);
           zlc_in : in  STD_LOGIC_VECTOR (6 downto 0);
           exp_out : out  STD_LOGIC_VECTOR (10 downto 0);
           null_exp : out  STD_LOGIC);
end exponent_adder;

architecture structural of exponent_adder is

type GP_class is
	record
		G : std_logic;
		P : std_logic;
	end record;
	
type BK_vector is array(4 downto 0) of GP_class;
type HA_vector is array(10 downto 0) of GP_class;
signal R1, R2, R3, R4 : BK_vector;
signal HA : HA_vector;
signal zlc_pad : std_logic_vector(10 downto 0);
signal A : std_logic_vector(10 downto 0);

procedure halfadd
	(	signal A : in STD_LOGIC;
		signal B : in STD_LOGIC;
		signal GP_val : out GP_class
		--signal G : out STD_LOGIC;
		--signal P : out STD_LOGIC
	 ) is
begin
	GP_val.G <= A and B;
	GP_val.P <= A xor B;
end halfadd;

procedure brentkung
	(	
		signal GP1  : in GP_class; --Left
		signal GP2	: in GP_class; --Right
		signal GPO	: out GP_class
	) is
begin
	GPO.G <= GP1.G or(GP1.P and GP2.G);
	GPO.P <= GP1.P and GP2.P;
end brentkung;

signal cout : std_logic;
signal intsum : std_logic_vector(10 downto 0);
signal B : std_logic_vector(10 downto 0);
signal C : std_logic_vector(10 downto 0);
begin

zlc_pad <= "0000" & zlc_in;
A <= zlc_pad;
C <= exp_in;
B <= "11111111111";

--Perform ZLC - 1

halfadd(A(0), B(0), HA(0));
halfadd(A(1), B(1), HA(1));
halfadd(A(2), B(2), HA(2));
halfadd(A(3), B(3), HA(3));
halfadd(A(4), B(4), HA(4));
halfadd(A(5), B(5), HA(5));
halfadd(A(6), B(6), HA(6));
halfadd(A(7), B(7), HA(7));
halfadd(A(8), B(8), HA(8));
halfadd(A(9), B(9), HA(9));
halfadd(A(10), B(10), HA(10));

--Row one of BKs
brentkung(HA(1), HA(0), R1(0));
brentkung(HA(3), HA(2), R1(1));
brentkung(HA(5), HA(4), R1(2));
brentkung(HA(7), HA(6), R1(3));
brentkung(HA(9), HA(8), R1(4));
--Row two of BKs
brentkung(HA(2), R1(0), R2(0));
brentkung(R1(1), R1(0), R2(1));
brentkung(HA(6), R1(2), R2(2));
brentkung(R1(3), R1(2), R2(3));
brentkung(HA(10), R1(4), R2(4));
--Row three of BKs
brentkung(HA(4), R2(1), R3(0));
brentkung(R1(2), R2(1), R3(1));
brentkung(R2(2), R2(1), R3(2));
brentkung(R2(3), R2(1), R3(3));
--Row four of BKs
brentkung(HA(8), R3(3), R4(0));
brentkung(R1(4), R3(3), R4(1));
brentkung(R2(4), R3(3), R4(2));

cout <= R4(2).G;

intsum(0) <= HA(0).P;
intsum(1) <= HA(1).P xor HA(0).G;
intsum(2) <= HA(2).P xor R1(0).G;
intsum(3) <= HA(3).P xor R2(0).G;
intsum(4) <= HA(4).P xor R2(1).G;
intsum(5) <= HA(5).P xor R3(0).G;
intsum(6) <= HA(6).P xor R3(1).G;
intsum(7) <= HA(7).P xor R3(2).G;
intsum(8) <= HA(8).P xor R3(3).G;
intsum(9) <= HA(9).P xor R4(0).G;
intsum(10) <= HA(10).P xor R4(1).G;

exp_out <= intsum;
null_exp <= cout;

end structural;

