-- Used Prof. Stitt counter4bit tutorial to write this code
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(clk_in_freq  : natural;  -- Input clock frequency
            clk_out_freq : natural); -- Output clock frequency
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic);
end clk_div;

architecture BHV of clk_div is

	signal count : integer;
	signal out_t : std_logic;

begin

-- Used  most of Prof. Stitt counter and counter4bit tutorial to write this code
	process(clk_in, rst)
	begin
	
		if(rst = '1') then --if reset
			count <= 0;
			out_t <= '0';
	
		elsif (rising_edge(clk_in)) then
			if(count < ((clk_in_freq/clk_out_freq)/2)) then 
				count <= count + 1; --increment counter
			else
				count <= 0;
				out_t <= not out_t; --negate output to create pulse
			end if;
			
		end if;
		
	end process;
	
	clk_out <= out_t;
	
	
end BHV;

