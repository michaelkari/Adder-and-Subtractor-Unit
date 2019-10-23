LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ASU IS
	PORT (
		Cin 				: IN  STD_LOGIC;
		X, Y				: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		s					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		L : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		Cout, neg      : OUT STD_LOGIC);
END ASU;
		
ARCHITECTURE Behaviour OF ASU IS
	
	SIGNAL Sum : STD_LOGIC_VECTOR (4 DOWNTO 0);
	
BEGIN
	PROCESS (X, Y, Cin)
	BEGIN
			IF (Cin = '0') THEN
				Sum <= ('0' & X) + ('0' & Y) + Cin;
				s <= Sum (3 DOWNTO 0);
				Cout <= Sum(4);
				neg <='0';
			ELSE 
				IF (Y>X) THEN	
					Sum <= ('0' & Y) - ('0' & X);
					neg <='1';
				ELSE	
					Sum <= ('0' & X) - ('0' & Y);
					neg <= '0';
				END IF;
				s <= Sum(3 DOWNTO 0);
				Cout <= Sum(4);
			END IF;
		END PROCESS;
	s <= Sum(3 DOWNTO 0);
	L(3) <= (Sum(1) AND (NOT Sum(3))) OR (Sum(3) AND Sum(2)) OR (Sum(1) AND Sum(3));
	L(2) <= (Sum(1) AND Sum(3)) OR (Sum(1) AND Sum(2)) OR (Sum(1) AND Sum(0) AND (NOT Sum(3)));
	L(1) <= (Sum(1) AND Sum(3)) OR (Sum(1) AND Sum(2)) OR (Sum(1) AND Sum(0) AND (NOT Sum(3))) OR (Sum(0) AND (NOT Sum(3)) AND (NOT Sum(2)));
	L(0) <= ((NOT Sum(1)) AND Sum(0) AND (NOT Sum(3))) OR ((NOT Sum(1)) AND Sum(0) AND (NOT Sum(2))) OR ((NOT Sum(2)) AND (NOT Sum(0)) AND (NOT Sum(3)));
	END Behaviour;				