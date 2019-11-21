library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--0010 1111 1010 1111 0000 1000 0000 -- 50 000 000 pulsos de clock -> 1 segundo
--0000 0000 0000 0000 0000 0001 0011 -- 0-19 (20ns) pulsos de clock -> timer = timer +1
entity Timer is
    Port ( 
			i_CLK 	: in std_logic;
			i_RST		: in std_logic;
			i_SEC		: in integer;
			i_EN		: in std_logic;
			o_DONE	: out std_logic
	 );
end Timer;

architecture Behavioral of Timer is
	signal w_cont_sec : integer := 0;
	signal w_DONE: std_logic;
	signal w_cont: std_logic_vector (27 downto 0) := (OTHERS =>'0');
	
	begin
		o_DONE <= w_DONE;
		
		U_TIMER : process (i_CLK, i_RST)
			begin
				if(i_RST = '1')then
					w_cont <= (others => '0');
					w_cont_sec <= 0;
					w_DONE <= '0';
				elsif(i_EN = '1') then
					if rising_edge(i_CLK) then
						w_cont <= w_cont+ 1;
							if(w_cont = "0010111110101111000010000000") then
								w_cont <= (others => '0');
								w_cont_sec <= w_cont_sec +1;
								if(w_cont_sec = i_SEC) then
									w_DONE <= '1';
									w_cont <= (others => '0');
									w_cont_sec <= 0;
								else
									w_DONE <= '0';
								end if;
							else
								w_DONE <= '0';
							end if;
					end if;
				else
					w_cont <= (others => '0');
					w_cont_sec <= 0;
					w_DONE <= '0';
				end if;
		end process;
end Behavioral;