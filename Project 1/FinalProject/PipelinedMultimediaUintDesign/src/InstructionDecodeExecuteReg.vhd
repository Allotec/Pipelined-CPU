-------------------------------------------------------------------------------
--
-- Title       : Instruction Decode/Execute Register
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 26 18:25:15 2021
--
-------------------------------------------------------------------------------
--
-- Description : Holds the values for the instruction passed by the register 
-- file and control unit.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity InstructionDecodeExecuteReg is 
	port(
		--Input
		regWriteIn : in std_logic;
		copIn : in std_logic_vector(4 downto 0);
		valueAIn : in std_logic_vector(127 downto 0);
		valueBIn : in std_logic_vector(127 downto 0);
		valueCIn : in std_logic_vector(127 downto 0);
		addressAIn : in std_logic_vector(4 downto 0);
		addressBIn : in std_logic_vector(4 downto 0);
		addressCIn : in std_logic_vector(4 downto 0);
		rdIn : in std_logic_vector(4 downto 0);
		loadIndexIn : in std_logic_vector(2 downto 0);
		immediateIn : in std_logic_vector(15 downto 0);
		clock : in std_logic;
		
		--Output
		regWrite : out std_logic;
		cop : out std_logic_vector(4 downto 0);
		valueA : out std_logic_vector(127 downto 0);
		valueB : out std_logic_vector(127 downto 0);
		valueC : out std_logic_vector(127 downto 0);
		addressA : out std_logic_vector(4 downto 0);
		addressB : out std_logic_vector(4 downto 0);
		addressC : out std_logic_vector(4 downto 0);
		rd : out std_logic_vector(4 downto 0);
		loadIndex : out std_logic_vector(2 downto 0);
		immediate : out std_logic_vector(15 downto 0)

	);
end InstructionDecodeExecuteReg;		


architecture behavioral of InstructionDecodeExecuteReg is
	begin
		readWrite : process(clock)
			begin
				if(rising_edge(clock)) then
					regWrite <= regWriteIn;
					cop <= copIn;
					valueA <= valueAIn;
					valueB <= valueBIn;
					valueC <= valueCIn;
					addressA <= addressAIn;
					addressB <= addressBIn;
					addressC <= addressCIn;
					rd <= rdIn;
					loadIndex <= loadIndexIn;
					immediate <= immediateIn;
				end if;
		end process;
end behavioral;