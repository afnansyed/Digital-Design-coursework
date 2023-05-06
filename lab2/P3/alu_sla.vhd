library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity alu_sla is
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
end alu_sla; 

architecture default of alu_sla is

begin

	process(input1, input2, sel)
	
	variable temp : std_logic_vector(width-1 downto 0);
	variable temp_add : std_logic_vector(WIDTH downto 0);

	variable temp_multi : std_logic_vector(2*width-1 downto 0);
	variable multi_upper : std_logic_vector(width-1 downto 0);
	constant zero : std_logic_vector(1 downto 0) := "00";
		
	begin

		case sel is
		   when "0000" =>  --ADD

  			temp_add := ("0"&input1) + ("0"&input2);

    			output <= temp_add(WIDTH-1 downto 0);
    			overflow <= temp_add(WIDTH);

			
		   when "0001" =>  --SUB
			temp := input1 - input2;
			output <= temp;
			overflow <= '0';

		   when "0010" => --MULTI
			temp_multi := input1*input2;
			output <= temp_multi((2*width-1)/2 downto 0);
			multi_upper := temp_multi(2*width-1 downto width);
			
			if(multi_upper /= 0) then
			   overflow <= '1';
			else
			   overflow <= '0';
			end if;

		   when "0011" => --AND
			temp := input1 and input2;
			output <= temp;
			overflow <= '0';

		   when "0100" =>  --OR
			temp := input1 or input2;
			output <= temp;
			overflow <= '0';

		   when "0101" =>  --XOR
			temp := input1 xor input2;
			output <= temp;
			overflow <= '0';

		   when "0110" =>  --NOR
			temp := input1 nor input2;
			output <= temp;
			overflow <= '0';

		   when "0111" =>  --NOT
			temp := not input1;
			output <= temp;
			overflow <= '0';

		   when "1000" => --SHIFT LEFT
			temp := input1;
			overflow <= temp(width-1);
			output <= temp(width-2 downto 0) & "0";
			
			
			when "1001" =>  --SHIFT RIGHT
			temp := input1;
			output <= "0"& temp(width-1 downto 1);
			overflow <= '0';
			
			when "1010" => --SWAP 
			temp := input1;
			output <= temp((width-2)/2 downto 0) & temp(width-1 downto (width)/2);
			overflow <= '0';
			
			when "1011" =>  --REVERSE
			   
				overflow <= '0';
			
				for i in 0 to WIDTH-1 loop
				
					output(i) <= input1(WIDTH-1-i);
				
				end loop;
				
			when "1100" =>
			output <= (others => '0');
			overflow <= '0';
			
			when "1101" =>
			output <= (others => '0');
			overflow <= '0';
			
			when "1110" =>
			output <= (others => '0');
			overflow <= '0';
			
			when "1111" =>
			output <= (others => '0');
			overflow <= '0';
			
			when others =>
			output <= (others => '0');
			overflow <= '0';
		

		   end case;

			


	end process;
end default;
			
