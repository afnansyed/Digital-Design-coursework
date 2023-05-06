library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder7seg_tb is
end decoder7seg_tb;


architecture TB of decoder7seg_tb is

  component decoder7seg
    port(
      input : in std_logic_vector(3 downto 0);
      output : out std_logic_vector(6 downto 0));
  end component;

  signal input : std_logic_vector(3 downto 0);
  signal output : std_logic_vector(6 downto 0);

begin --TB

	UUT : entity work.decoder7seg(default)
		port map(
			input => input,
			output => output);

	process
	begin
			input <="0000";
			wait for 10 ns;
			assert(output = "0000001") report "error 1" severity warning;
			
			input <="0001";
			wait for 10 ns;
			assert(output = "1001111") report "error 2" severity warning;

			input <="0010";
			wait for 10 ns;
			assert(output = "0010010") report "error 3" severity warning;

			input <="0011";
			wait for 10 ns;
			assert(output = "0000110") report "error 4" severity warning;


			input <="0100";
			wait for 10 ns;
			assert(output = "1001100") report "error 5" severity warning;


			input <="0101";
			wait for 10 ns;
			assert(output = "0100100") report "error 6" severity warning;


			input <="0110";
			wait for 10 ns;
			assert(output = "0100000") report "error 7" severity warning;

			input <="0111";
			wait for 10 ns;
			assert(output = "0001111") report "error 8" severity warning;

			input <="1000";
			wait for 10 ns;
			assert(output = "0000000") report "error 9" severity warning;

			input <="1001";
			wait for 10 ns;
			assert(output = "0001100") report "error 10" severity warning;

			input <="1010";
			wait for 10 ns;
			assert(output = "0001000") report "error 11" severity warning;

			input <="1011";
			wait for 10 ns;
			assert(output = "1100000") report "error 12" severity warning;

			input <="1100";
			wait for 10 ns;
			assert(output = "0110001") report "error 13" severity warning;

			input <="1101";
			wait for 10 ns;
			assert(output = "1000010") report "error 14" severity warning;

			input <="1110";
			wait for 10 ns;
			assert(output = "0110000") report "error 15" severity warning;

			input <="1111";
			wait for 10 ns;
			assert(output = "0111000") report "error 16" severity warning;
			
			wait;
			  	
			


	end process;


end TB;