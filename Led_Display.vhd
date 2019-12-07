library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity Led_Display is
    Port ( 
				i_CLK 				: in STD_LOGIC;
				i_RST 				: in STD_LOGIC; -- BOTAO 
				-- ENTRADAS VINDA DA MAQUINA SWITCH BOTAO :
				i_CAFE  				: in STD_LOGIC; -- SWITCH
				i_CAFE_LEITE		: in STD_LOGIC; -- SWITCH
				i_MOCHA				: in STD_LOGIC; -- SWITCH
				
				i_TAMANHO			: in STD_LOGIC; -- SWITCH
				i_ACUCAR				: in STD_LOGIC; -- SWITCH
				i_PREPARO			: in STD_LOGIC; -- BOTAO
				
				i_REPOSICAO			: in STD_LOGIC; -- BOTAO SINAL o_REPOSICAO
				-- SAIDAS PARA OS LEDS 
				o_CAFE  				: out STD_LOGIC; -- LED
				o_CAFE_LEITE		: out STD_LOGIC; -- LED
				o_MOCHA				: out STD_LOGIC; -- LED
				o_TAMANHO			: out STD_LOGIC; -- LED
				o_ACUCAR				: out STD_LOGIC; -- LED
				
				o_PREPARANDO		: out STD_LOGIC; -- LED PISCANDO 
				o_REPOSICAO			: out STD_LOGIC; -- LED
				
				-- SAIDAS PARA A MAQUINA SWITCH BOTAO
				o_PREPARO_DONE		: out STD_LOGIC; -- SINAL
				o_REPOSICAO_DONE	: out STD_LOGIC; -- SINAL i_REPOSICAO Leitor_sw_bt
				
				o_DISPLAY_1 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_2 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_3 : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_4 : out STD_LOGIC_VECTOR (7 DOWNTO 0)
	 );
end Led_Display;


architecture Behavioral of Led_Display is
	
	TYPE w_state_type is (st_IDLE, st_REPOSICAO, st_PREPARO, st_CALCTIME);
	
	SIGNAL w_state				: w_state_type;
	-- COMPONENTE TIMER
	component Timer is
    Port ( 
			i_CLK 	: in std_logic;
			i_RST		: in std_logic;
			i_SEC		: in integer;
			i_EN		: in std_logic;
			o_DONE	: out std_logic
	 );
	end component;
	-- COMPONENTE DISPLAY
	component Display is
    Port ( 
			i_data 			:IN STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Slide Switch 
			i_enable			:IN STD_LOGIC;
			o_display1 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display2 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display3 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display4 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	 );
	end component;
	
	-- SINAIS TIMER
	SIGNAL w_SEC_TIMER : INTEGER;
	SIGNAL w_EN_TIMER : STD_LOGIC;
	SIGNAL w_DONE_TIMER : STD_LOGIC;
	
	-- SINAIS DISPLAY
	SIGNAL w_DATA_DISPLAY : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL w_EN_DISPLAY : STD_LOGIC;
	
	-- CONTADOR DE CLOCKS
	SIGNAL w_control_count : std_LOGIC_VECTOR (3 downto 0);
	
begin
-- RELACAO Leitor_sw_bt - Led_Display
o_CAFE <= i_CAFE;
o_CAFE_LEITE <= i_CAFE_LEITE;
o_MOCHA <= i_MOCHA;
o_TAMANHO <= i_TAMANHO;
o_ACUCAR <= i_ACUCAR;
o_PREPARANDO <= i_PREPARO;
o_REPOSICAO <= i_REPOSICAO;

	-- PORT MAP TIMER --
U_TIMER : TIMER
	port map (
	i_CLK => i_CLK,
	i_RST => i_RST,
	i_SEC => w_SEC_TIMER,
	i_EN	=> w_EN_TIMER,
	o_DONE=> w_DONE_TIMER
	);
	-- PORT MAP DISPLAY 7 SEGNMENTOS --
U_DISPLAY : DISPLAY
	Port map ( 
			i_data 			=> w_DATA_DISPLAY,
			i_enable			=> w_EN_DISPLAY,
			o_display1 		=> o_DISPLAY_1,
			o_display2 		=> o_DISPLAY_2,
			o_display3 		=> o_DISPLAY_3,
			o_display4 		=> o_DISPLAY_4
	 );
	-- PROCESSO MAQUINA 
U_LED_DISPLAY : PROCESS(i_CLK, i_RST)
	BEGIN
		IF(i_RST = '0') THEN
			w_state <= st_IDLE;
			
		ELSIF RISING_EDGE (i_CLK) THEN
		
			CASE w_state IS
				WHEN st_IDLE =>
					o_REPOSICAO_DONE <= '0';
					IF(i_REPOSICAO = '0') THEN -- SINAL VINDO DA SWITCH_BOTAO
						w_state <= st_REPOSICAO;
					ELSIF(i_PREPARO = '0') THEN -- SINAL VINDO DA SWITCH_BOTAO
						w_state <= st_CALCTIME;
					END IF;
					
				WHEN st_REPOSICAO =>
					w_SEC_TIMER <= 10;
					w_EN_TIMER <= '1';
					IF(w_DONE_TIMER = '1') THEN
						w_EN_TIMER <= '0';
						o_REPOSICAO_DONE <= '1'; -- SINAL DE SAIDA PARA SWITCH_BOTAO
						w_state <= st_IDLE;
					END IF;
					
				WHEN st_PREPARO =>
					
					IF (w_DONE_TIMER = '1') THEN
						IF (w_control_count = "0000") THEN
							w_SEC_TIMER <= 5;
							w_control_count <= "0001";
							w_DATA_DISPLAY <= "0010";
						ELSIF (w_control_count = "0001") THEN
							w_EN_TIMER <= '0';
							o_PREPARO_DONE <= '1';
							w_EN_DISPLAY <= '0';
							w_control_count <= "0010";
							
						ELSE 
							w_control_count <= w_control_count + 1;
						END IF;
					ELSE 
						IF (w_control_count = "0000") THEN
							w_DATA_DISPLAY <= "0001";
							w_EN_TIMER <= '1';
							w_EN_DISPLAY <= '1';
						ELSIF (w_control_count = "0010") THEN
							o_PREPARO_DONE <= '0';
							w_state <= st_IDLE;
						END IF;
					END IF;
					
				WHEN st_CALCTIME =>
					w_control_count <= "0000";
					IF(i_TAMANHO = '1') THEN
						IF(i_CAFE = '1') THEN
							w_SEC_TIMER <= 10;
						ELSIF(i_CAFE_LEITE = '1') THEN
							w_SEC_TIMER <= 10;
						ELSE
							w_SEC_TIMER <= 10;
						END IF;
					ELSE
						IF(i_CAFE = '1') THEN
							w_SEC_TIMER <= 5;
						ELSIF(i_CAFE_LEITE = '1') THEN
							w_SEC_TIMER <= 5;
						ELSE
							w_SEC_TIMER <= 5;
						END IF;
					END IF;
					
					w_state <= ST_PREPARO;
					
				WHEN OTHERS =>
				
					w_state <= st_IDLE;
					
					
			END CASE;
		END IF;
	END PROCESS;

end Behavioral;