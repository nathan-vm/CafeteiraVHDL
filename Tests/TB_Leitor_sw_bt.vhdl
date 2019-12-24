library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Leitor_sw_bt is
end TB_Leitor_sw_bt;

architecture Behavioral of TB_Leitor_sw_bt is

	component Leitor_sw_bt is
		generic(
			p_DATA : integer := 5;
			p_ADD : integer := 2
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
				
				o_RAM_ENABLE		: out STD_LOGIC;
				o_RAM_WRITE			: out STD_LOGIC;
				o_DATA_WRITE		: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				o_ADDRESS_RAM		: out STD_LOGIC_VECTOR(p_ADD-1 DOWNTO 0);
				o_DATA_READ			: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				
				o_qnt_CAFE			: out integer;
				o_qnt_LEITE 		: out integer;
				o_qnt_CHOCOLATE   : out integer
		 );
	end component;
		
			SIGNAL w_CLK:				 STD_LOGIC;
			SIGNAL w_RST:				 STD_LOGIC;
			
			SIGNAL w_CAFE:				 STD_LOGIC;
			SIGNAL w_CAFE_LEITE:		 STD_LOGIC;
			SIGNAL w_MOCHA: 			 STD_LOGIC;
			SIGNAL w_TAMANHO: 		 STD_LOGIC;
			SIGNAL w_ACUCAR: 			 STD_LOGIC;
			SIGNAL w_PREPARO: 		 STD_LOGIC;
			
			SIGNAL w_AGUA: 			 STD_LOGIC;
			SIGNAL w_TEMP: 			 STD_LOGIC;
			
			SIGNAL w_DONE:				 STD_LOGIC;
			
			SIGNAL w_REPOSICAO:		 STD_LOGIC;
			SIGNAL w_REPOSICAO_DONE: STD_LOGIC;
			
			SIGNAL w_OUT_CAFE:		 STD_LOGIC;
			SIGNAL w_OUT_CAFE_LEITE: STD_LOGIC;
			SIGNAL w_OUT_MOCHA:		 STD_LOGIC;
			SIGNAL w_OUT_TAMANHO:	 STD_LOGIC;
			SIGNAL w_OUT_ACUCAR:		 STD_LOGIC;
			SIGNAL w_OUT_PREPARO:	 STD_LOGIC;
			SIGNAL w_OUT_REPOSICAO:	 STD_LOGIC;
			-- PRECISA DESCOMENTAR NO CODIGO PRINCIPAL --
			SIGNAL w_RAM_ENABLE:		 STD_LOGIC;
			SIGNAL w_RAM_WRITE:		 STD_LOGIC;
			SIGNAL w_DATA_WRITE:		 STD_LOGIC_VECTOR(5-1 DOWNTO 0);
			SIGNAL w_ADDRESS_RAM:	 STD_LOGIC_VECTOR(2-1 DOWNTO 0);
			SIGNAL w_DATA_READ:		 STD_LOGIC_VECTOR(5-1 DOWNTO 0);
			
			SIGNAL w_qnt_CAFE			: integer;
			SIGNAL w_qnt_LEITE 		: integer;
			SIGNAL w_qnt_CHOCOLATE  : integer;	
	
		
	begin
	
	Utt: Leitor_sw_bt
			port map(
			i_CLK 		 => w_CLK,
			i_RST 		 => w_RST,
			
			i_CAFE 		 => w_CAFE,
			i_CAFE_LEITE => w_CAFE_LEITE,
			i_MOCHA 		 => w_MOCHA,
			i_TAMANHO 	 => w_TAMANHO,
			i_ACUCAR 	 => w_ACUCAR,
			i_PREPARO 	 => w_PREPARO,
			
			i_AGUA 		 => w_AGUA,
			i_TEMP 		 => w_TEMP,
			
			i_DONE 		 => w_DONE,
			i_REPOSICAO  => w_REPOSICAO,
			i_REPOSICAO_DONE => w_REPOSICAO_DONE,
			
			o_CAFE 		 => w_OUT_CAFE,
			o_CAFE_LEITE => w_OUT_CAFE_LEITE,
			o_MOCHA 		 => w_OUT_MOCHA,
			o_TAMANHO 	 => w_OUT_TAMANHO,
			o_ACUCAR 	 => w_OUT_ACUCAR,
			o_PREPARO 	 => w_OUT_PREPARO,
			o_REPOSICAO  => w_OUT_REPOSICAO,
			o_RAM_ENABLE => w_RAM_ENABLE,
			o_RAM_WRITE  => w_RAM_WRITE,
			o_DATA_WRITE => w_DATA_WRITE,
			o_ADDRESS_RAM=> w_ADDRESS_RAM,
			o_DATA_READ  => w_DATA_READ,
			
			o_qnt_CAFE	 => w_qnt_CAFE,
			o_qnt_LEITE  => w_qnt_LEITE,
			o_qnt_CHOCOLATE => w_qnt_CHOCOLATE	
			);
			
	
		--processo clock
		p_clock : process
			begin
			w_CLK <='0';
			wait for 10 ns;
			w_CLK <= '1';
			wait for 10 ns;
		end process p_clock;
		
		--PROCESSO TESTE
		teste : process
			begin
			w_CAFE <= '0';
			w_CAFE_LEITE <= '1';
			w_MOCHA <= '0';
			w_TAMANHO <= '0';
			w_AGUA <= '0';
			w_PREPARO <= '1';
			
			wait for 200 ns;
			w_DONE <= '1';
			wait for 40 ns;
			w_DONE <= '0';
			wait;
			
			
		end process teste;
	
	

end behavioral;