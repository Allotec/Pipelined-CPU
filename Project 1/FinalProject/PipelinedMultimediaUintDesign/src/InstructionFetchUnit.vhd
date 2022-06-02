-------------------------------------------------------------------------------
--
-- Title       : Instruction Fetch Unit
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 19:28:15 2021
--
-------------------------------------------------------------------------------
--
-- Description : This unit is responsible for holding the raw instructions
-- and filling up the pipeline with new information.
--
-------------------------------------------------------------------------------

library IEEE;			   
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use pipelinedmultimediauintdesign.all;


entity InstructionFetchUnit is 
	port(
		--Inputs
		addressIn : in std_logic_vector(5 downto 0);
		dataIn : in std_logic_vector(24 downto 0);
		imWrite : in std_logic;
		stall : in std_logic;
		clock : in std_logic;
		pcWrite : in std_logic;
		pcWriteValue : in std_logic_vector(5 downto 0);
		
		--Output									   
		instruction : out std_logic_vector(24 downto 0)
	);
	
end InstructionFetchUnit;


architecture structure of InstructionFetchUnit is
	signal localCount : std_logic_vector(5 downto 0);

	begin		 
		u0: entity InstructionBuffer port map(
			addressIn => addressIn,
			dataIn => dataIn,
			imWrite => imWrite,
			stall => stall,
			clock => clock,
			instruction => instruction,
			count => localCount
			);
	   
		u1: entity ProgramCounter port map(
			stall => stall,
			clock => clock,
			pcWrite => pcWrite,
			pcWriteValue => pcWriteValue,
			count => localCount
			);
			
end structure;
