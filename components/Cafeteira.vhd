library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity Cafeteira is 
	PORT(
				i_CLK					: in  STD_LOGIC;
				i_RST					: in  STD_LOGIC;
				-- ENTRADAS --
				i_CAFE				: in  STD_LOGIC; -- SWITCH
				i_CAFE_LEITE		: in  STD_LOGIC; -- SWITCH
				i_MOCHA				: in  STD_LOGIC; -- SWITCH
				i_TAMANHO			: in  STD_LOGIC; -- SWITCH
				i_ACUCAR				: in  STD_LOGIC; -- SWITCH
				
				i_PREPARO			: in  STD_LOGIC; -- BOTAO
				i_REPOSICAO			: in  STD_LOGIC; -- BOTAO DE REPOSICAO
				
				-- SAIDAS --
				o_CAFE				: out STD_LOGIC; -- LED
				o_CAFE_LEITE		: out STD_LOGIC; -- LED
				o_MOCHA				: out STD_LOGIC; -- LED
				o_TAMANHO			: out STD_LOGIC; -- LED
				o_ACUCAR				: out STD_LOGIC; -- LED
				o_PREPARO			: out STD_LOGIC; -- LED PISCANDO
				o_REPOSICAO			: out STD_LOGIC;	-- LED
				o_DISPLAY_1			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_2			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_3			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_4			: out STD_LOGIC_VECTOR (7 DOWNTO 0)  --DISPLAY 7 SEGMENTOS
	);
end Cafeteira;

architecture Behavioral of Cafeteira is

--COMPONENTES :

-- MAQUINA Leitor_sw_bt:
component Leitor_sw_bt is
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
				o_REPOSICAO			: out STD_LOGIC	-- i_REPOSICAO do Led_Display		w_SINAL
	 );
end component;

--MAQUINA Led_Display:

component Led_Display is
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
				o_REPOSICAO_DONE	: out STD_LOGIC; -- SINAL i_REPOSICAO_DONE Leitor_sw_bt

				o_DISPLAY_1			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_2			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_3			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_4			: out STD_LOGIC_VECTOR (7 DOWNTO 0)				
	 );
end component;
		-- sinais de entrada invertidos
		signal w_i_RST				: std_LOGIC ;
		signal w_i_PREPARO		: std_LOGIC ;
		signal w_i_REPOSICAO		: std_LOGIC ;
		--SAIDAS Leitor_sw_bt/ENTRADAS Led_Display
		signal w_CAFE 				: std_LOGIC; --switch
		signal w_CAFE_LEITE 		: std_LOGIC; --switch
		signal w_MOCHA 			: std_LOGIC; --switch
		signal w_TAMANHO 			: std_LOGIC; --switch
		signal w_ACUCAR 			: std_LOGIC; --switch
		signal w_PREPARO 			: std_LOGIC; --botao
		--HANDSHAKE--
		signal w_DONE 				: std_LOGIC; --sinal
		signal w_REPOSICAO_DONE : std_LOGIC; --sinal
		signal w_REPOSICAO 		: std_LOGIC; --sinal 
		--NAO IMPLEMENTADO AINDA--
		signal w_AGUA				: std_LOGIC; --NAO IMPLEMENTADO
		signal w_TEMP				: std_LOGIC; --NAO IMPLEMENTADO
begin
	
	U_1: Leitor_sw_bt
	Port map(
			i_CLK					=> i_CLK,				--CAFETEIRA
			i_RST					=> i_RST,				--CAFETEIRA
			i_CAFE				=> i_CAFE,				--CAFETEIRA
			i_CAFE_LEITE		=> i_CAFE_LEITE,		--CAFETEIRA
			i_MOCHA				=> i_MOCHA,				--CAFETEIRA
			i_TAMANHO			=> i_TAMANHO,			--CAFETEIRA
			i_ACUCAR				=> i_ACUCAR,			--CAFETEIRA
			i_PREPARO			=> i_PREPARO,			--CAFETEIRA
			i_REPOSICAO			=> i_REPOSICAO,		--CAFETEIRA
			
			i_AGUA				=> w_AGUA, 				--NAO IMPLEMENTADO
			i_TEMP				=> w_TEMP, 				--NAO IMPLEMENTADO
					
			i_REPOSICAO_DONE	=> w_REPOSICAO_DONE,	--SINAL ENTRADA
			i_DONE				=> w_DONE,				--SINAL ENTRADA
			
			o_CAFE				=> w_CAFE,				--SINAL SAIDA
			o_CAFE_LEITE		=> w_CAFE_LEITE,		--SINAL SAIDA
			o_MOCHA				=> w_MOCHA,				--SINAL SAIDA
			o_TAMANHO			=> w_TAMANHO,			--SINAL SAIDA
			o_ACUCAR				=> w_ACUCAR,			--SINAL SAIDA
			o_PREPARO			=> w_PREPARO,			--SINAL SAIDA
			o_REPOSICAO			=> w_REPOSICAO			--SINAL SAIDA
	);

	U_2: Led_Display
	Port Map(
			i_CLK					=> i_CLK,				--CAFETEIRA
			i_RST					=> w_i_RST,				--CAFETEIRA
					
			i_CAFE				=> w_CAFE,				--SINAL ENTRADA
			i_CAFE_LEITE		=> w_CAFE_LEITE,		--SINAL ENTRADA
			i_MOCHA				=> w_MOCHA,				--SINAL ENTRADA
			i_TAMANHO			=> w_TAMANHO,			--SINAL ENTRADA
			i_ACUCAR				=> w_ACUCAR,			--SINAL ENTRADA
			i_PREPARO			=> w_PREPARO,			--SINAL ENTRADA
			i_REPOSICAO			=> w_REPOSICAO,		--SINAL ENTRADA

			o_CAFE				=> o_CAFE,				--CAFETEIRA
			o_CAFE_LEITE		=> o_CAFE_LEITE,		--CAFETEIRA
			o_MOCHA				=> o_MOCHA,				--CAFETEIRA
			o_TAMANHO			=> o_TAMANHO,			--CAFETEIRA
			o_ACUCAR				=> o_ACUCAR,			--CAFETEIRA
			o_PREPARANDO		=> o_PREPARO,			--CAFETEIRA
			o_REPOSICAO			=> o_REPOSICAO,		--CAFETEIRA
			
			o_PREPARO_DONE		=> w_DONE,				--SINAL SAIDA
			o_REPOSICAO_DONE	=> w_REPOSICAO_DONE,	--SINAL SAIDA
			
			o_DISPLAY_1			=> o_DISPLAY_1,		--CAFETEIRA
			o_DISPLAY_2			=> o_DISPLAY_2,		--CAFETEIRA
			o_DISPLAY_3			=> o_DISPLAY_3,		--CAFETEIRA
			o_DISPLAY_4			=> o_DISPLAY_4			--CAFETEIRA
	);
end Behavioral;