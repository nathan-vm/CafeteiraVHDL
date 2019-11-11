library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
	Generic(
		p_DATA_WIDTH : INTEGER := 5; -- TAMANHO DO DADO (PRECISO DE 5 BITS)
		p_ADD_WIDTH : INTEGER := 2	-- ENDEREÇO DO DADO "00" (PRECISO DE 3 CAFE "00")/LEITE"01"/CHOCOLATE"10" "11" -> agua?)
		
	);
    Port ( 
				i_CLK		: in std_logic;
				i_RST		: in std_logic;
				i_EN		: in STD_logic;
				i_WR		: in STD_logic;
				i_ADDR	: in STD_LOGIC_vector ((p_ADD_WIDTH-1) downto 0);
			   i_DATA   : in STD_LOGIC_vector ((p_DATA_WIDTH -1) downto 0);
				o_DATA	: out STD_LOGIC_vector ((p_dATA_WIDTH -1) downto 0)
	 );
end RAM;

	architecture Behavioral of RAM is 
	
	type MEM_TYPE is array (0 to ((2**p_ADD_WIDTH) - 1)) of std_LOGIC_vector (o_DATA'range);
	signal w_MEMORIA : MEM_TYPE:= ((others=> (others=>'0')));  -- Inicializa com valor zero (0).
	signal w_ADDR	:	std_LOGIC_vector (i_ADDR'range);
	
	begin
		w_ADDR <= (others=>'0') when (i_RST='1') else i_ADDR;
		process(i_CLK)
		begin
			if rising_edge(i_CLK) then
				if(i_EN = '1') then
					if(i_WR = '1') then
						w_MEMORIA (conv_integer(w_ADDR))<= i_DATA; -- ESCREVER EN=1 WR=1
					end if;
						o_DATA <= w_MEMORIA(conv_integer(w_ADDR)); -- LER EN=1 WR=0
				end if;
			end if;
		end process;
		
	end Behavioral;