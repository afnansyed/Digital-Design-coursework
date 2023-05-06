library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu_ns_tb is
end alu_ns_tb;

architecture TB of alu_ns_tb is

    component alu_ns

        generic (
            WIDTH : positive := 16
            );
        port (
            input1   : in  std_logic_vector(WIDTH-1 downto 0);
            input2   : in  std_logic_vector(WIDTH-1 downto 0);
            sel      : in  std_logic_vector(3 downto 0);
            output   : out std_logic_vector(WIDTH-1 downto 0);
            overflow : out std_logic
            );

    end component;

    constant WIDTH  : positive                           := 8;
    signal input1   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sel      : std_logic_vector(3 downto 0)       := (others => '0');
    signal output   : std_logic_vector(WIDTH-1 downto 0);
    signal overflow : std_logic;

begin  -- TB

    UUT : alu_ns
        generic map (WIDTH => WIDTH)
        port map (
            input1   => input1,
            input2   => input2,
            sel      => sel,
            output   => output,
            overflow => overflow);

    process
    begin

        -- test 2+6 (no overflow)
        sel    <= "0000";
        input1 <= conv_std_logic_vector(2, input1'length);
        input2 <= conv_std_logic_vector(6, input2'length);
        wait for 10 ns;
        assert(output = conv_std_logic_vector(8, output'length)) report "Error : 2+6 = " & integer'image(conv_integer(output)) & " instead of 8" severity warning;
        assert(overflow = '0') report "Error                                   : overflow incorrect for 2+8" severity warning;

        -- test 250-50 (no overflow)
        sel    <= "0001";
        input1 <= conv_std_logic_vector(250, input1'length);
        input2 <= conv_std_logic_vector(50, input2'length);
        wait for 10 ns;
        assert(output = conv_std_logic_vector(200, output'length)) report "Error : 250-50 = " & integer'image(conv_integer(output)) & " instead of 200" severity warning;
        assert(overflow = '0') report "Error                                     : overflow incorrect for 250-50" severity warning;

        -- test 5*6
        sel    <= "0010";
        input1 <= conv_std_logic_vector(5, input1'length);
        input2 <= conv_std_logic_vector(6, input2'length);
        wait for 10 ns;
        assert(output = conv_std_logic_vector(30, output'length)) report "Error : 5*6 = " & integer'image(conv_integer(output)) & " instead of 30" severity warning;
        assert(overflow = '0') report "Error                                    : overflow incorrect for 5*6" severity warning;

        -- test AND
        sel    <= "0011";
        input1 <= "00000010";
        input2 <= "00001111";
        wait for 10 ns;
        assert(output = "00000010") report "Error " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;

        -- test OR
        sel    <= "0100";
        input1 <= "00000010";
        input2 <= "00001111";
        wait for 10 ns;
        assert(output = "00001111") report "Error " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test XOR
        sel    <= "0101";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "00000101") report "Error " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test NOR
        sel    <= "0110";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "10110000") report "Error " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test NOT
        sel    <= "0111";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "10110101") report "Error not " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test Shift left
        sel    <= "1000";
        input1 <= "10001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "00010100") report "Error shift left " severity warning;
        assert(overflow = '1') report "Error overflow" severity warning;
		
		-- test Shift right
        sel    <= "1001";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "00100101") report "Error shift right" severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test swap
        sel    <= "1010";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "10100100") report "Error swap " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
		-- test reverse
        sel    <= "1011";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "01010010") report "Error reverse " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;


	    sel    <= "1100";
        input1 <= "01001010";
        input2 <= "01001111";
        wait for 10 ns;
        assert(output = "00000000") report "Error reverse " severity warning;
        assert(overflow = '0') report "Error overflow" severity warning;
		
        wait;

    end process;



end TB;