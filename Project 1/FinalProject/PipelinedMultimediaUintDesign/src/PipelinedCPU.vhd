-------------------------------------------------------------------------------
--
-- Title       : Five Staged Piplelined CPU
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 19:28:15 2021
--
-------------------------------------------------------------------------------
--
-- Description : Full Structural Description of CPU
--
-------------------------------------------------------------------------------

library IEEE;			   
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use pipelinedmultimediauintdesign.all;


entity PipelinedCPU is 
	port(
		--Inputs
		addressIn : in std_logic_vector(5 downto 0);
		dataIn : in std_logic_vector(24 downto 0);
		imWrite : in std_logic;
		stall : in std_logic;
		clock : in std_logic;
		pcWrite : in std_logic;
		pcWriteValue : in std_logic_vector(5 downto 0)			   
	);
	
end PipelinedCPU;


architecture structure of PipelinedCPU is
	signal instructionSig : std_logic_vector(24 downto 0);
	signal localCount : std_logic_vector(5 downto 0);
	signal r3OpcodeSig : std_logic_vector(7 downto 0); 
	signal r4OpcodeSig : std_logic_vector(2 downto 0);
	signal formatBitsSig : std_logic_vector(1 downto 0);
	signal rs1Sig : std_logic_vector(4 downto 0);
	signal rs2Sig : std_logic_vector(4 downto 0);
	signal rs3Sig : std_logic_vector(4 downto 0);
	signal loadIndexSig, loadIndexSig2 : std_logic_vector(2 downto 0);
	signal immediateSig, immediateSig2 : std_logic_vector(15 downto 0);
	signal rdSig, rdSig2 : std_logic_vector(4 downto 0);  
	signal regWriteSig, regWriteSig2, regWriteSig3 : std_logic;
	signal copSig, copSig2 : std_logic_vector(4 downto 0);
	signal valueASig, valueASig2, rs1Sig2 : std_logic_vector(127 downto 0);
	signal valueBSig, valueBSig2, rs2Sig2 : std_logic_vector(127 downto 0);
	signal valueCSig, valueCSig2, rs3Sig2 : std_logic_vector(127 downto 0);
	signal regWriteDataSig : std_logic_vector(127 downto 0);
	signal regWriteAddressSig, addressASig, addressBSig, addressCSig : std_logic_vector(4 downto 0);
	signal forwardSig : std_logic_vector(1 downto 0);
	signal forwardValueSig, rdSig3 : std_logic_vector(127 downto 0);
	
	begin		 
		u0: entity InstructionBuffer port map(
			addressIn => addressIn,
			dataIn => dataIn,
			imWrite => imWrite,
			stall => stall,
			clock => clock,
			instruction => instructionSig,
			count => localCount
			);
	   
		u1: entity ProgramCounter port map(
			stall => stall,
			clock => clock,
			pcWrite => pcWrite,
			pcWriteValue => pcWriteValue,
			count => localCount
			);			   
		
		u2: entity InstructionFetchDecodeReg port map(
			instruction => instructionSig,
			clock => clock,
			r3Opcode => r3OpcodeSig,
			immediate => immediateSig,
			r4Opcode => r4OpcodeSig,
			formatBits => formatBitsSig,
			rs1 => rs1Sig,
			rs2 => rs2Sig,
			rs3 => rs3Sig,
			loadIndex => loadIndexSig,
			rd => rdSig
			);		  
			
		u3: entity Control port map(
			r3Opcode => r3OpcodeSig,
			r4Opcode => r4OpcodeSig,
			formatBits => formatBitsSig,
			regWrite => regWriteSig2,
			cop => copSig
			); 
		
		u4: entity RegisterFile port map(
			addressA => rs1Sig,
			addressB => rs2Sig,
			addressC => rs3Sig,
			clock => clock,
			valueA => valueASig,
			valueB => valueBSig,
			valueC => valueCSig,
			regWrite => regWriteSig,
			regWriteData => regWriteDataSig,
			regWriteAddress => regWriteAddressSig
			); 
			
		u5: entity InstructionDecodeExecuteReg port map(
			clock => clock,
			valueAIn => valueASig,
			valueBIn => valueBSig,
			valueCIn => valueCSig,
			addressAIn => rs1Sig,
			addressBIn => rs2Sig,
			addressCIn => rs3Sig,
			rdIn => rdSig,
			loadIndexIn => loadIndexSig,
			immediateIn => immediateSig,
			copIn => copSig,
			regWriteIn => regWriteSig2,
			cop => copSig2,
			valueA => valueASig2,
			valueB => valueBSig2,
			valueC => valueCSig2,
			loadIndex => loadIndexSig2,
			immediate => immediateSig,
			regWrite => regWriteSig3,
			addressA => addressASig,
			addressB => addressBSig,
			addressC => addressCSig,
			rd => rdSig2
			);
		
		u6: entity ALURegisterDecoder port map(
			cop => copSig2,
			valueA => valueASig2,
			valueB => valueBSig2,
			valueC => valueCSig2,
			loadIndex => loadIndexSig2,
			immediate => immediateSig2,
			forward => forwardSig,
			forwardValue => forwardValueSig,
			rs1 => rs1Sig2,
			rs2 => rs2Sig2,
			rs3 => rs3Sig2
			);
			
		u7: entity ALU port map(
			rs1 => rs1Sig2,
			rs2 => rs2Sig2,
			rs3 => rs3Sig2,
			cop => copSig2,
			rd => rdSig3
			);
			
		u8: entity ExecuteWriteBackReg port map(
			rdValIn => rdSig3,
			regWriteIn => regWriteSig3,
			rdAddressIn => rdSig2,
			clock => clock,
			regWrite => regWriteSig,
			rdAddress => regWriteAddressSig,
			rd => regWriteDataSig
			);
			
		u9: entity ForwardingUnit port map(
			rdVal => regWriteDataSig,
			rdAddress => regWriteAddressSig,
			addressA => addressASig,
			addressB => addressBSig,
			addressC => addressCSig,
			forward => forwardSig,
			forwardValue => forwardValueSig
			);
			
end structure;

