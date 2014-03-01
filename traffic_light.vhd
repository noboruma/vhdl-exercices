----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:32 10/18/2011 
-- Design Name: 
-- Module Name:    exo2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exo2 i
port(Clk100MHz, PB_0 : in bit
LED_3210, LED_7654 : out integer range 0 to 4)
end exo2;

architecture Behavioral of exo2 i

alias reset is PB_0; -- alias pour le signal de reinitialisatio
signal clk_out : bit := '0'; -- signal d'horloge apres divisio
constant clock_divisor : integer := 100000000; -- Constante de division, ici pour une sortie a 1H

begi
	-- Diviseur de frequence : divise la frequence du signal Clk100MHz par clock_di
	clock_divider : process(Clk100Mhz, reset
	variable c : integer range 0 to clock_divisor - 1 := 0; -- c permet de parcourir tout le cycl
	begi
	if reset = '1' then -- si on appui sur reset, on redemarre un cycl
		c := 0
		clk_out <= '0'
	elsif Clk100MHz'event and Clk100MHz = '1' then -- on est sensible a chaque front montant a 100Mh

		if c < (clock_divisor - 1) / 2 then -- premiere partie du cycle, on defini la sortie a 
			c := c + 1;                     -- sur la moitie du cycle (de 0 a 0,5 secondes
			clk_out <= '0';
		elsif c = (clock_divisor - 1) then  -- fin de cycle, quand on arrive au bout d'un cycl
			c := 0;							-- on recommence (a 1 seconde
			clk_out <= '0';
		else								-- deuxieme partie du cycle, on defini la sortie a 
			c := c + 1;						-- (de 0,5 a 1 seconde
			clk_out <= '1'
		end if

	end if
	end process

	process(clk_out)

	variable c : integer range 0 to 20;
	variable etat : integer range 0 to 3;

	begin
		if reset = '1' then
			c := 0;
			etat := 0;
		elsif clk_out'Event and clk_out = '1' then
			if c < 8 then
				c := c + 1;
				etat := 0;
			elsif c < 10 then
				c := c + 1;
				etat := 1;
			elsif c < 18 then
				c := c + 1;
				etat := 2;
			elsif c < 20 then
				c := c + 1;
				etat := 3;
			end if;
			if c = 20 then
			   c := 0;
			end if;
		end if;
		
		case etat is
			when 0 => LED_3210 <= 1; LED_7654 <= 4;
			when 1 => LED_3210 <= 2; LED_7654 <= 4;
			when 2 => LED_3210 <= 4; LED_7654 <= 1;
			when 3 => LED_3210 <= 4; LED_7654 <= 2;
			when others => LED_3210 <= 1; LED_7654 <= 4;
		end case;

	end process;

end Behavioral
