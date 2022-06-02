-------------------------------------------------------------------------------
--
-- Title       : Register File Testbench
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 14:38:15 2021
--
-------------------------------------------------------------------------------
--
-- Description : Tests the register file functions
--
-------------------------------------------------------------------------------

library IEEE;				 
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;		  
use pipelinedmultimediauintdesign.all;
use std.env.stop;

entity RegisterFile_tb is
    end RegisterFile_tb;


architecture tb of RegisterFile_tb is
    --Reading values
    --Read Buses
    signal addressA : std_logic_vector(4 downto 0);
    signal addressB : std_logic_vector(4 downto 0);
    signal addressC : std_logic_vector(4 downto 0);

    --Bus Outputs
    signal valueA : std_logic_vector(127 downto 0);
    signal valueB : std_logic_vector(127 downto 0);
    signal valueC : std_logic_vector(127 downto 0);

    --Writing Values
    signal regWriteData : std_logic_vector(127 downto 0);
    signal regWriteAddress : std_logic_vector(4 downto 0);
    signal regWrite : std_logic;

    signal clock : std_logic;

    begin
        --Portmap of testbench with the UUT
        UUT : entity registerfile port map(addressA => addressA, addressB => addressB, addressC => addressC, valueA => valueA, valueB => valueB, valueC => valueC, regWriteData => regWriteData, regWriteAddress => regWriteAddress, regWrite => regWrite, clock => clock);

        tb1: process
			constant period: time := 20 ns;

            begin								
				clock <= '0';

                wait for period;
                --Loading values
                clock <= '1';
                regWriteData <= std_logic_vector(to_signed(5170, 128)); --0x1432
                regWriteAddress <= std_logic_vector(to_signed(1, 5));
                regWrite <= '1';

                --Setting outputs

                
                wait for period;
				clock <= '0';
				
				wait for period;
				
				clock <= '1';
				regWriteData <= std_logic_vector(to_signed(3872, 128)); --0x1432
                regWriteAddress <= std_logic_vector(to_signed(0, 5));	  
				
				
				wait for period;
				clock <= '0';
				
				wait for period;
				clock <= '1';
				
				regWriteData <= std_logic_vector(to_signed(10928, 128)); --0x1432
                regWriteAddress <= std_logic_vector(to_signed(15, 5));
				addressA <= std_logic_vector(to_signed(0, 5));
                addressB <= std_logic_vector(to_signed(1, 5));
                addressC <= std_logic_vector(to_signed(15, 5));
				
				wait for period;
				
				
				
				stop;
				
        end process;
end tb;