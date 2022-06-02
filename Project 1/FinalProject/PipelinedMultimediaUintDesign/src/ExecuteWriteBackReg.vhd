-------------------------------------------------------------------------------
--
-- Title       : Execute / Write Back Register
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 23:21:52 2021
--
-------------------------------------------------------------------------------
--
-- Description : Holds the values to be written back to the register file and
-- to be sent to the forwarding unit.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity ExecuteWriteBackReg is 
	port(			
		--Input
		rdValIn : in std_logic_vector(127 downto 0);
		regWriteIn : in std_logic;
		rdAddressIn : in std_logic_vector(4 downto 0);
		clock : in std_logic;
		
		--Output
		regWrite : out std_logic;
		rdAddress : out std_logic_vector(4 downto 0);
		rd : out std_logic_vector(127 downto 0)
	);
end ExecuteWriteBackReg;		


architecture behavioral of ExecuteWriteBackReg is
	begin
		readWrite : process(clock)
			begin
				if(rising_edge(clock)) then
					regWrite <= regWriteIn;
					rdAddress <= rdAddressIn;
					rd <= rdValIn;
				end if;
		end process;
end behavioral;