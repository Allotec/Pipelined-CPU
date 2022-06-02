-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : PipelinedMultimediaUintDesign
-- Author      : Matthew Champagne
-- Company     : Stony Brook Universoty
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Matthew Champagne\OneDrive\Fall 2021\ESE 345\Programming Assignments\Project 1\FinalProject\PipelinedMultimediaUintDesign\compile\PipelinedCPU.vhd
-- Generated   : Sun Nov 28 23:54:16 2021
-- From        : C:/Users/Matthew Champagne/OneDrive/Fall 2021/ESE 345/Programming Assignments/Project 1/FinalProject/PipelinedMultimediaUintDesign/src/PipelinedCPU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity PipelinedCPU is
  port(
       addressIn : in STD_LOGIC_VECTOR(5 downto 0);
       dataIn : in STD_LOGIC_VECTOR(24 downto 0);
       imWrite : in STD_LOGIC;
       stall : in STD_LOGIC;
       clock : in STD_LOGIC;
       pcWrite : in STD_LOGIC;
       pcWriteValue : in STD_LOGIC_VECTOR(5 downto 0)
  );
end PipelinedCPU;

architecture structure of PipelinedCPU is

---- Component declarations -----

component ALU
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       cop : in STD_LOGIC_VECTOR(4 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component ALURegisterDecoder
  port(
       cop : in STD_LOGIC_VECTOR(4 downto 0);
       valueA : in STD_LOGIC_VECTOR(127 downto 0);
       valueB : in STD_LOGIC_VECTOR(127 downto 0);
       valueC : in STD_LOGIC_VECTOR(127 downto 0);
       loadIndex : in STD_LOGIC_VECTOR(2 downto 0);
       immediate : in STD_LOGIC_VECTOR(15 downto 0);
       forward : in STD_LOGIC_VECTOR(2 downto 0);
       forwardValue : in STD_LOGIC_VECTOR(127 downto 0);
       rs1 : out STD_LOGIC_VECTOR(127 downto 0);
       rs2 : out STD_LOGIC_VECTOR(127 downto 0);
       rs3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component Control
  port(
       formatBits : in STD_LOGIC_VECTOR(1 downto 0);
       r4Opcode : in STD_LOGIC_VECTOR(2 downto 0);
       r3Opcode : in STD_LOGIC_VECTOR(7 downto 0);
       cop : out STD_LOGIC_VECTOR(4 downto 0);
       regWrite : out STD_LOGIC
  );
end component;
component ExecuteWriteBackReg
  port(
       rdValIn : in STD_LOGIC_VECTOR(127 downto 0);
       regWriteIn : in STD_LOGIC;
       rdAddressIn : in STD_LOGIC_VECTOR(4 downto 0);
       clock : in STD_LOGIC;
       regWrite : out STD_LOGIC;
       rdAddress : out STD_LOGIC_VECTOR(4 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component ForwardingUnit
  port(
       rdVal : in STD_LOGIC_VECTOR(127 downto 0);
       rdAddress : in STD_LOGIC_VECTOR(4 downto 0);
       addressA : in STD_LOGIC_VECTOR(4 downto 0);
       addressB : in STD_LOGIC_VECTOR(4 downto 0);
       addressC : in STD_LOGIC_VECTOR(4 downto 0);
       forward : out STD_LOGIC_VECTOR(2 downto 0);
       forwardValue : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component InstructionBuffer
  port(
       count : in STD_LOGIC_VECTOR(5 downto 0);
       clock : in STD_LOGIC;
       dataIn : in STD_LOGIC_VECTOR(24 downto 0);
       addressIn : in STD_LOGIC_VECTOR(5 downto 0);
       imWrite : in STD_LOGIC;
       stall : in STD_LOGIC;
       instruction : out STD_LOGIC_VECTOR(24 downto 0)
  );
end component;
component InstructionDecodeExecuteReg
  port(
       regWriteIn : in STD_LOGIC;
       copIn : in STD_LOGIC_VECTOR(4 downto 0);
       valueAIn : in STD_LOGIC_VECTOR(127 downto 0);
       valueBIn : in STD_LOGIC_VECTOR(127 downto 0);
       valueCIn : in STD_LOGIC_VECTOR(127 downto 0);
       addressAIn : in STD_LOGIC_VECTOR(4 downto 0);
       addressBIn : in STD_LOGIC_VECTOR(4 downto 0);
       addressCIn : in STD_LOGIC_VECTOR(4 downto 0);
       rdIn : in STD_LOGIC_VECTOR(4 downto 0);
       loadIndexIn : in STD_LOGIC_VECTOR(2 downto 0);
       immediateIn : in STD_LOGIC_VECTOR(15 downto 0);
       clock : in STD_LOGIC;
       regWrite : out STD_LOGIC;
       cop : out STD_LOGIC_VECTOR(4 downto 0);
       valueA : out STD_LOGIC_VECTOR(127 downto 0);
       valueB : out STD_LOGIC_VECTOR(127 downto 0);
       valueC : out STD_LOGIC_VECTOR(127 downto 0);
       addressA : out STD_LOGIC_VECTOR(4 downto 0);
       addressB : out STD_LOGIC_VECTOR(4 downto 0);
       addressC : out STD_LOGIC_VECTOR(4 downto 0);
       rd : out STD_LOGIC_VECTOR(4 downto 0);
       loadIndex : out STD_LOGIC_VECTOR(2 downto 0);
       immediate : out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;
component InstructionFetchDecodeReg
  port(
       instruction : in STD_LOGIC_VECTOR(24 downto 0);
       clock : in STD_LOGIC;
       formatBits : out STD_LOGIC_VECTOR(1 downto 0);
       loadIndex : out STD_LOGIC_VECTOR(2 downto 0);
       immediate : out STD_LOGIC_VECTOR(15 downto 0);
       r4Opcode : out STD_LOGIC_VECTOR(2 downto 0);
       r3Opcode : out STD_LOGIC_VECTOR(7 downto 0);
       rd : out STD_LOGIC_VECTOR(4 downto 0);
       rs1 : out STD_LOGIC_VECTOR(4 downto 0);
       rs2 : out STD_LOGIC_VECTOR(4 downto 0);
       rs3 : out STD_LOGIC_VECTOR(4 downto 0)
  );
end component;
component ProgramCounter
  port(
       clock : in STD_LOGIC;
       pcWrite : in STD_LOGIC;
       stall : in STD_LOGIC;
       count : out STD_LOGIC_VECTOR(5 downto 0);
       pcWriteValue : in STD_LOGIC_VECTOR(5 downto 0)
  );
end component;
component RegisterFile
  port(
       addressA : in STD_LOGIC_VECTOR(4 downto 0);
       addressB : in STD_LOGIC_VECTOR(4 downto 0);
       addressC : in STD_LOGIC_VECTOR(4 downto 0);
       valueA : out STD_LOGIC_VECTOR(127 downto 0);
       valueB : out STD_LOGIC_VECTOR(127 downto 0);
       valueC : out STD_LOGIC_VECTOR(127 downto 0);
       regWriteData : in STD_LOGIC_VECTOR(127 downto 0);
       regWriteAddress : in STD_LOGIC_VECTOR(4 downto 0);
       regWrite : in STD_LOGIC;
       clock : in STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal regWriteSig : STD_LOGIC;
signal regWriteSig2 : STD_LOGIC;
signal regWriteSig3 : STD_LOGIC;
signal addressASig : STD_LOGIC_VECTOR(4 downto 0);
signal addressBSig : STD_LOGIC_VECTOR(4 downto 0);
signal addressCSig : STD_LOGIC_VECTOR(4 downto 0);
signal BUS539 : STD_LOGIC_VECTOR(15 downto 0);
signal BUS547 : STD_LOGIC_VECTOR(15 downto 0);
signal copSig : STD_LOGIC_VECTOR(4 downto 0);
signal copSig2 : STD_LOGIC_VECTOR(4 downto 0);
signal formatBitsSig : STD_LOGIC_VECTOR(1 downto 0);
signal forwardSig : STD_LOGIC_VECTOR(2 downto 0);
signal forwardValueSig : STD_LOGIC_VECTOR(127 downto 0);
signal instructionSig : STD_LOGIC_VECTOR(24 downto 0);
signal loadIndexSig : STD_LOGIC_VECTOR(2 downto 0);
signal loadIndexSig2 : STD_LOGIC_VECTOR(2 downto 0);
signal localCount : STD_LOGIC_VECTOR(5 downto 0);
signal r3OpcodeSig : STD_LOGIC_VECTOR(7 downto 0);
signal r4OpcodeSig : STD_LOGIC_VECTOR(2 downto 0);
signal rdSig : STD_LOGIC_VECTOR(4 downto 0);
signal rdSig2 : STD_LOGIC_VECTOR(4 downto 0);
signal rdSig3 : STD_LOGIC_VECTOR(127 downto 0);
signal regWriteAddressSig : STD_LOGIC_VECTOR(4 downto 0);
signal regWriteDataSig : STD_LOGIC_VECTOR(127 downto 0);
signal rs1Sig : STD_LOGIC_VECTOR(4 downto 0);
signal rs1Sig2 : STD_LOGIC_VECTOR(127 downto 0);
signal rs2Sig : STD_LOGIC_VECTOR(4 downto 0);
signal rs2Sig2 : STD_LOGIC_VECTOR(127 downto 0);
signal rs3Sig : STD_LOGIC_VECTOR(4 downto 0);
signal rs3Sig2 : STD_LOGIC_VECTOR(127 downto 0);
signal valueASig : STD_LOGIC_VECTOR(127 downto 0);
signal valueASig2 : STD_LOGIC_VECTOR(127 downto 0);
signal valueBSig : STD_LOGIC_VECTOR(127 downto 0);
signal valueBSig2 : STD_LOGIC_VECTOR(127 downto 0);
signal valueCSig : STD_LOGIC_VECTOR(127 downto 0);
signal valueCSig2 : STD_LOGIC_VECTOR(127 downto 0);

begin

----  Component instantiations  ----

u0 : InstructionBuffer
  port map(
       count => localCount,
       clock => clock,
       dataIn => dataIn,
       addressIn => addressIn,
       imWrite => imWrite,
       stall => stall,
       instruction => instructionSig
  );

u1 : ProgramCounter
  port map(
       clock => clock,
       pcWrite => pcWrite,
       stall => stall,
       count => localCount,
       pcWriteValue => pcWriteValue
  );

u2 : InstructionFetchDecodeReg
  port map(
       instruction => instructionSig,
       clock => clock,
       formatBits => formatBitsSig,
       loadIndex => loadIndexSig,
       immediate => BUS539,
       r4Opcode => r4OpcodeSig,
       r3Opcode => r3OpcodeSig,
       rd => rdSig,
       rs1 => rs1Sig,
       rs2 => rs2Sig,
       rs3 => rs3Sig
  );

u3 : Control
  port map(
       formatBits => formatBitsSig,
       r4Opcode => r4OpcodeSig,
       r3Opcode => r3OpcodeSig,
       cop => copSig,
       regWrite => regWriteSig2
  );

u4 : RegisterFile
  port map(
       addressA => rs1Sig,
       addressB => rs2Sig,
       addressC => rs3Sig,
       valueA => valueASig,
       valueB => valueBSig,
       valueC => valueCSig,
       regWriteData => regWriteDataSig,
       regWriteAddress => regWriteAddressSig,
       regWrite => regWriteSig,
       clock => clock
  );

u5 : InstructionDecodeExecuteReg
  port map(
       regWriteIn => regWriteSig2,
       copIn => copSig,
       valueAIn => valueASig,
       valueBIn => valueBSig,
       valueCIn => valueCSig,
       addressAIn => rs1Sig,
       addressBIn => rs2Sig,
       addressCIn => rs3Sig,
       rdIn => rdSig,
       loadIndexIn => loadIndexSig,
       immediateIn => BUS539,
       clock => clock,
       regWrite => regWriteSig3,
       cop => copSig2,
       valueA => valueASig2,
       valueB => valueBSig2,
       valueC => valueCSig2,
       addressA => addressASig,
       addressB => addressBSig,
       addressC => addressCSig,
       rd => rdSig2,
       loadIndex => loadIndexSig2,
       immediate => BUS547
  );

u6 : ALURegisterDecoder
  port map(
       cop => copSig2,
       valueA => valueASig2,
       valueB => valueBSig2,
       valueC => valueCSig2,
       loadIndex => loadIndexSig2,
       immediate => BUS547,
       forward => forwardSig,
       forwardValue => forwardValueSig,
       rs1 => rs1Sig2,
       rs2 => rs2Sig2,
       rs3 => rs3Sig2
  );

u7 : ALU
  port map(
       rs1 => rs1Sig2,
       rs2 => rs2Sig2,
       rs3 => rs3Sig2,
       cop => copSig2,
       rd => rdSig3
  );

u8 : ExecuteWriteBackReg
  port map(
       rdValIn => rdSig3,
       regWriteIn => regWriteSig3,
       rdAddressIn => rdSig2,
       clock => clock,
       regWrite => regWriteSig,
       rdAddress => regWriteAddressSig,
       rd => regWriteDataSig
  );

u9 : ForwardingUnit
  port map(
       rdVal => regWriteDataSig,
       rdAddress => regWriteAddressSig,
       addressA => addressASig,
       addressB => addressBSig,
       addressC => addressCSig,
       forward => forwardSig,
       forwardValue => forwardValueSig
  );


end structure;
