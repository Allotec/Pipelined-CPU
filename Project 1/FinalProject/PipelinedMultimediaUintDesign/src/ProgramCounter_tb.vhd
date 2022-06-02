-------------------------------------------------------------------------------
--
-- Title       : Program Counter Testbench
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 17:15:36 2021
--
-------------------------------------------------------------------------------
--
-- Description : Tests the Program Counter
--
-------------------------------------------------------------------------------

library IEEE;				 
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;		  
use pipelinedmultimediauintdesign.all;

entity ProgramCounter_tb is
    end ProgramCounter_tb;


architecture tb of ProgramCounter_tb is
    signal pcWrite : std_logic;
    signal count : std_logic_vector(5 downto 0);
    signal pcWriteValue : std_logic_vector(5 downto 0);
	signal stall : std_logic;

    signal clock : std_logic;

    begin
        --Portmap of testbench with the UUT
        UUT : entity programcounter port map(pcWrite => pcWrite, count => count, pcWriteValue => pcWriteValue, clock => clock, stall => stall);

        tb1: process
			constant period: time := 20 ns;

            begin								
				clock <= '0';

                wait for period;
                --Loading values
                clock <= '1';
                

                
                wait for period;
                
				
				clock <= '0';
				
				wait for period;
				clock <= '1';
				
				
				wait for period;						 
				clock <= '0';
				
				
				wait for period;
				clock <= '1';
				--pcWrite <= '1';	   
				--pcWriteValue <= std_logic_vector(to_unsigned(31, 6));
				
				
				wait for period;								
				clock <= '0';
				pcWrite <= '0';
				
				wait for period;
				clock <= '1';									  
				
				
				wait for period;
				clock <= '0';
				
				wait for period;
				
        end process;
end tb;