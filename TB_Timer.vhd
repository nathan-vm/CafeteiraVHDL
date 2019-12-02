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
			i_CLK 	: in  std_logic;
			i_RST		: in  std_logic;
			i_SEC		: in  integer;
			i_EN		: in  std_logic;
			--o_SEC		: out integer;
			o_DONE	: out std_logic
	 );
end COMPONENT;

	signal w_CLK: std_logic;
	signal w_RST: std_logic := '0';
	signal w_SEC: integer:= 0;
	signal w_EN: std_logic:= '0';
	--signal w_out_SEC: integer:=0;
	signal w_DONE: std_logic:='0';

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
		i_RST => w_RST,
		i_SEC => w_SEC,
		i_EN  => w_EN,
		--o_SEC => w_out_SEC,
		o_DONE=> w_DONE
);

	teste : process
		begin						-- TROCAR OS TEMPOS PARA TESTAR !!!
			w_EN <= '1';
			w_SEC <= 10;
			wait for 2040 ns;
			wait;
		end process teste;
END Behavioral;