-------------------------------------------------------------------------------
--
-- Title       : Register File
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 14:40:37 2021
--
-------------------------------------------------------------------------------
--
-- Description : Block containing 32 128-bit registers. There are 3 output buses
-- for reading and 1 input bus for writing. The reads are combinational and writes
-- are synchronous.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity RegisterFile is 
    port(
        --Reading values
        --Read Buses
        addressA : in std_logic_vector(4 downto 0);
        addressB : in std_logic_vector(4 downto 0);
        addressC : in std_logic_vector(4 downto 0);

        --Bus Outputs
        valueA : out std_logic_vector(127 downto 0);
        valueB : out std_logic_vector(127 downto 0);
        valueC : out std_logic_vector(127 downto 0);

        --Writing Values
        regWriteData : in std_logic_vector(127 downto 0);
        regWriteAddress : in std_logic_vector(4 downto 0);
        regWrite : in std_logic;

        clock : in std_logic
    );
end RegisterFile;



architecture behavioral of RegisterFile is
    type registers is array (0 to 31) of std_logic_vector(127 downto 0);
    signal regFile : registers;

begin		
    read : process(addressA, addressB, addressC, regWriteData, regWriteAddress)
        begin
            --Writing to address A with bypass
            if(addressA = regWriteAddress and regWrite = '1') then
                valueA <= regWriteData;
            else
                valueA <= regFile(to_integer(unsigned(addressA)));
            end if;

            --Writing to address B with bypass
            if(addressB = regWriteAddress and regWrite = '1') then
                valueB <= regWriteData;
            else
                valueB <= regFile(to_integer(unsigned(addressB)));
            end if;

            ----Writing to address C with bypass
            if(addressC = regWriteAddress and regWrite = '1') then
                valueC <= regWriteData;
            else
                valueC <= regFile(to_integer(unsigned(addressC)));
            end if;
    end process;

    write : process(clock)
        begin
            if(rising_edge(clock) and regWrite = '1') then
                regFile(to_integer(unsigned(regWriteAddress))) <= regWriteData;
            end if;
        
    end process;
end behavioral;

