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
			i_CLK:				in  STD_LOGIC;
			i_RST:				in  STD_LOGIC;
			i_CAFE:				in STD_LOGIC;
			i_CAFE_LEITE:		in STD_LOGIC;
			i_MOCHA: 			in STD_LOGIC;
			i_TAMANHO: 			in STD_LOGIC;
			i_ACUCAR: 			in STD_LOGIC;
			i_PREPARO: 			in STD_LOGIC;
			i_AGUA: 				in STD_LOGIC;
			i_TEMP: 				in STD_LOGIC;
			i_DONE:				in STD_LOGIC;
			i_REPOSICAO:		in STD_LOGIC;
			o_CAFE:				out  STD_LOGIC;
			o_CAFE_LEITE:		out  STD_LOGIC;
			o_MOCHA:				out  STD_LOGIC;
			o_TAMANHO:			out STD_LOGIC;
			o_ACUCAR:			out STD_LOGIC;
			o_PREPARO:			out STD_LOGIC;
			o_REPOSICAO:		out STD_LOGIC
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
			SIGNAL w_OUT_CAFE:		 STD_LOGIC;
			SIGNAL w_OUT_CAFE_LEITE: STD_LOGIC;
			SIGNAL w_OUT_MOCHA:		 STD_LOGIC;
			SIGNAL w_OUT_TAMANHO:	 STD_LOGIC;
			SIGNAL w_OUT_ACUCAR:		 STD_LOGIC;
			SIGNAL w_OUT_PREPARO:	 STD_LOGIC;
			SIGNAL w_OUT_REPOSICAO:	 STD_LOGIC;
	
		
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
			o_CAFE 		 => w_OUT_CAFE,
			o_CAFE_LEITE => w_OUT_CAFE_LEITE,
			o_MOCHA 		 => w_OUT_MOCHA,
			o_TAMANHO 	 => w_OUT_TAMANHO,
			o_ACUCAR 	 => w_OUT_ACUCAR,
			o_PREPARO 	 => w_OUT_PREPARO,
			o_REPOSICAO  => w_OUT_REPOSICAO
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
			w_TAMANHO <= '0';
			w_AGUA <= '0';
			
			wait for 200 ns;
			w_DONE <= '1';
			wait for 40 ns;
			w_DONE <= '0';
			
			
			
		end process teste;
	
	

end behavioral;