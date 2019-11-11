library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--0010 1111 1010 1111 0000 1000 0000‬

entity TB_Timer is
	
end TB_Timer;

architecture Behavioral of TB_Timer is

COMPONENT Timer is
    Port ( 
				i_CLK			: in std_logic;
				i_SIGNAL		: in STD_LOGIC_vector (1 downto 0);
			   o_TIMER 		: out STD_LOGIC_vector(9 downto 0)
	 );
end COMPONENT;

	signal w_CLK: std_logic;
	signal w_SIGNAL: STD_LOGIC_vector (1 downto 0);
	signal w_TIMER	:std_LOGIC_vector(9 downto 0);

BEGIN 
	--processo clock
		p_clock : process
			begin
			w_CLK <='1';
			wait for 10 ns;
			w_CLK <= '0';
			wait for 10 ns;
		end process p_clock;
	--fim clock
	
UTT : Timer
	port map(
		i_CLK => w_CLK,
		i_SIGNAL => w_SIGNAL,
		o_TIMER => w_TIMER
);

	teste : process
		begin						-- TROCAR OS TEMPOS PARA TESTAR !!!
			w_SIGNAL <= "00"; -- RESET
			wait for 20 ns;	
			w_SIGNAL <= "01"; -- START
			wait for 5	sec;
			w_SIGNAL <= "10"; -- STOP
			wait for 2	sec;
			w_SIGNAL <= "01"; -- START
			wait for 5	sec;
			w_SIGNAL <= "11"; -- CLEAR
			wait;
		end process teste;
END Behavioral;