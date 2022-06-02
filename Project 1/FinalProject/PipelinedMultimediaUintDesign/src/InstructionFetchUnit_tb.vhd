-------------------------------------------------------------------------------
--
-- Title       : Instruction Fetch Unit Testbench
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 18:17:14 2021
--
-------------------------------------------------------------------------------
--
-- Description : Loads in value from txt file into instruction memory and then
-- Tests to see if Program Counter outputs the proper instructions.
--
-------------------------------------------------------------------------------

library IEEE;				 		  
library STD;
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;	
use IEEE.std_logic_textio.all;
use STD.textio.all;
use pipelinedmultimediauintdesign.all;

entity InstructionFetchUnit_tb is
    end InstructionFetchUnit_tb;


architecture tb of InstructionFetchUnit_tb is
    --Inputs 
        --Inputs
		signal addressIn : std_logic_vector(5 downto 0);
		signal dataIn : std_logic_vector(24 downto 0);
		signal imWrite : std_logic;
		signal stall : std_logic;
		signal clock : std_logic;
		signal pcWrite : std_logic;
		signal pcWriteValue : std_logic_vector(5 downto 0);
		
		--Output									   
		signal instruction : std_logic_vector(24 downto 0);

    begin
        --Portmap of testbench with the UUT
        UUT : entity instructionfetchunit port map(addressIn => addressIn, dataIn => dataIn, imWrite => imWrite, stall => stall, clock => clock, pcWrite => pcWrite, pcWriteValue => pcWriteValue, instruction => instruction);
			
        tb1: process
		constant period: time := 20 ns;		 
			file f : TEXT open READ_MODE is "Instructions.txt";
		
			variable currentLine : line;
			variable lineField : std_logic_vector(24 downto 0);	  
			variable i : integer range 0 to 64;
						
            begin			  
				imWrite <= '1';
				stall <= '1';
				wait for period;
				
				while(not endFile(f)) loop	   
					clock <= '0';
					readLine(f, currentLine);
					read(currentLine, lineField);
					dataIn <= lineField;   
					addressIn <= std_logic_vector(to_unsigned(i, 6));
					i := i + 1;
					wait for period;
					clock <= '1';
					wait for period;
        
        		end loop;	   
				
				
				imWrite <= '0';
				stall <= '0';
				
				while true loop
					clock <= '0';
					wait for period;
					clock <= '1';
					wait for period;
				end loop;
				
        end process;
end tb;