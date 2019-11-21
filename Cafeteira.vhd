library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity Cafeteira is 
	PORT(
	i_CLK:				in  STD_LOGIC;
	i_RST:				in  STD_LOGIC;
	-- ENTRADAS --
	i_CAFE:				in STD_LOGIC; -- SWITCH
	i_CAFE_LEITE:		in STD_LOGIC; -- SWITCH
	i_MOCHA: 			in STD_LOGIC; -- SWITCH
	i_TAMANHO: 			in STD_LOGIC; -- SWITCH
	i_ACUCAR: 			in STD_LOGIC; -- SWITCH
	
	i_PREPARO: 			in STD_LOGIC; -- BOTAO
	i_REPOSICAO:		in STD_LOGIC; -- BOTAO DE REPOSICAO
	
	-- SAIDAS --
	o_CAFE:				out  STD_LOGIC; -- LED
	o_CAFE_LEITE:		out  STD_LOGIC; -- LED
	o_MOCHA:				out  STD_LOGIC; -- LED
	o_TAMANHO:			out STD_LOGIC; -- LED
	o_ACUCAR:			out STD_LOGIC; -- LED
	o_PREPARO:			out STD_LOGIC; -- LED PISCANDO
	o_REPOSICAO:		out STD_LOGIC	-- LED
	);
end Cafeteira;

architecture Behavioral of Cafeteira is
--COMPONENTES :

-- MAQUINA Leitor_sw_bt:
component Leitor_sw_bt is
	generic(
		p_DATA : integer := 5;
		p_ADD : integer := 2
	);
    Port ( 
				-- CLOCK E RESET --
		i_CLK:				in  STD_LOGIC;
		i_RST:				in  STD_LOGIC;
				-- SWITCHS E BOTAO PREPARO --
		i_CAFE:				in STD_LOGIC; -- SWITCH
		i_CAFE_LEITE:		in STD_LOGIC; -- SWITCH
		i_MOCHA: 			in STD_LOGIC; -- SWITCH
		i_TAMANHO: 			in STD_LOGIC; -- SWITCH
		i_ACUCAR: 			in STD_LOGIC; -- SWITCH
		i_PREPARO: 			in STD_LOGIC; -- BOTAO
				-- "SENSORES" em processo de criacao kkkk
		i_AGUA: 				in STD_LOGIC; -- SINAL
		i_TEMP: 				in STD_LOGIC; -- SINAL
				-- HANDSHAKE --
		i_DONE:				in STD_LOGIC; --SINAL
			-- BOTAO REPOSICAO
		i_REPOSICAO:		in STD_LOGIC; -- BOTAO DE REPOSICAO
		i_REPOSICAO_DONE 	:in STD_LOGIC; -- SINAL DE REPOSICAO TERMINADA
				-- SAIDAS --
		o_CAFE:				out  STD_LOGIC; -- SINAL
		o_CAFE_LEITE:		out  STD_LOGIC; -- SINAL
		o_MOCHA:				out  STD_LOGIC; -- SINAL
		o_TAMANHO:			out STD_LOGIC; -- SINAL
		o_ACUCAR:			out STD_LOGIC; -- SINAL
		o_PREPARO:			out STD_LOGIC; -- SINAL
		o_REPOSICAO:		out STD_LOGIC	-- i_REPOSICAO do Led_Display
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
				o_FIM_PREPARO		: out STD_LOGIC; -- SINAL
					-- SAIDAS PARA A MAQUINA SWITCH BOTAO
				o_PREPARO_DONE		: out STD_LOGIC; -- SINAL
				o_REPOSICAO_DONE	: out STD_LOGIC; -- SINAL i_REPOSICAO Leitor_sw_bt
				o_TIMER_DONE		: out STD_LOGIC; -- SINAL
				
				w_DISPLAY_1			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				w_DISPLAY_2			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				w_DISPLAY_3			: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				w_DISPLAY_4			: out STD_LOGIC_VECTOR (7 DOWNTO 0)				
	 );
end component;

begin
end Behavioral;