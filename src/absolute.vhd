----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:43:34 11/04/2012 
-- Design Name: 
-- Module Name:    absolute - Behavioral 
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


entity absolute is
    Port ( A : in  STD_LOGIC_VECTOR (10 downto 0);
           B : in  STD_LOGIC_VECTOR (10 downto 0);
           S : out  STD_LOGIC_VECTOR (10 downto 0));
end absolute;

architecture Behavioral of absolute is

type GP_class is
	record
		G : std_logic;
		P : std_logic;
	end record;
	
type GP_vector is array(38 downto 0) of GP_class;

signal GP : GP_vector;

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
		signal GP1  : in GP_class;
		signal GP2	: in GP_class;
		signal GPO	: out GP_class
--		SIGNAL ING1 : IN STD_LOGIC;
--		SIGNAL INP1 : IN STD_LOGIC;
--		SIGNAL ING2 : IN STD_LOGIC;
--		SIGNAL INP2 : IN STD_LOGIC;
--		SIGNAL OUTG : OUT STD_LOGIC;
--		SIGNAL OUTP : OUT STD_LOGIC
	) is
begin
	GPO.G <= GP1.G or(GP1.P and GP2.G);
	GPO.P <= GP1.P and GP2.P;
end brentkung;


signal b_inv : std_logic_vector(10 downto 0);

begin

b_inv <= not B;

halfadd(A(0), b_inv(0), GP(0));
halfadd(A(1), b_inv(1), GP(1));
halfadd(A(2), b_inv(2), GP(2));
halfadd(A(3), b_inv(3), GP(3));
halfadd(A(4), b_inv(4), GP(4));
halfadd(A(5), b_inv(5), GP(5));
halfadd(A(6), b_inv(6), GP(6));
halfadd(A(7), b_inv(7), GP(7));
halfadd(A(8), b_inv(8), GP(8));
halfadd(A(9), b_inv(9), GP(9));
halfadd(A(10), b_inv(10), GP(10));

--halfadd(A(0), B(0), G(0), P(0));
--halfadd(A(1), B(1), G(1), P(1));
--halfadd(A(2), B(2), G(2), P(2));
--halfadd(A(3), B(3), G(3), P(3));
--halfadd(A(4), B(4), G(4), P(4));
--halfadd(A(5), B(5), G(5), P(5));
--halfadd(A(6), B(6), G(6), P(6));
--halfadd(A(7), B(7), G(7), P(7));
--halfadd(A(8), B(8), G(8), P(8));
--halfadd(A(9), B(9), G(9), P(9));
--halfadd(A(10), B(10), G(10), P(10));

brentkung(GP(1), GP(0), GP(11));
brentkung(GP(3), GP(2), GP(12));
brentkung(GP(5), GP(4), GP(13));
brentkung(GP(7), GP(6), GP(14));
brentkung(GP(9), GP(8), GP(15));

brentkung(GP(2),  GP(11), GP(16));
brentkung(GP(12), GP(11), GP(17));
brentkung(GP(6),  GP(13), GP(18));
brentkung(GP(14), GP(13), GP(19));
brentkung(GP(10), GP(15), GP(20));

brentkung(GP(4),	GP(17), GP(21));
brentkung(GP(13),	GP(17), GP(22));
brentkung(GP(18), GP(17), GP(23));
brentkung(GP(19), GP(17), GP(24));

brentkung(GP(8),	GP(24), GP(25));
brentkung(GP(15), GP(24), GP(26));
brentkung(GP(20), GP(24), GP(27));


--brentkung(G(1), P(1), G(0), P(0), G(11), P(11));
--brentkung(G(3), P(3), G(2), P(2), G(12), P(12));
--brentkung(G(5), P(5), G(4), P(4), G(13), P(13));
--brentkung(G(7), P(7), G(6), P(6), G(14), P(14));
--brentkung(G(9), P(9), G(8), P(8), G(15), P(15));
--
--brentkung(G(2),	P(2),		G(11), P(11), G(16), P(16));
--brentkung(G(12),	P(12),	G(11), P(11), G(17), P(17));
--brentkung(G(6),	P(6), 	G(13), P(13), G(18), P(18));
--brentkung(G(14),  P(14),	G(13), P(13), G(19), P(19));
--brentkung(G(10),	P(10),	G(15), P(15), G(20), P(20));
--
--brentkung(G(4),	P(4),		G(17), P(17), G(21), P(21));
--brentkung(G(13),	P(13), 	G(17), P(17), G(22), P(22));
--brentkung(G(18), 	P(18),	G(17), P(17), G(23), P(23));
--brentkung(G(19),  P(19),	G(17), P(17), G(24), P(24));
--
--brentkung(G(8),	P(8),		G(24), P(24), G(25), P(25));
--brentkung(G(15),  P(15), 	G(24), P(24), G(26), P(26));
--brentkung(G(20),  P(20), 	G(24), P(24), G(27), P(27));

GP(28).G <= GP(27).G or GP(27).P;
GP(28).P <= '0';

GP(29).G <= GP(0).P  or not (GP(0).G  xor GP(28).G);
GP(30).G <= GP(11).P or not (GP(11).G xor GP(28).G);
GP(31).G <= GP(16).P or not (GP(16).G xor GP(28).G);
GP(32).G <= GP(17).P or not (GP(17).G xor GP(28).G);
GP(33).G <= GP(21).P or not (GP(21).G xor GP(28).G);
GP(34).G <= GP(22).P or not (GP(22).G xor GP(28).G);
GP(35).G <= GP(23).P or not (GP(23).G xor GP(28).G);
GP(36).G <= GP(24).P or not (GP(24).G xor GP(28).G);
GP(37).G <= GP(25).P or not (GP(25).G xor GP(28).G);
GP(38).G <= GP(26).P or not (GP(26).G xor GP(28).G);

S(10) <= GP(10).P xor GP(38).G;
S(9) <= GP(9).P xor GP(37).G;
S(8) <= GP(8).P xor GP(36).G;
S(7) <= GP(7).P xor GP(35).G;
S(6) <= GP(6).P xor GP(34).G;
S(5) <= GP(5).P xor GP(33).G;
S(4) <= GP(4).P xor GP(32).G;
S(3) <= GP(3).P xor GP(31).G;
S(2) <= GP(2).P xor GP(30).G;
S(1) <= GP(1).P xor GP(29).G;


--S(10 downto 1) <= GP(10 downto 1).P xor GP(38 downto 29).G;
S(0) <= not GP(0).P;


--G(28) <= G(27) or P(27);
--P(28) <= '0';
--
--G(29) <= P(0) or not (G(0) xor G(28));
--G(30) <= P(11) or not (G(11) xor G(28));
--G(31) <= P(16) or not (G(16) xor G(28));
--G(32) <= P(17) or not (G(17) xor G(28));
--G(33) <= P(21) or not (G(21) xor G(28));
--G(34) <= P(22) or not (G(22) xor G(28));
--G(35) <= P(23) or not (G(23) xor G(28));
--G(36) <= P(24) or not (G(24) xor G(28));
--G(37) <= P(25) or not (G(25) xor G(28));
--G(38) <= P(26) or not (G(26) xor G(28));
--
--S(10 downto 1) <= P(10 downto 1) xor G(38 downto 29);
--S(0) <= not P(0);



end Behavioral;

