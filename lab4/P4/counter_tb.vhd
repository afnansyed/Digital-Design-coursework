
-- Used most of Prof. Stitt counter4bit_tb tutorial to write this code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter_tb is
end counter_tb;


architecture TB of counter_tb is
    signal clk, rst, up_n, load_n, done: std_logic := '0';
	signal input : std_logic_vector(3 downto 0);
    signal output : std_logic_vector(3 downto 0);

begin

    -- Change the architecture to test the different implementations
    UUT : entity work.counter
        port map (
            clk    => clk,
            rst    => rst,
            up_n   => up_n,
			load_n => load_n,
			input  => input,
            output => output);

    -- create the clock (and not done ensure that the simulation will finish)
    clk <= not clk and not done after 10 ns;

    
    process
    begin
	
        rst <= '1';
		done <= '0';
		input <= "0110"; --6
		wait for 5 ns;

		--count down from 6
		rst <= '0';
		load_n <= '0';
		wait until rising_edge(clk);
		up_n <= '1';
		load_n <= '1';
        -- wait for 5 cycles
        for i in 0 to 5 loop
            wait until rising_edge(clk);
        end loop;  -- i

        wait for 10 ns;
		
		--count up
		up_n <= '0';
		load_n <= '1';
		for i in 0 to 5 loop
            wait until rising_edge(clk);
        end loop;  -- i
		
		wait for 10 ns;

        rst <= '0';
		done <= '1';

        wait;
               
    end process;
    
    
end TB;
