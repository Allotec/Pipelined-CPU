-------------------------------------------------------------------------------
--
-- Title       : Instruction Fetch/Decode Register
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 23:21:52 2021
--
-------------------------------------------------------------------------------
--
-- Description : Holds the values for the instruction passed by the instrucution
-- fetch unit and splits them into the components
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity InstructionFetchDecodeReg is 
	port(
		--Input
		instruction : in std_logic_vector(24 downto 0);
		clock : in std_logic;
		
		--Output
		formatBits : out std_logic_vector(1 downto 0); --24-23 Top two bits to be sent to control logic
		loadIndex : out std_logic_vector(2 downto 0); --23-21 from load immediate instruction
		immediate : out std_logic_vector(15 downto 0); --20-5 from load immediate instruction
		r4Opcode : out std_logic_vector(2 downto 0); --22-20 opcode for r4 instruction format
		r3Opcode : out std_logic_vector(7 downto 0); --22-15 opcode for r3 instruction format
		rd : out std_logic_vector(4 downto 0); --4-0 destination register
		rs1 : out std_logic_vector(4 downto 0); --9-5 source register 1
		rs2 : out std_logic_vector(4 downto 0); --14-10 source register 2
		rs3 : out std_logic_vector(4 downto 0) --19-15 source register 3
	);
end InstructionFetchDecodeReg;		


architecture behavioral of InstructionFetchDecodeReg is
	begin
		readWrite : process(clock)
			begin
				if(rising_edge(clock)) then
					formatBits <= instruction(24 downto 23);
					loadIndex <= instruction(23 downto 21);
					r4Opcode <= instruction(22 downto 20);
					r3Opcode<= instruction(22 downto 15);
					rd <= instruction(4 downto 0);
					rs1 <= instruction(9 downto 5);
					immediate <= instruction(20 downto 5);
					rs2 <= instruction(14 downto 10);
					rs3 <= instruction(19 downto 15);
				end if;
		end process;
end behavioral;

