library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_ns is
	generic (
		WIDTH : positive := 16
	);
	
	port (
		input1 : in std_logic_vector(WIDTH-1 downto 0);
		input2 : in std_logic_vector(WIDTH-1 downto 0);
		sel : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(WIDTH-1 downto 0);
		overflow : out std_logic
	);
end alu_ns;


architecture default of alu_ns is

begin

	process(input1, input2, sel)
	
	variable temp : unsigned(width-1 downto 0);
	variable temp_add : unsigned(WIDTH downto 0);
	variable temp_multi : unsigned(2*width-1 downto 0);
	variable multi_upper : unsigned(width-1 downto 0);
	constant zero : unsigned(1 downto 0) := "00";
		
	begin

		case sel is
		   when "0000" =>  --ADD

  			  temp_add := unsigned("0"&input1) + unsigned("0"&input2);

    			output <= std_logic_vector(temp_add(WIDTH-1 downto 0));
    			overflow <= std_logic(temp_add(WIDTH));

			
		   when "0001" =>  --SUB
			temp := unsigned(input1)-unsigned(input2);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "0010" => --MULTI
			temp_multi := unsigned(input1)*unsigned(input2);
			output <= std_logic_vector(temp_multi((2*width-1)/2 downto 0));
			multi_upper := temp_multi(2*width-1 downto width);
			
			if(multi_upper /= 0) then
			   overflow <= '1';
			else
			   overflow <= '0';
			end if;

		   when "0011" => --AND
			temp := unsigned(input1 and input2);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "0100" =>  --OR
			temp := unsigned(input1 or input2);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "0101" =>  --XOR
			temp := unsigned(input1 xor input2);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "0110" =>  --NOR
			temp := unsigned(input1 nor input2);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "0111" =>  --NOT
			temp := unsigned(not input1);
			output <= std_logic_vector(temp);
			overflow <= '0';

		   when "1000" => --SHIFT LEFT
			temp := unsigned(input1);
			overflow <= std_logic(temp(width-1));
			output <= std_logic_vector(shift_left(temp, 1));
			
			
			when "1001" =>  --SHIFT RIGHT
			temp := unsigned(input1);
			output <= std_logic_vector(shift_right(temp, 1));
			overflow <= '0';
			
			when "1010" => --SWAP 
			temp := unsigned(input1);
			output <= std_logic_vector(temp((width-2)/2 downto 0)) & std_logic_vector(temp(width-1 downto (width)/2));
			overflow <= '0';
			
			when "1011" =>  --REVERSE
			
				for i in 0 to WIDTH-1 loop
				
					output(i) <= input1(width-1-i);
				
				end loop;
				
				
				overflow <= '0';
				
			when "1100" =>
			output <= std_logic_vector(resize(zero, width));
			overflow <= '0';
			
			when "1101" =>
			output <= std_logic_vector(resize(zero, width));
			overflow <= '0';
			
			when "1110" =>
			output <= std_logic_vector(resize(zero, width));
			overflow <= '0';
			
			when "1111" =>
			output <= std_logic_vector(resize(zero, width));
			overflow <= '0';
			
			when others =>
			output <= std_logic_vector(resize(zero, width));
			overflow <= '0';
		

		   end case;

			


	end process;
end default;
			
