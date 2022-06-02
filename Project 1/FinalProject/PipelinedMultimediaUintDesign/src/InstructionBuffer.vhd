-------------------------------------------------------------------------------
--
-- Title       : Instruction Buffer
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 18:26:16 2021
--
-------------------------------------------------------------------------------
--
-- Description : Block containing 64 25-bit registers. There is 1 output bus
-- for reading and 1 input bus for writing to load values initially. The reads 
-- are combinational and writes are synchronous.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity InstructionBuffer is 
    port(
        --Inputs 
        count : in std_logic_vector(5 downto 0);
        clock : in std_logic; --Only used to load values initially
        dataIn : in std_logic_vector(24 downto 0); --Only used to load values initially
        addressIn : in std_logic_vector(5 downto 0); --Only used to load values initially
        imWrite : in std_logic; --Only used to load values initially
        stall : in std_logic;

        --Outputs
        instruction : out std_logic_vector(24 downto 0)
    );
end InstructionBuffer;


architecture behavioral of InstructionBuffer is
    type instructions is array (0 to 63) of std_logic_vector(24 downto 0);
    signal instructionMemory : instructions;

begin		
    readAmdWrite : process(clock)
        begin
            if(stall = '0') then
                instruction <= instructionMemory(to_integer(unsigned(count)));
            end if;

            if(rising_edge(clock) and imWrite = '1') then
                instructionMemory(to_integer(unsigned(addressIn))) <= dataIn;
            end if;
        
    end process;
end behavioral;