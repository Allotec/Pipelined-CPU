-------------------------------------------------------------------------------
--
-- Title       : Arithmetic and Logic Unit Testbench
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Sat Oct 23 17:52:37 2021
--
-------------------------------------------------------------------------------
--
-- Description : Tests each ALU function and asserts output
--
--
-------------------------------------------------------------------------------

library IEEE;				 
library pipelinedmultimediauintdesign;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;		  
use pipelinedmultimediauintdesign.all;

entity ALU_tb is
    end ALU_tb;


architecture tb of ALU_tb is
    signal rs1, rs2, rs3, rd : std_logic_vector(127 downto 0);
    signal cop : std_logic_vector(4 downto 0);

    begin
        --Portmap of testbench with the UUT
        UUT : entity alu port map(rs1 => rs1, rs2 => rs2, rs3 => rs3, rd => rd, cop => cop);

        tb1: process
			constant period: time := 20 ns;	  
			
			variable rs1Signed : signed(127 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000110101";
			variable rs2Signed : signed(127 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000100001110110001000000000000000000000000000000000";
			variable rs3Signed : signed(127 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000100010001000100000000000000000000000000000000";

            begin								
				--Tests for R4 Instruction Format
				
				--Test for Signed Integer Multiply-Add Low with Saturation
                rs1 <= std_logic_vector(to_signed(5170, 128)); --0x1432
                rs2 <= std_logic_vector(to_signed(4099, 128)); --0x1003
                rs3 <= std_logic_vector(to_signed(66, 128)); --0x0042
                cop <= std_logic_vector(to_unsigned(1, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 275704); --0x434F8
				
				
				--Test for Signed Integer Multiply-Add High with Saturation
				rs1 <= std_logic_vector(to_signed(458, 128)); --0x1CA
                rs2 <= std_logic_vector(to_signed(274895457, 128)); --0x10629261
                rs3 <= std_logic_vector(to_signed(354783973, 128)); --0x152592E5
                cop <= std_logic_vector(to_unsigned(2, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 22702580); --0x15A69F4
				

				--Test for Signed Integer Multiply-Subtract Low with Saturation
				rs1 <= std_logic_vector(to_signed(5170, 128)); --0x1432
                rs2 <= std_logic_vector(to_signed(4099, 128)); --0x1003
                rs3 <= std_logic_vector(to_signed(66, 128)); --0x0042
                cop <= std_logic_vector(to_unsigned(3, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 265364); --0x40C94	   
				
				
				--Test for Signed Integer Multiply-Subtract High with Saturation
				rs1 <= std_logic_vector(to_signed(458, 128)); --0x1CA
                rs2 <= std_logic_vector(to_signed(274895457, 128)); --0x10629261
                rs3 <= std_logic_vector(to_signed(354783973, 128)); --0x152592E5
                cop <= std_logic_vector(to_unsigned(4, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 22701664); --0x15A6660


				--Test for Signed Long Integer Multiply-Add Low with Saturation
                rs1 <= std_logic_vector(to_signed(5170, 128)); --0x1432
                rs2 <= std_logic_vector(to_signed(4099, 128)); --0x1003
                rs3 <= std_logic_vector(to_signed(66, 128)); --0x0042
                cop <= std_logic_vector(to_unsigned(5, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 275704); --0x434F8
				
				
				--Test for Signed Long Integer Multiply-Add High with Saturation
				rs1 <= std_logic_vector(rs1Signed); --0x435
                rs2 <= std_logic_vector(rs2Signed); --0x0000876200000000
                rs3 <= std_logic_vector(rs3Signed); --0x0000111100000000
                cop <= std_logic_vector(to_unsigned(6, 5));	  
				
                wait for period;
                assert (to_integer(signed(rd(31 downto 0))) = 151421879); --0x90683B7
				

				--Test for Signed Long Integer Multiply-Subtract Low with Saturation
				rs1 <= std_logic_vector(to_signed(5170, 128)); --0x1432
                rs2 <= std_logic_vector(to_signed(4099, 128)); --0x1003
                rs3 <= std_logic_vector(to_signed(66, 128)); --0x0042
                cop <= std_logic_vector(to_unsigned(7, 5));
				
                wait for period;
                assert (to_integer(signed(rd)) = 265364); --0x40C94	   
				
				
				--Test for Signed Long Integer Multiply-Subtract High with Saturation
				rs1 <= std_logic_vector(rs1Signed); --0x435
                rs2 <= std_logic_vector(rs2Signed); --0x0000876200000000
                rs3 <= std_logic_vector(rs3Signed); --0x0000111173892341
                cop <= std_logic_vector(to_unsigned(8, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd(31 downto 0))) = 151419725); --0x9067B4D
				
				
				--Tests for R3 Instruction Format
					
				--Test for NOP (Output goes to 0 no matter what)
				rs1 <= std_logic_vector(rs1Signed); --0x435
                rs2 <= std_logic_vector(rs2Signed); --0x0000876200000000
                rs3 <= std_logic_vector(rs3Signed); --0x0000111173892341
                cop <= std_logic_vector(to_unsigned(9, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd(31 downto 0))) = 0); --0x9067B4D
				

				--Test for Add Halfword (AH)
				rs1 <= std_logic_vector(to_signed(338833920, 128)); --0x14323200
                rs2 <= std_logic_vector(to_signed(268653312, 128)); --0x10035300
                rs3 <= std_logic_vector(to_signed(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(10, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd)) = 607487232); --0x24358500
				
				
				--Test for Add Halfword Saturated (AHS)
				rs1 <= std_logic_vector(to_signed(338833920, 128)); --0x14323200
                rs2 <= std_logic_vector(to_signed(268653312, 128)); --0x10035300
                rs3 <= std_logic_vector(to_signed(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(11, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd)) = 607487232); --0x24358500
				
				
				--Test for Broadcast Words (BCW)
				rs1 <= std_logic_vector(to_signed(338833920, 128)); --0x14323200
                rs2 <= std_logic_vector(to_signed(268653312, 128)); --0x10035300
                rs3 <= std_logic_vector(to_signed(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(12, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd(31 downto 0))) = 338833920); --0x14323200
				assert (to_integer(signed(rd(63 downto 32))) = 338833920); --0x14323200
				assert (to_integer(signed(rd(95 downto 64))) = 338833920); --0x14323200
				assert (to_integer(signed(rd(127 downto 96))) = 338833920); --0x14323200
				
				
				--Test for Carry Generate Halfword (CGH)
				rs1 <= std_logic_vector(to_unsigned(338886655, 128)); --0x1432FFFF
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(13, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(15 downto 0))) = 1); --0x0001
				assert (to_integer(unsigned(rd(31 downto 16))) = 0); --0x0000
				
				
				--Test for Count Leading Zeros in Words (CLZ)
				rs1 <= std_logic_vector(to_unsigned(3342335, 128)); --0x0032FFFF
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(14, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(31 downto 0))) = 10); --0x000A
				
				
				--Test for Max Signed Word (MAX)
				rs1 <= std_logic_vector(to_unsigned(3339055, 128)); --0x0032F32F
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(15, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(31 downto 0))) = 268697599); --0x1003FFFF
				
				
				--Test for Min Signed Word (MIN)
				rs1 <= std_logic_vector(to_unsigned(3339055, 128)); --0x0032F32F
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(16, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(31 downto 0))) = 3339055); --0x0032F32F 
				
				
				--Test for Multiply Sign (MSGN)
				rs1 <= std_logic_vector(to_unsigned(3339055, 128)); --0x0032F32F
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(17, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(31 downto 0))) = 3339055); --0x0032F32F
					
					
					
				--Test for Count Ones in Halfwords (POPCNTH)
				rs1 <= std_logic_vector(to_unsigned(338886655, 128)); --0x1432FFFF
                rs2 <= std_logic_vector(to_unsigned(268697599, 128)); --0x1003FFFF
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(18, 5));		   	  
				
                wait for period;					
                assert (to_integer(unsigned(rd(15 downto 0))) = 16); --0xFFFF
				assert (to_integer(unsigned(rd(31 downto 16))) = 5); --0x0101
				
				
				--Test for Rotate Bits Right (ROT)
				rs1 <= std_logic_vector(to_unsigned(15, 128)); --0x0000000F
                rs2 <= std_logic_vector(to_unsigned(4194053, 128)); --0x003FFF05
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(19, 5));		   	  
				
                wait for period;
                assert (to_integer(unsigned(rd(127 downto 96))) = 2013265920); --0x78000000
				
				
				--Test for Rotate Bits in Word (ROTW)
				rs1 <= std_logic_vector(to_unsigned(15, 128)); --0x0000000F
                rs2 <= std_logic_vector(to_unsigned(4194053, 128)); --0x003FFF05
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(20, 5));		   	  
				
                wait for period;
                assert (to_integer(unsigned(rd(31 downto 0))) = 2013265920); --0x78000000  
				
				
				--Test for Subtract From Halfword (SFH)
				rs1 <= std_logic_vector(to_unsigned(338842368, 128)); --0x14325300
                rs2 <= std_logic_vector(to_unsigned(268644864, 128)); --0x10033200
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(22, 5));		   	  
				
                wait for period;
                assert (to_integer(unsigned(rd)) = 70197504); --0x042F2100
				
				
				--Test for Subtract From Halfword Saturated (SFHS)
				rs1 <= std_logic_vector(to_signed(338842368, 128)); --0x14325300
                rs2 <= std_logic_vector(to_signed(268644864, 128)); --0x10033200
                rs3 <= std_logic_vector(to_signed(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(23, 5));		   	  
				
                wait for period;
                assert (to_integer(signed(rd)) = 70197504); --0x042F2100
				
				--Test for XOR
				rs1 <= std_logic_vector(to_unsigned(338842368, 128)); --0x14325300
                rs2 <= std_logic_vector(to_unsigned(268644864, 128)); --0x10033200
                rs3 <= std_logic_vector(to_unsigned(4329984, 128)); --0x00421200
                cop <= std_logic_vector(to_unsigned(24, 5));		   	  
				
                wait for period;
                assert (to_integer(unsigned(rd)) = 70344960); --0x4316100
				
				
                wait;
        end process;

end tb;



