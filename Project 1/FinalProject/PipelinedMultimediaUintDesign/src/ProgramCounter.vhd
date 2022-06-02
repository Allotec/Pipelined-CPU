-------------------------------------------------------------------------------
--
-- Title       : Program Counter
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 16:33:26 2021
--
-------------------------------------------------------------------------------
--
-- Description : Increments a 6 bit number every clock cycle to point to an
-- instruction in the instruction buffer. A 6 bit number can be loaded in for 
-- branch and jump instructions.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter is
    port(
        --Control signals
        clock : in std_logic;
        pcWrite : in std_logic;	
		stall : in std_logic;

        --Data Values
        count : out std_logic_vector(5 downto 0);
        pcWriteValue : in std_logic_vector(5 downto 0)

    );
end ProgramCounter;


architecture behavioral of ProgramCounter is 

    begin
        readAndWrite : process(clock)
        variable countVal : integer range 0 to 63;
        
        begin
            if(rising_edge(clock)) then 
                if(pcWrite = '1') then
                    count <= pcWriteValue;
                    countVal := to_integer(unsigned(pcWriteValue));
                else
                    count <= std_logic_vector(to_unsigned(countVal, 6));
                end if;				  
				
				if(countVal = 63) then 	 
					countVal := 0;	  
				else					  
					if(stall = '0') then
                		countVal := countVal + 1;
					end if;
				end if;
            end if;
        end process;

end behavioral;
