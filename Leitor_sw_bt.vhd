library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL; -- USANDO PRA CONVERTER HEHEHE

entity Leitor_sw_bt is
	generic(
				p_DATA				: integer := 5;
				p_ADD 				: integer := 2
	);
    Port ( 
						-- CLOCK E RESET --
				i_CLK					: in  STD_LOGIC;
				i_RST					: in  STD_LOGIC;
						-- SWITCHS E BOTAO PREPARO --
				i_CAFE				: in  STD_LOGIC; -- SWITCH	i_CAFETEIRA
				i_CAFE_LEITE		: in  STD_LOGIC; -- SWITCH	i_CAFETEIRA
				i_MOCHA				: in  STD_LOGIC; -- SWITCH	i_CAFETEIRA
				i_TAMANHO			: in  STD_LOGIC; -- SWITCH	i_CAFETEIRA
				i_ACUCAR				: in  STD_LOGIC; -- SWITCH	i_CAFETEIRA
				i_PREPARO			: in  STD_LOGIC; -- BOTAO		i_CAFETEIRA
						-- "SENSORES" em processo de criacao kkkk
				i_AGUA				: in  STD_LOGIC; -- SINAL
				i_TEMP				: in  STD_LOGIC; -- SINAL
						-- HANDSHAKE --
				i_DONE				: in  STD_LOGIC; -- SINAL		w_SINAL
					-- BOTAO REPOSICAO
				i_REPOSICAO			: in  STD_LOGIC; -- BOTAO DE REPOSICAO	i_CAFETEIRA
				i_REPOSICAO_DONE	: in  STD_LOGIC; -- SINAL DE REPOSICAO TERMINADA	w_SINAL
						-- SAIDAS --
				o_CAFE				: out STD_LOGIC; -- SINAL		w_SINAL
				o_CAFE_LEITE		: out STD_LOGIC; -- SINAL		w_SINAL	
				o_MOCHA				: out STD_LOGIC; -- SINAL	 	w_SINAL
				o_TAMANHO			: out STD_LOGIC; -- SINAL	 	w_SINAL
				o_ACUCAR				: out STD_LOGIC; -- SINAL		w_SINAL
				o_PREPARO			: out STD_LOGIC; -- SINAL		w_SINAL
				o_REPOSICAO			: out STD_LOGIC;	-- i_REPOSICAO do Led_Display		w_SINAL
				
				-- TESTE COM RAM -- 
				o_RAM_ENABLE		: out STD_LOGIC;
				o_RAM_WRITE			: out STD_LOGIC;
				o_DATA_WRITE		: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				o_ADDRESS_RAM		: out STD_LOGIC_VECTOR(p_ADD-1 DOWNTO 0);
				o_DATA_READ			: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				
				-- CAFE LEITE CHOCOLATE --
				
				o_qnt_CAFE			: out integer;
				o_qnt_LEITE 		: out integer;
				o_qnt_CHOCOLATE   : out integer	
	 );
end Leitor_sw_bt;

architecture Behavioral of Leitor_sw_bt is

component RAM is
	Generic(
		p_DATA_WIDTH : INTEGER := 5; -- TAMANHO DO DADO (PRECISO DE 5 BITS)
		p_ADD_WIDTH : INTEGER := 2	-- ENDEREÇO DO DADO "00" (PRECISO DE 4 CAFE "00")/LEITE"01"/CHOCOLATE"10" "11"->agua?)
	);
    Port ( 
				i_CLK		: in std_logic;
				i_RST		: in std_logic;
				i_EN		: in STD_logic;
				i_WR		: in STD_logic;
				i_ADDR	: in STD_LOGIC_vector ((p_ADD_WIDTH-1) downto 0);
			   i_DATA   : in STD_LOGIC_vector ((p_DATA_WIDTH -1) downto 0);
				o_DATA	: out STD_LOGIC_vector ((p_DATA_WIDTH -1) downto 0)
	 );
end component;

-----------------------------------------------------------------------------------------------
	TYPE w_state_type is (st_INIT, st_IDLE, st_PREPARO,st_WAIT, st_UPDATE_MEMORIA,st_UPDATE_MEMORIA_2,st_UPDATE_MEMORIA_3, st_CHECK_INGREDIENTES,st_CHECK_INGREDIENTES_2);
	
	SIGNAL w_state				: w_state_type;
	SIGNAL w_RAM_ENABLE:		 STD_LOGIC;
	SIGNAL w_RAM_WRITE:		 STD_LOGIC;
	SIGNAL w_DATA_WRITE:		 STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	SIGNAL w_ADDRESS_RAM:	 STD_LOGIC_VECTOR(p_ADD-1 DOWNTO 0);
	SIGNAL w_DATA_READ:		 STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	SIGNAL q_CAFE:		INTEGER :=10;		--qntd
	SIGNAL q_LEITE:	INTEGER :=10;		--qntd
	SIGNAL q_CHOCO:	INTEGER :=10;		--qntd
	--SIGNAL q_AGUA:		INTEGER :=1500;	 mL NAO SEI SE VOU USAR
	SIGNAL control:	STD_LOGIC :='0';		-- CONTROLE INIT
	SIGNAL count_clock: integer:=0;			-- controle de clocks
