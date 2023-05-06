library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray2_tb is
end gray2_tb;

architecture TB of gray2_tb is

    component gray2
        port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
    end component;

    signal clk : std_logic := '0'; 
	signal rst : std_logic;
    signal output  : std_logic_vector(3 downto 0);

begin  -- TB

    UUT : entity work.gray2
        port map (
            clk  => clk,
            rst => rst,
            output => output);

	--Reference used: Prof. Stitt FSM testbench and clk_div_tb
	
    clk <= not clk after 10 ns;

    process
    begin

        rst <= '1';
		wait for 5 ns;

		rst <= '0';
        -- wait for 15 cycles
        for i in 0 to 15 loop
            wait until rising_edge(clk);
        end loop;  -- i

        wait for 5 ns;

        rst <= '1';

        wait;

    end process;
	

end TB;