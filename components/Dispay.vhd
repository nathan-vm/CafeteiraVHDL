library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity Display is
    Port ( 
			i_data 			:IN STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Slide Switch 
			i_enable			:IN STD_LOGIC;
			o_display1 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display2 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display3 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			o_display4 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	 );
end Display;


architecture Behavioral of Display is

begin

	PROCESS(i_data, i_enable)
	BEGIN
		IF (i_enable = '1') THEN
			CASE i_data IS 
				WHEN "0000" => --- Mostrando nada
					o_display1 <= "11111111"; ---apagado 
					o_display2 <= "11111111"; ---apagado 
					o_display3 <= "11111111"; ---apagado 
					o_display4 <= "11111111"; ---apagado 
				
				WHEN "0001" => --- MOSTRANDO WAIT
					o_display1 <= "11000111"; ---u
					o_display2 <= "00010001"; ---a 
					o_display3 <= "11110111"; ---i 
					o_display4 <= "11100001"; ---t 
				
				WHEN "0010" => --- MOSTRANDO DONE
					o_display1 <= "10000101"; ---d
					o_display2 <= "11000101"; ---o 
					o_display3 <= "11010101"; ---n 
					o_display4 <= "01100001"; ---e 


--				WHEN "0000" =>
--					o_display <= "00000011"; ---0 
--				WHEN "0001" =>
--					o_display <= "10011111"; ---1 
--				WHEN "0010" =>
--					o_display <= "00100101"; ---2 
--				WHEN "0011" =>
--					o_display <= "00001101"; ---3 
--				WHEN "0100" =>
--					o_display <= "10011001"; ---4 
--				WHEN "0101" =>
--					o_display <= "01001001"; ---5 
--				WHEN "0110" =>
--					o_display <= "01000001"; ---6 
--				WHEN "0111" =>
--					o_display <= "00011111"; ---7 
--				WHEN "1000" =>
--					o_display <= "00000001"; ---8 
--				WHEN "1001" =>
--					o_display <= "00001001"; ---9 
				WHEN OTHERS =>
					o_display1 <= "11111111"; ---apagado 
					o_display2 <= "11111111"; ---apagado 
					o_display3 <= "11111111"; ---apagado 
					o_display4 <= "11111111"; ---apagado 
			END CASE;
		ELSE
			o_display1 <= "11111111"; ---apagado 
			o_display2 <= "11111111"; ---apagado 
			o_display3 <= "11111111"; ---apagado 
			o_display4 <= "11111111"; ---apagado 
		END IF;
	END PROCESS;	
	
end Behavioral;