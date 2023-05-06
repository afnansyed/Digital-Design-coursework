library ieee;
use ieee.std_logic_1164.all;

entity gray1 is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end gray1;


architecture BHV of gray1 is

	type state_t is (STATE_0, STATE_1, STATE_2,STATE_3,STATE_4,STATE_5,STATE_6,STATE_7,STATE_8, STATE_9, STATE_A,STATE_B,STATE_C,STATE_D,STATE_E,STATE_F);
	signal state_r : state_t;
	
begin

	process(clk, rst)
	begin
	
		if(rst = '1') then
			output <= (others => '0');
			state_r <= STATE_0;
		elsif (rising_edge(clk)) then
			case(state_r) is
				when STATE_0 =>
				
					output <= "0000";
					state_r <= STATE_1;
					
				when STATE_1 =>
				
					output <= "0001";
					state_r <= STATE_3;
				
				when STATE_3 =>
				
					output <= "0011";
					state_r <= STATE_2;
				
				when STATE_2 =>
				
					output <= "0010";
					state_r <= STATE_6;
				
				when STATE_6 =>
				
					output <= "0110";
					state_r <= STATE_7;
					
				when STATE_7 =>
				
					output <= "0111";
					state_r <= STATE_5;
					
				when STATE_5 =>
				
					output <= "0101";
					state_r <= STATE_4;
					
				when STATE_4 =>
				
					output <= "0100";
					state_r <= STATE_C;
					
				when STATE_C =>
				
					output <= "1100";
					state_r <= STATE_D;
					
				when STATE_D =>
				
					output <= "1101";
					state_r <= STATE_F;
					
				when STATE_F =>
				
					output <= "1111";
					state_r <= STATE_E;
					
				when STATE_E =>
				
					output <= "1110";
					state_r <= STATE_A;
					
				when STATE_A =>
				
					output <= "1010";
					state_r <= STATE_B;
					
				when STATE_B =>
				
					output <= "1011";
					state_r <= STATE_9;
					
				when STATE_9 =>
				
					output <= "1001";
					state_r <= STATE_8;
					
				when STATE_8 =>
				
					output <= "1000";
					state_r <= STATE_0;
					
				when others => null;
					
			end case;
			
		end if;
	
	end process;
	
	
end BHV;