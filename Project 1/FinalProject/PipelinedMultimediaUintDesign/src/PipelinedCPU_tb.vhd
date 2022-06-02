-------------------------------------------------------------------------------
--
-- Title       : Five Stage Pipelined CPU Architecture
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 27 01:17:14 2021
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the CPU
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

entity PipelinedCPU_tb is
    end PipelinedCPU_tb;


architecture tb of PipelinedCPU_tb is
    signal addressIn : std_logic_vector(5 downto 0);
	signal dataIn : std_logic_vector(24 downto 0);
	signal imWrite : std_logic;
	signal stall : std_logic;
	signal clock : std_logic;
	signal pcWrite : std_logic;
	signal pcWriteValue : std_logic_vector(5 downto 0);
	signal instruction : std_logic_vector(24 downto 0);
	
	--Internal signals to be traced
	signal valueA, valueB, valueC, rs1, rs2, rs3, rd : std_logic_vector(127 downto 0);
	signal cop : std_logic_vector(4 downto 0);
	signal address : std_logic_vector(4 downto 0);
	signal immediate : std_logic_vector(15 downto 0);
	
	type registers is array (0 to 31) of std_logic_vector(127 downto 0);
    signal registerFile : registers;
	

    begin
        --Portmap of testbench with the UUT
        UUT : entity PipelinedCPU port map(addressIn => addressIn, dataIn => dataIn, imWrite => imWrite, stall => stall, clock => clock, pcWrite => pcWrite, pcWriteValue => pcWriteValue);
			
	   --Internal signals to be traced signal assignment
	   instruction <= <<signal .pipelinedcpu_tb.UUT.u0.instruction : std_logic_vector(24 downto 0)>>;
	   valueA <= <<signal .pipelinedcpu_tb.UUT.u4.valueA : std_logic_vector(127 downto 0)>>;
	   valueB <= <<signal .pipelinedcpu_tb.UUT.u4.valueB : std_logic_vector(127 downto 0)>>;
	   valueC <= <<signal .pipelinedcpu_tb.UUT.u4.valueC : std_logic_vector(127 downto 0)>>;
	   immediate <= <<signal .pipelinedcpu_tb.UUT.u2.immediate : std_logic_vector(15 downto 0)>>;
	   rs1 <= <<signal .pipelinedcpu_tb.UUT.u7.rs1 : std_logic_vector(127 downto 0)>>;
	   rs2 <= <<signal .pipelinedcpu_tb.UUT.u7.rs2 : std_logic_vector(127 downto 0)>>;
	   rs3 <= <<signal .pipelinedcpu_tb.UUT.u7.rs3 : std_logic_vector(127 downto 0)>>;
	   cop <= <<signal .pipelinedcpu_tb.UUT.u7.cop : std_logic_vector(4 downto 0)>>;  
	   rd <= <<signal .pipelinedcpu_tb.UUT.u7.rd : std_logic_vector(127 downto 0)>>;
	   address <= <<signal .pipelinedcpu_tb.UUT.u8.rdAddressIn : std_logic_vector(4 downto 0)>>;
	   registerFile <= <<signal .pipelinedcpu_tb.UUT.u4.regFile : registers>>;
		
        tb1: process
		constant period: time := 20 ns;		 
			--Reading from Instruction File
			file f : TEXT open READ_MODE is "Instructions.txt";
		
			variable currentLine : line;
			variable lineField : std_logic_vector(24 downto 0);	  
			variable i : integer range 0 to 64;
			
			--Outputting to Results File
			file logFile : TEXT open WRITE_MODE is "LogFile.txt";
		
			variable lineOut : line;
			variable lineFieldOut : std_logic_vector(127 downto 0);
			variable j : integer range 0 to 64;
			
			variable vTime : time := 0 ns;
						
            begin			  	
				--Setting up column names in log file output
				write(lineOut, "time");
				write(lineOut, "Instruction", right, 18);
				write(lineOut, "RegValueA", right, 15);
				write(lineOut, "RegValueB", right, 15);
				write(lineOut, "RegValueC", right, 15);
				write(lineOut, "Immediate", right, 15);
				write(lineOut, "ALU rs1", right, 15);
				write(lineOut, "ALU rs2", right, 15);
				write(lineOut, "ALU rs3", right, 15);
				write(lineOut, "ALU cop", right, 15);
				write(lineOut, "ALU out", right, 15);
				write(lineOut, "Write Address", right, 15);
				
				writeline(logFile, lineOut);
				
				
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
				
				imWrite <= '0';
				stall <= '0';				
				
				
				
				while j < 64 loop
					--Write value to line
					vTime := (now / 1000);
					write(lineOut, time'image(vTime));
					
					hwrite(lineOut, instruction, right, 15); 
					
					hwrite(lineOut, valueA, right, 15);
					hwrite(lineOut, valueB, right, 15);	 
					hwrite(lineOut, valueC, right, 15);
					hwrite(lineOut, immediate, right, 15);
					
					hwrite(lineOut, rs1, right, 15);
					hwrite(lineOut, rs2, right, 15);
					hwrite(lineOut, rs3, right, 15);
					hwrite(lineOut, cop, right, 15);
					hwrite(lineOut, rd, right, 15);
					hwrite(lineOut, address, right, 15);
					
					--Write line to the file
					writeline(logFile, lineOut);				  
					
					j := j + 1;
					
					clock <= '0';
					wait for period;
					clock <= '1';
					wait for period;
				end loop; 
					write(lineOut, LF);
					write(lineOut, "Register File End State");
					
					for k in 0 to 31 loop
						write(lineOut, LF);
						write(lineOut, "reg(" & integer'image(k) & ")- ");
						hwrite(lineOut, registerFile(k));
					end loop;
				
				wait for period;		   
				
        end process;
end tb;