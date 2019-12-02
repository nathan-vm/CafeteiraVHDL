library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity TB_Cafeteira is
end TB_Cafeteira;

architecture Behavioral of TB_Cafeteira is

component Cafeteira is 
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
				o_TESTE				: out STD_LOGIC;
				o_DISPLAY_1			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_2			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_3			: out STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
				o_DISPLAY_4			: out STD_LOGIC_VECTOR (7 DOWNTO 0)  --DISPLAY 7 SEGMENTOS
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
			SIGNAL w_REPOSICAO:		 STD_LOGIC;
			SIGNAL w_OUT_CAFE:		 STD_LOGIC;
			SIGNAL w_OUT_CAFE_LEITE: STD_LOGIC;
			SIGNAL w_OUT_MOCHA:		 STD_LOGIC;
			SIGNAL w_OUT_TAMANHO:	 STD_LOGIC;
			SIGNAL w_OUT_ACUCAR:		 STD_LOGIC;
			SIGNAL w_OUT_PREPARO:	 STD_LOGIC;
			SIGNAL w_OUT_REPOSICAO:	 STD_LOGIC;
			SIGNAL w_OUT_TESTE:		 STD_LOGIC;
			SIGNAL w_OUT_DISPLAY_1:	 STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
			SIGNAL w_OUT_DISPLAY_2:	 STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
			SIGNAL w_OUT_DISPLAY_3:	 STD_LOGIC_VECTOR (7 DOWNTO 0); --DISPLAY 7 SEGMENTOS
			SIGNAL w_OUT_DISPLAY_4:  STD_LOGIC_VECTOR (7 DOWNTO 0);  --DISPLAY 7 SEGMENTOS

	
		
	begin
	
	Utt: Cafeteira
			port map(
			i_CLK 		 => w_CLK,
			i_RST 		 => w_RST,
			i_CAFE 		 => w_CAFE,
			i_CAFE_LEITE => w_CAFE_LEITE,
			i_MOCHA 		 => w_MOCHA,
			i_TAMANHO 	 => w_TAMANHO,
			i_ACUCAR 	 => w_ACUCAR,
			i_PREPARO 	 => w_PREPARO,
			i_REPOSICAO  => w_REPOSICAO,
			
			o_CAFE 		 => w_OUT_CAFE,
			o_CAFE_LEITE => w_OUT_CAFE_LEITE,
			o_MOCHA 		 => w_OUT_MOCHA,
			o_TAMANHO 	 => w_OUT_TAMANHO,
			o_ACUCAR 	 => w_OUT_ACUCAR,
			o_PREPARO 	 => w_OUT_PREPARO,
			o_REPOSICAO  => w_OUT_REPOSICAO,
			o_TESTE		 => w_OUT_TESTE,
			o_DISPLAY_1	 => w_OUT_DISPLAY_1,
			o_DISPLAY_2	 => w_OUT_DISPLAY_2,
			o_DISPLAY_3	 => w_OUT_DISPLAY_3,
			o_DISPLAY_4	 => w_OUT_DISPLAY_4
			
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
			w_CAFE <= '1';
			w_CAFE_LEITE <= '0';
			w_MOCHA <= '0';
			w_ACUCAR <= '0';
			w_TAMANHO <= '0';
			w_PREPARO <= '1';
			
			wait for 2000 ns;
			WAIT;
--			w_CAFE <= '0';
--			w_CAFE_LEITE <= '1';
--			w_MOCHA <= '0';
--			w_ACUCAR <= '0';
--			w_TAMANHO <= '0';
--			w_PREPARO <= '1';
--			
--			wait for 20 ns;
--			
--			w_CAFE <= '0';
--			w_CAFE_LEITE <= '0';
--			w_MOCHA <= '0';
--			w_ACUCAR <= '0';
--			w_TAMANHO <= '1';
--			w_PREPARO <= '1';
--			
--			wait for 20 ns;
--			wait;
		end process teste;
	
	

end behavioral;