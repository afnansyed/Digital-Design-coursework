library ieee;
use ieee.std_logic_1164.all;

entity cla2 is
  port (
	x : in std_logic_vector(1 downto 0);
	y : in std_logic_vector(1 downto 0);
   cin : in  std_logic;
   
	s : out std_logic_vector(1 downto 0);
	cout : out std_logic;
	BP : out std_logic;
	BG : out std_logic);
end cla2;

architecture BHV of cla2 is

signal p0 : std_logic;
signal g0 : std_logic;
signal p1 : std_logic;
signal g1 : std_logic;

begin  -- BHV
	

	
	-- pi = xi + yi ; reference: cla_adder slides
	-- gi = xi * yi
	p0 <= x(0) OR y(0);
	g0 <= x(0) AND y(0);
	
	p1 <= x(1) OR y(1);
	g1 <= x(1) AND y(1);
	
	--reference: cla_adder slides
	BP <= p1 AND p0;
	BG <= g1 OR (p1 AND g0);
	
	--sum = x xor y xor cin; reference: textbook 5.4
	s(0) <= x(0) xor y(0) xor cin; 
	s(1) <= x(1) xor y(1) xor (g0 or (p0 AND cin)); -- s = x xor y xor c1 ; c1 = g0 + p0*c0; reference: textbook 5.4

	
	cout <= '0' ;  
	


end BHV;