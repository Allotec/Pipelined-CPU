-------------------------------------------------------------------------------
--
-- Title       : Instruction Fetch Decode Register
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 17:15:36 2021
--
-------------------------------------------------------------------------------
--
-- Description : Tests the Instruction Fetch Decode Register
--
-------------------------------------------------------------------------------

library IEEE;				 
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;		  
use pipelinedmultimediauintdesign.all;

entity InstrutionFetchDecodeReg_tb is
    end InstrutionFetchDecodeReg_tb;


architecture tb of InstrutionFetchDecodeReg_tb is
    --Input
	signal instruction : std_logic_vector(24 downto 0);
	signal clock : std_logic;
	
	--Output
	signal formatBits : std_logic_vector(1 downto 0); --24-23 Top two bits to be sent to control logic
	signal loadIndex : std_logic_vector(2 downto 0); --23-21 from load immediate instruction
	signal immediate : std_logic_vector(15 downto 0); --20-5 from load immediate instruction
	signal r4Opcode : std_logic_vector(2 downto 0); --22-20 opcode for r4 instruction format
	signal r3Opcode : std_logic_vector(7 downto 0); --22-15 opcode for r3 instruction format
	signal rd : std_logic_vector(4 downto 0); --4-0 destination register
	signal rs1 : std_logic_vector(4 downto 0); --9-5 source register 1
	signal rs2 : std_logic_vector(4 downto 0); --14-10 source register 2
	signal rs3 : std_logic_vector(4 downto 0); --19-15 source register 3

    begin
        --Portmap of testbench with the UUT
        UUT : entity InstructionFetchDecodeReg port map(clock => clock, instruction => instruction, formatBits => formatBits, loadIndex => loadIndex, r4Opcode => r4Opcode, r3Opcode => r3Opcode, rd => rd, rs1 => rs1, rs2 => rs2, rs3 => rs3);

        tb1: process
			constant period: time := 20 ns;

            begin								
				clock <= '0';	
				instruction <= "0000000000000000010000000";

                wait for period;
                --Loading values
                clock <= '1';							   
				
				wait for period;
				
				clock <= '0';	
				instruction <= "0000000000000000010100001";

                wait for period;
                --Loading values
                clock <= '1';
				
				wait for period;
				
				clock <= '0';	
				instruction <= "0000000000000000001100011";

                wait for period;
                --Loading values
                clock <= '1';
				
				
				wait for period;
				
				clock <= '0';	
				instruction <= "0000000000000000100100100";

                wait for period;
                --Loading values
                clock <= '1';
				
				wait for period;
				
				clock <= '0';	
				instruction <= "1100000001000010000000010";

                wait for period;
                --Loading values
                clock <= '1';
				
        end process;
end tb;