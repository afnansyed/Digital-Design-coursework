library ieee;
use ieee.std_logic_1164.all;

entity cla4 is
  port (
	x : in std_logic_vector(3 downto 0);
	y : in std_logic_vector(3 downto 0);
   cin : in  std_logic;
   
	s : out std_logic_vector(3 downto 0);
	cout : out std_logic;
	BP : out std_logic;
	BG : out std_logic);
end cla4;

architecture HIERARCHICAL of cla4 is

	signal B_prop0 : std_logic;
	signal B_prop1 : std_logic;
	signal B_gen0 : std_logic;
	signal B_gen1 : std_logic;
	signal carry :  std_logic;

begin  -- HIERARCHICAL

	  CLA2_0 : entity work.cla2 port map (
	  
	   x => x(1 downto 0), --reference: TA
		y => y(1 downto 0),
		s => s(1 downto 0),
		cin => cin,
		
		cout => open,
		BP => B_prop0,
		BG => B_gen0
         
	  );
	  CLA2_1 : entity work.cla2 port map (
	   x => x(3 downto 2), --reference: TA
		y => y(3 downto 2),
		s => s(3 downto 2),
		cin => carry,
		
		cout => open,
		BP => B_prop1,
		BG => B_gen1
	  );
	  CGEN2 : entity work.cgen2 port map (
	   P => B_prop0,
		G => B_gen0,
		P1 => B_prop1,
		G1 => B_gen1,
		ci => cin,
		
		c1 => carry,
		c2 => cout,
		BP => BP,
		BG => BG
	  );

end HIERARCHICAL;