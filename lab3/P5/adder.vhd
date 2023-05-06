library ieee;
use ieee.std_logic_1164.all;

entity adder is
    generic (
        WIDTH : positive := 8); 
    port (
        x, y : in  std_logic_vector(WIDTH-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(WIDTH-1 downto 0);
        cout : out std_logic);
end adder;

architecture RIPPLE_CARRY of adder is  --Refrence: Prof. Stitt ripple carry demo

	signal carry : std_logic_vector(width downto 0);

begin  -- RIPPLE_CARRY

	U_ADD : for i in 0 to width-1 generate
	
		U_FA : entity work.fa port map (
			x    => x(i),
			y    => y(i),
			cin  => carry(i),
			s    => s(i),
			cout => carry(i+1));
	  

	end generate U_ADD;
	
	carry(0) <= cin;
	cout     <= carry(width);

end RIPPLE_CARRY;


architecture CARRY_LOOKAHEAD of adder is

begin  -- CARRY_LOOKAHEAD

    process(x, y, cin)

        -- generate and propagate bits
        variable g, p : std_logic_vector(WIDTH-1 downto 0);

        -- internal carry bits
        variable carry : std_logic_vector(WIDTH downto 0);

        -- and'd p sequences
        variable p_ands : std_logic_vector(WIDTH-1 downto 0);

    begin

        -- calculate generate (g) and propogate (p) values

        for i in 0 to WIDTH-1 loop
        -- fill in code that defines each g and p bit
		    g(i) := x(i) and y(i);
          p(i) := x(i) or y(i);
        end loop;  -- i

        carry(0) := cin;

        -- calculate each carry bit

        for i in 1 to WIDTH loop

            -- calculate and'd p terms for ith carry logic      
            -- the index j corresponds to the lowest Pj value in the sequence
            -- e.g., PiPi-1...Pj

            for j in 0 to i-1 loop
                p_ands(j) := '1';

                -- and everything from Pj to Pi-1
                for k in j to i-1 loop
                -- fill code
				     p_ands(j) := P_ands(j) and p(k);
                end loop;
            end loop;

            carry(i) := g(i-1);

            -- handle all of the pg minterms
            for j in 1 to i-1 loop
            -- fill in code
				carry(i) := carry(i) or (p_ands(j) and g(j-1));
            end loop;

            -- handle the final propagate of the carry in
            carry(i) := carry(i) or (p_ands(0) and cin);
        end loop;  -- i

        -- set the outputs
        for i in 0 to WIDTH-1 loop
        -- fill in code
		   s(i) <= x(i) xor y(i) xor carry(i);
        end loop;  -- i

        cout <= carry(WIDTH);

    end process;

end CARRY_LOOKAHEAD;


-- You don't have to change any of the code for the following
-- architecture. However, read the lab instructions to create
-- an RTL schematic of this entity so you can see how the
-- synthesized circuit differs from the previous carry
-- lookahead circuit.

architecture CARRY_LOOKAHEAD_BAD_SYNTHESIS of adder is
begin  -- CARRY_LOOKAHEAD_BAD_SYNTHESIS

    process(x, y, cin)

        -- generate and propagate bits
        variable g, p : std_logic_vector(WIDTH-1 downto 0);

        -- internal carry bits
        variable carry : std_logic_vector(WIDTH downto 0);

    begin

        -- calculate generate (g) and propogate (p) values

        for i in 0 to WIDTH-1 loop
            g(i) := x(i) and y(i);
            p(i) := x(i) or y(i);
        end loop;  -- i

        -- calculate carry bits (the order here is very important)
        -- Problem: defining the carries this way causes the synthesis
        -- tool to chain everything together like a ripple carry.
        -- See RTL view in synthesis tool.

        carry(0) := cin;
        for i in 0 to WIDTH-1 loop
            carry(i+1) := g(i) or (p(i) and carry(i));
        end loop;  -- i

        -- set the outputs

        for i in 0 to WIDTH-1 loop
            s(i) <= x(i) xor y(i) xor carry(i);
        end loop;  -- i

        cout <= carry(WIDTH);

    end process;

end CARRY_LOOKAHEAD_BAD_SYNTHESIS;



architecture HIERARCHICAL of adder is

	signal B_prop0 : std_logic;
	signal B_prop1 : std_logic;
	signal B_gen0 : std_logic;
	signal B_gen1 : std_logic;
	signal carry :  std_logic;

	
begin  -- HIERARCHICAL

	  CLA4_0 : entity work.cla4 port map (
	   x => x(3 downto 0), --reference: TA
		y => y(3 downto 0),
		s => s(3 downto 0),
		cin => cin,
		
		cout => open,
		BP => B_prop0,
		BG => B_gen0
         
	  );
	  CLA4_1 : entity work.cla4 port map (
	   x => x(7 downto 4),  --reference: TA
		y => y(7 downto 4),
		s => s(7 downto 4),
		cin => carry,
		
		cout => open,
		BP => B_prop1,
		BG => B_gen1
	  );
	  CGEN2 : entity work.cgen2 port map (
	   P => B_prop0,
		G => B_gen0,
		P1 => B_prop1,
		G1 => B_gen1,
		ci => cin,
		
		c1 => carry,
		c2 => cout,
		BP => open,
		BG => open
	  );


end HIERARCHICAL;