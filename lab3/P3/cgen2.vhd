library ieee;
use ieee.std_logic_1164.all;

entity cgen2 is
  port (
	P : in std_logic;
	G : in std_logic;
	P1 : in std_logic;
	G1 : in std_logic;
	ci : in  std_logic;
	
	c1 : out std_logic;
	c2 : out std_logic;
	BP : out std_logic;
	BG : out std_logic);
end cgen2;

architecture BHV of cgen2 is

begin  -- BHV
	
	--equations reference: lecture cla_adder slides and lecture
	
	BP <= P1 AND P;
	BG <= G1 OR (P1 AND G);
	
	 --ci+1 = gi + (pi*ci)
	c1 <= G OR (P AND ci);
	c2 <= G1 OR (P1 AND G) OR (P1 AND P AND ci);
	


end BHV;