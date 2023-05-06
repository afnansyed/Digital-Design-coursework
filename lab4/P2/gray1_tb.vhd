library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray1_tb is
end gray1_tb;

architecture TB of gray1_tb is

    component gray1
        port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
    end component;

    signal clk : std_logic := '0'; 
	signal rst : std_logic;
    signal output  : std_logic_vector(3 downto 0);

begin  -- TB

    UUT : entity work.gray1
        port map (
            clk  => clk,
            rst => rst,
            output => output);

    clk <= not clk after 10 ns;

	--Reference used: Prof. Stitt FSM testbench and clk_div_tb
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

        rst <= '0';

        wait;

    end process;
	

end TB;