Begin
	-- SOMENTE PARA TB
	o_RAM_ENABLE <= w_RAM_ENABLE;
	o_RAM_WRITE <= w_RAM_WRITE;
	o_DATA_WRITE <= w_DATA_WRITE;
	o_ADDRESS_RAM <= w_ADDRESS_RAM;
	o_DATA_READ <= w_DATA_READ;
	o_qnt_CAFE	 <= q_CAFE;
	o_qnt_LEITE  <= q_LEITE;
	o_qnt_CHOCOLATE <= q_CHOCO;	
	
	------------------------------
	
	U1: RAM
		port map (
			i_CLK => i_CLK,
			i_RST	=> i_RST,
			i_EN	=> w_RAM_ENABLE,	
			i_WR	=> w_RAM_WRITE,	
			i_ADDR => w_ADDRESS_RAM,	
			i_DATA   =>w_DATA_WRITE,
			o_DATA	=>w_DATA_READ
		);
	U_LEITOR : PROCESS(i_CLK, i_RST)
		BEGIN
			IF(i_RST = '0') THEN
				o_PREPARO <= '1';
				--o_REPOSICAO <= '0';

				w_state <= st_INIT;

			ELSIF RISING_EDGE(i_CLK) THEN
				CASE w_state IS
					
					WHEN st_INIT =>
					
						o_PREPARO <= '1'; -- nao vai preparar nada
						o_REPOSICAO <= '1'; -- terminou a repOSICAO
						
						-- QUANTIDADES REPOSTAS
						q_CAFE		<=10;		--qntd
						q_LEITE		<=10;		--qntd
						q_CHOCO		<=10;		--qntd
						--q_AGUA		<=10;		-- doses
						control		<= '1'; --PARA O UPDATE SABER Q VEIO DO INIT
						w_ADDRESS_RAM <= (OTHERS => '0');
						w_DATA_WRITE <= (OTHERS => '0');
						w_RAM_ENABLE <= '0';
						w_RAM_WRITE <= '0';
						
						
						w_state <= st_UPDATE_MEMORIA;
					----------------------------------------------------------------------	
					WHEN st_IDLE =>
					
						o_PREPARO <= '1'; -- terminou o cafe anterior
						
						o_CAFE <= i_CAFE;
						o_CAFE_LEITE <= i_CAFE_LEITE; 
						o_MOCHA <= i_MOCHA;
						
						o_TAMANHO <= i_TAMANHO;
						o_ACUCAR <= i_ACUCAR;
						
						IF(i_PREPARO = '0') THEN
							IF (	(i_CAFE = '0' AND i_CAFE_LEITE = '0' AND i_MOCHA = '1') OR
									(i_CAFE = '1' AND i_CAFE_LEITE = '0' AND i_MOCHA = '0') OR
									(i_CAFE = '0' AND i_CAFE_LEITE = '1' AND i_MOCHA = '0') ) THEN
								w_ADDRESS_RAM <= (OTHERS => '0');
								w_state <= st_CHECK_INGREDIENTES;
							ELSE
								w_state <= st_IDLE;
							END IF;
						ELSE
							w_state <= st_IDLE;
						END IF;
					-- CHECAR INGREDIENTES -----------------------------------------------
					WHEN st_CHECK_INGREDIENTES =>
						IF (count_clock = 0) THEN
							w_RAM_ENABLE <= '1';
							w_RAM_WRITE <= '0';
							count_clock <= 1;
							
						ELSIF (count_clock = 1) THEN
							count_clock <=2;
							
						ELSIF (count_clock = 2) THEN
							w_RAM_ENABLE <= '0';
							
							IF(w_ADDRESS_RAM = "00") THEN
								q_CAFE <= to_integer(unsigned(w_DATA_READ));
								count_clock <= 3;
								
							ELSIF (w_ADDRESS_RAM = "01") THEN
								q_LEITE <= to_integer(unsigned(w_DATA_READ));
								count_clock <= 3;
								
							ELSIF(w_ADDRESS_RAM = "10") THEN
								q_CHOCO <= to_integer(unsigned(w_DATA_READ));
								count_clock <= 3;

							ELSIF(w_ADDRESS_RAM = "11") THEN
								IF( (q_CAFE  < 3 ) or
									 (q_LEITE < 3 ) or
									 (q_CHOCO < 3 ) ) THEN
									 
									 --o_REPOSICAO <= '1';
									 count_clock <= 0;
									 w_state <= st_WAIT;
									 
								ELSE
									count_clock <= 0;
									w_ADDRESS_RAM <= "00";
									w_RAM_ENABLE <= '0';
									w_state <= st_PREPARO;
								END IF;	  
							END IF;
						ELSIF(count_clock = 3) THEN
							w_RAM_ENABLE <= '0';
							w_ADDRESS_RAM <= w_ADDRESS_RAM + 1;
							count_clock <= 0;
						END IF;

					-- ATUALIZAR MEMORIA -------------------------------------------------
					WHEN st_UPDATE_MEMORIA =>
						IF(count_clock = 0) THEN
							IF (w_ADDRESS_RAM = "00") THEN
								w_DATA_WRITE <= std_LOGIC_VECTOR(to_unsigned(q_CAFE,w_DATA_WRITE'length));
								count_clock <= 1;
								
							ELSIF (w_ADDRESS_RAM = "01") THEN
								w_DATA_WRITE <= std_LOGIC_VECTOR(to_unsigned(q_LEITE,w_DATA_WRITE'length));
								count_clock <= 1;
							
							ELSIF (w_ADDRESS_RAM = "10") THEN
								w_DATA_WRITE <= std_LOGIC_VECTOR(to_unsigned(q_CHOCO,w_DATA_WRITE'length));
								count_clock <= 1;
								
							ELSE
								count_clock <= 0;
								w_RAM_ENABLE <= '0';
								w_RAM_WRITE <= '0';
								IF(control = '1') THEN -- SE VEIO DO INIT
									control <= '0';
									w_state <= st_IDLE;
								ELSIF (control = '0') THEN -- SE VEIO DO FLUXO NORMAL DA CAFETEIRA
									w_state <= st_WAIT;
								END IF;
							END IF;
							
						ELSIF (count_clock = 1) THEN
							w_RAM_ENABLE <= '1';
							w_RAM_WRITE <= '1';
							count_clock <= 2;
							
						ELSIF (count_clock = 2) THEN
							w_RAM_ENABLE <= '0';
							w_RAM_WRITE <= '0';
							w_ADDRESS_RAM <= w_ADDRESS_RAM + 1;
							count_clock <= 0;
							
						END IF;
						-- PREPARO ------------------------------------------------------------------------------------------
					WHEN st_PREPARO =>
					
						o_PREPARO <= '0';
					
						IF(i_TAMANHO = '0') THEN
						
							IF(i_CAFE = '0' AND i_CAFE_LEITE = '0' AND i_MOCHA = '1') THEN -- mochaccino
								q_CAFE <= q_CAFE - 1;
								q_CHOCO <= q_CHOCO -1;
							ELSIF(i_CAFE = '1' AND i_CAFE_LEITE = '0' AND i_MOCHA = '0') THEN -- cafe
								q_CAFE <= q_CAFE -1;
							ELSIF(i_CAFE = '0' AND i_CAFE_LEITE = '1' AND i_MOCHA = '0') THEN --cafe c leite
								q_CAFE <= q_CAFE - 1;
								q_LEITE <= q_LEITE -1;
							END IF;
							
						ELSIF(i_TAMANHO = '1') THEN
						
							IF(i_CAFE = '0' AND i_CAFE_LEITE = '0' AND i_MOCHA = '1') THEN -- mochaccino grande
								q_CAFE <= q_CAFE - 2;
								q_CHOCO <= q_CHOCO -2;
							ELSIF(i_CAFE = '1' AND i_CAFE_LEITE = '0' AND i_MOCHA = '0') THEN -- cafe grande
								q_CAFE <= q_CAFE -2;
							ELSIF(i_CAFE = '0' AND i_CAFE_LEITE = '1' AND i_MOCHA = '0') THEN --cafe c leite grande
								q_CAFE <= q_CAFE - 2;
								q_LEITE <= q_LEITE -2;
							END IF;
							
						END IF;
						w_state <= st_UPDATE_MEMORIA;
						--ESPERANDO -------------------------------------------------------------------------------------------
					WHEN st_WAIT =>
						o_REPOSICAO <= i_REPOSICAO;
						o_PREPARO <= '1';
						IF (i_DONE = '1') THEN
							
							w_state <= st_IDLE;
							
						ELSIF (i_REPOSICAO_DONE = '1') THEN
							
							w_state <= st_INIT;
						
						ELSE
							w_state <= st_WAIT;
						END IF;
						------------------------------------------------------------------------------------------
					WHEN OTHERS =>
						w_state <= st_IDLE;
				END CASE;
			END IF;
	END PROCESS;
end Behavioral;