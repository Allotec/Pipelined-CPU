-------------------------------------------------------------------------------
--
-- Title       : Forwarding Unit
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 23:21:52 2021
--
-------------------------------------------------------------------------------
--
-- Description : Forwards values to the ALU register to prevent data hazards.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity ForwardingUnit is 
	port(
		--Input
		rdVal : in std_logic_vector(127 downto 0);
		rdAddress : in std_logic_vector(4 downto 0);
		addressA : in std_logic_vector(4 downto 0);
		addressB : in std_logic_vector(4 downto 0);
		addressC : in std_logic_vector(4 downto 0);
		
		--Output								
		forward : out std_logic_vector(2 downto 0);
		forwardValue : out std_logic_vector(127 downto 0)
	);
end ForwardingUnit;		


architecture behavioral of ForwardingUnit is
	begin
		forwardWrite : process(rdVal, rdAddress, addressA, addressB, addressC)
		
			begin	 						 
				forwardValue <= rdVal;		 
				forward <= "000";
				
				--Forward to rs1
				if(rdAddress = addressA) then
					forward(0 downto 0) <= "1";
				
				end if;
				
				--Forward to rs2
				if(rdAddress = addressB) then
					forward(1 downto 1) <= "1";
				
				end if;
				
				--Forward to rs3
				if(rdAddress = addressC) then
					forward(2 downto 2) <= "1";

				end if;
		end process;
end behavioral;