library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity Led_Display is
    Port ( 
				i_CLK 				: in STD_LOGIC;
				i_RST 				: in STD_LOGIC;
				
				i_CAFE  				: in STD_LOGIC;
				i_CAFE_LEITE		: in STD_LOGIC;
				i_MOCHA				: in STD_LOGIC;
				
				i_TAMANHO			: in STD_LOGIC;
				i_ACUCAR				: in STD_LOGIC;
				i_PREPARO			: in STD_LOGIC;
				i_REPOSICAO			: in STD_LOGIC;
				
				
				o_CAFE  				: out STD_LOGIC;
				o_CAFE_LEITE		: out STD_LOGIC;
				o_MOCHA				: out STD_LOGIC;
				o_TAMANHO			: out STD_LOGIC;
				o_ACUCAR				: out STD_LOGIC;
				
				o_PREPARANDO		: out STD_LOGIC;
				o_REPOSICAO			: out STD_LOGIC;
				o_FIM_PREPARO		: out STD_LOGIC;
				
				o_PREPARO_DONE		: out STD_LOGIC;
				o_REPOSICAO_DONE	: out STD_LOGIC;
				o_TIMER_DONE		: out STD_LOGIC;
				
				
				o_SECONDS			: out INTEGER;
				o_TIMER_ENABLE		: out STD_LOGIC;
				i_TIMER_DONE		: in STD_LOGIC;
				
				o_DISPLAY_DATA		: out STD_LOGIC_VECTOR (3 DOWNTO 0);
				o_DISPLAY_ENABLE	: out STD_LOGIC
				
								
	 );
end MAQUINA_LEDS;


architecture Behavioral of Led_Display is
	
	TYPE w_state_type is (st_IDLE, st_REPOSICAO, st_PREPARO, st_CALCTIME);

	ATTRIBUTE syn_encoding : string;
	ATTRIBUTE syn_encoding OF w_state_type : TYPE IS "safe";
	
	SIGNAL w_state				: w_state_type;
	
	SIGNAL w_control_count  : STD_LOGIC_VECTOR(3 DOWNTO 0);
--	SIGNAL w_pressed			: STD_LOGIC;
--	SIGNAL w_tempAdd			: STD_LOGIC_VECTOR(p_ADD-1 DOWNTO 0);
--	SIGNAL w_control_count  : STD_LOGIC_VECTOR(3 DOWNTO 0);
--	SIGNAL w_data_write		: STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0) := (OTHERS => '0');
	
begin

o_CAFE <= i_CAFE;
o_CAFE_LEITE <= i_CAFE_LEITE;
o_MOCHA <= i_MOCHA;
o_TAMANHO <= i_TAMANHO;
o_ACUCAR <= i_ACUCAR;
o_PREPARANDO <= i_PREPARO;
o_REPOSICAO <= i_REPOSICAO;


U_MACHINE : PROCESS(i_CLK, i_RST)
	BEGIN
		IF(i_RST = '1') THEN
			w_state <= st_IDLE;
			
		ELSIF RISING_EDGE (i_CLK) THEN
		
			CASE w_state IS
				WHEN st_IDLE =>
					o_REPOSICAO_DONE <= '0';
					IF(i_REPOSICAO = '1') THEN
						w_state <= st_REPOSICAO;
					ELSIF(i_PREPARO = '1') THEN
						w_state <= st_CALCTIME;
					END IF;
					
				WHEN st_REPOSICAO =>
					o_SECONDS <= 10;
					o_TIMER_ENABLE <= '1';
					IF(i_TIMER_DONE = '1') THEN
						o_TIMER_ENABLE <= '0';
						o_REPOSICAO_DONE <= '1';
						w_state <= st_IDLE;
					END IF;
					
				WHEN st_PREPARO =>
					
					IF (i_TIMER_DONE = '1') THEN
						IF (w_control_count = "0000") THEN
							o_SECONDS <= 5;
							w_control_count <= "0001";
							o_DISPLAY_DATA <= "0010";
						ELSIF (w_control_count = "0001") THEN
							o_TIMER_ENABLE <= '0';
							o_PREPARO_DONE <= '1';
							o_DISPLAY_ENABLE <= '0';
							w_control_count <= "0010";
							
						ELSE 
							w_control_count <= w_control_count + 1;
						END IF;
					ELSE 
						IF (w_control_count = "0000") THEN
							o_DISPLAY_DATA <= "0001";
							o_TIMER_ENABLE <= '1';
							o_DISPLAY_ENABLE <= '1';
						ELSIF (w_control_count = "0010") THEN
							o_PREPARO_DONE <= '0';
							w_state <= st_IDLE;
						END IF;
					END IF;
					
				WHEN st_CALCTIME =>
					w_control_count <= "0000";
					IF(i_TAMANHO = '1') THEN
						IF(i_CAFE = '1') THEN
							o_SECONDS <= 11 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						ELSIF(i_CAFE_LEITE = '1') THEN
							o_SECONDS <= 12 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						ELSE
							o_SECONDS <= 13 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						END IF;
					ELSE
						IF(i_CAFE = '1') THEN
							o_SECONDS <= 6 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						ELSIF(i_CAFE_LEITE = '1') THEN
							o_SECONDS <= 7 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						ELSE
							o_SECONDS <= 8 + (1 - to_integer(unsigned'('0' & i_ACUCAR)));
						END IF;
					END IF;
					w_state <= ST_PREPARO;
				WHEN OTHERS =>
					w_state <= st_IDLE;
			END CASE;
		END IF;
	END PROCESS;

end Behavioral;