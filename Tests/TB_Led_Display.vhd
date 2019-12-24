library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity TB_Led_Display is
end TB_Led_Display;

architecture Behavioral of TB_Led_Display is

COMPONENT Led_Display is
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
				
				o_DISPLAY_1 		: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_2 		: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_3 		: out STD_LOGIC_VECTOR (7 DOWNTO 0);
				o_DISPLAY_4 		: out STD_LOGIC_VECTOR (7 DOWNTO 0)
	 );
END COMPONENT;

				SIGNAL w_CLK 		: STD_LOGIC;
				SIGNAL w_RST 		: STD_LOGIC; -- BOTAO 
				SIGNAL w_CAFE  	: STD_LOGIC; -- SWITCH
				SIGNAL w_CAFE_LEITE:STD_LOGIC; -- SWITCH
				SIGNAL w_MOCHA		: STD_LOGIC; -- SWITCH
				SIGNAL w_TAMANHO	: STD_LOGIC; -- SWITCH
				SIGNAL w_ACUCAR	: STD_LOGIC; -- SWITCH
				SIGNAL w_PREPARO	: STD_LOGIC; -- BOTAO
				SIGNAL w_REPOSICAO: STD_LOGIC; -- BOTAO SINAL o_REPOSICAO
				SIGNAL w_OUT_CAFE  	: STD_LOGIC; -- LED
				SIGNAL w_OUT_CAFE_LEITE:STD_LOGIC; -- LED
				SIGNAL w_OUT_MOCHA		: STD_LOGIC; -- LED
				SIGNAL w_OUT_TAMANHO	: STD_LOGIC; -- LED
				SIGNAL w_OUT_ACUCAR	: STD_LOGIC; -- LED
				
				SIGNAL w_PREPARANDO:STD_LOGIC; -- LED PISCANDO 
				SIGNAL w_OUT_REPOSICAO: STD_LOGIC; -- LED
				
				-- SAIDAS PARA A MAQUINA SWITCH BOTAO
				SIGNAL w_PREPARO_DONE:STD_LOGIC; -- SINAL
				SIGNAL w_REPOSICAO_DONE:STD_LOGIC; -- SINAL i_REPOSICAO Leitor_sw_bt
				
				SIGNAL w_DISPLAY_1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
				SIGNAL w_DISPLAY_2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
				SIGNAL w_DISPLAY_3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
				SIGNAL w_DISPLAY_4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
begin

UTT:Led_Display
Port map(
	i_CLK => w_CLK,
	i_RST => w_RST,
	i_CAFE => w_CAFE,
	i_CAFE_LEITE => w_CAFE_LEITE,
	i_MOCHA => w_MOCHA,
	i_ACUCAR => w_ACUCAR,
	i_TAMANHO => w_TAMANHO,
	i_PREPARO => w_PREPARO,
	i_REPOSICAO => w_REPOSICAO,
	o_CAFE => w_OUT_CAFE,
	o_CAFE_LEITE => w_OUT_CAFE_LEITE,
	o_MOCHA => w_OUT_MOCHA,
	o_ACUCAR => w_OUT_ACUCAR,
	o_TAMANHO => w_OUT_TAMANHO,
	o_PREPARANDO => w_PREPARANDO,
	o_PREPARO_DONE => w_PREPARO_DONE,
	o_REPOSICAO => w_OUT_REPOSICAO,
	o_REPOSICAO_DONE => w_REPOSICAO_DONE,
	o_DISPLAY_1 => w_DISPLAY_1,
	o_DISPLAY_2 => w_DISPLAY_2,
	o_DISPLAY_3 => w_DISPLAY_3,
	o_DISPLAY_4 => w_DISPLAY_4
);

		--processo clock
		p_clock : process
			begin
			w_CLK <='0';
			wait for 10 ns;
			w_CLK <= '1';
			wait for 10 ns;
		end process p_clock;
		-------------------
		--PROCESSO TESTE
		teste : process
			begin
			w_CAFE <= '0';
			w_CAFE_LEITE <= '1';
			w_MOCHA <= '0';
			w_TAMANHO <= '0';
			w_PREPARO <= '1';
			wait;
			
			
		end process teste;
end Behavioral;