----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:52:00 10/18/2011 
-- Design Name: 
-- Module Name:    exo1 - Behavioral 
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

entity blinker i
	port(Clk100MHz, PB_0 : in bit; -- On utilise en entree l'horloge a 100Mh
	LED_0 : out bit)
end blinker;

architecture Behavioral of blinker i

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

	LED_0 <= clk_out; -- Sortie sur la LE

end Behavioral;

