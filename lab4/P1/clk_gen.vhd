-- Used  Prof. Stitt counter4bit tutorial to write this code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        ms_period : positive);          -- Number of elapsed ms while button is
                                        -- pressed before creating clock pulse
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic);
end clk_gen;


architecture BHV of clk_gen is
    signal input2, out_t : std_logic;
	signal count : integer;
begin
	DIV : entity work.clk_div
	
	generic map(clk_in_freq => 50000000,  -- Input clock frequency
				clk_out_freq => 1000)
				
	port map(
		clk_in => clk50MHz,
		clk_out => input2,
        rst => rst);


		-- Used  most of Prof. Stitt counter and counter4bit tutorial to write this code
    process(input2, rst)
    begin
        if (rst = '1') then  --reset is 1
            count <= 0;
			out_t <= '0';
        elsif (rising_edge(input2)) then 
			if(button_n = '1') then  --is button is not pressed
				count <= 0;
				out_t <= '0';
			else --if button is pressed
				if (count < ms_period) then --while not reached end time
					out_t <= '0';
					count <= count + 1; --increment counter
				else --when reach end time
					count <= 1; 
					out_t <= '1';  --create clock pulse
					
				end if;
			end if;
			
        end if;
    end process;
	clk_out <= out_t;

       
end BHV;