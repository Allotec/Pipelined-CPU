-------------------------------------------------------------------------------
--
-- Title       : Instruction Buffer Testbench
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 18:17:14 2021
--
-------------------------------------------------------------------------------
--
-- Description : Loads in value from txt file into instruction memory
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

entity InstructionBuffer_tb is
    end InstructionBuffer_tb;


architecture tb of InstructionBuffer_tb is
    --Inputs 
        signal count : std_logic_vector(5 downto 0);
        signal clock : std_logic; --Only used to load values initially
        signal dataIn : std_logic_vector(24 downto 0); --Only used to load values initially
        signal addressIn : std_logic_vector(5 downto 0); --Only used to load values initially
        signal imWrite : std_logic; --Only used to load values initially
        signal stall : std_logic;

        --Outputs
        signal instruction : std_logic_vector(24 downto 0);

    begin
        --Portmap of testbench with the UUT
        UUT : entity instructionbuffer port map(count => count, clock => clock, dataIn => dataIn, addressIn => addressIn, imWrite => imWrite, stall => stall, instruction => instruction);
			
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
				
				while true loop
					imWrite <= '0';
					stall <= '0';
					
					wait for period;
				end loop;
				
        end process;
end tb;