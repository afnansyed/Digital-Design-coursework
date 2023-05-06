library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity fa is
  port (
    x : in  std_logic;
    y : in  std_logic;
    cin : in  std_logic;
    s : out std_logic;
    cout : out std_logic);
end fa;

-- DEFINE THE FULL ADDER HERE

architecture BHV of fa is
begin 
   process(x, y, cin)
	begin
	
	  s <= x xor y xor cin;
	  cout <= (x and y) or (x and cin) or (x and cin);
	
	end process;
  
  
end BHV;