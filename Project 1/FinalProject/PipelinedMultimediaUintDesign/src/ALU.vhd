-------------------------------------------------------------------------------
--
-- Title       : Arithmetic and Logic Unit
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Sat Oct 23 15:52:37 2021
--
-------------------------------------------------------------------------------
--
-- Description : Takes in three 128 bit values and one 5 bit value to compute
-- result and store it on one 128 bit output.
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity ALU is
	port(		 
		--Input
		rs1 : in std_logic_vector(127 downto 0);
        rs2 : in std_logic_vector(127 downto 0);
        rs3 : in std_logic_vector(127 downto 0);
        cop : in std_logic_vector(4 downto 0);
		
		--Output
		rd : out std_logic_vector(127 downto 0)
		
		);
end ALU;


architecture behavioral of ALU is 

	--Control == 0 is an integer
	--Control == 1 is a long
	function saturatedRounding(num : std_logic_vector(127 downto 0); control : integer)
		return std_logic_vector is 
		
		variable maxInt : signed(127 downto 0) := to_signed((2 ** 31) - 1, 128);
		variable minInt : signed(127 downto 0) := to_signed(-1 * (2 ** 31), 128);
		variable maxLong : signed(127 downto 0) := to_signed((2 ** 63) - 1, 128);
		variable minLong : signed(127 downto 0) := to_signed(-1 * (2 ** 31), 128);
		
    	begin			 
			if(signed(num) > maxInt and control = 0) then
				return(std_logic_vector(maxInt(127 downto 0)));
			
			elsif(signed(num) < minInt and control = 0) then
				return(std_logic_vector(minInt(127 downto 0)));
				
			elsif(signed(num) > maxLong and control = 1) then
				return(std_logic_vector(maxLong(127 downto 0)));
				
			elsif(signed(num) < minLong and control = 1) then
				return(std_logic_vector(minLong(127 downto 0)));
				
			else
				return(num);
			end if;
			
	end saturatedRounding;


    begin
        computation: process(rs1, rs2, rs3, cop)
			variable out1 : std_logic_vector(127 downto 0);
			variable rs1v : std_logic_vector(127 downto 0);
			variable rs2v : std_logic_vector(127 downto 0);
			variable rs3v : std_logic_vector(127 downto 0);
            
            variable count : integer range 0 to 33;
            variable LSB : std_logic_vector(0 downto 0);

            begin										  
				rs1v := rs1;
				rs2v := rs2;
				rs3v := rs3;

                --Load Immediate
                --Immediate value will be loaded into rs1 and index value will be loaded into rs2 both zero extended
                if(to_integer(unsigned(cop(4 downto 0))) = 0) then			 
					out1(127 downto 0) := std_logic_vector(to_unsigned(0, 128));
                    out1((16 * to_integer(unsigned(rs2)) + 15) downto (16 * to_integer(unsigned(rs2)))) := rs1(15 downto 0);
                    
                --R4 Instruction Format

                --Signed Integer Multiply-Add Low with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 1) then
                    out1(31 downto 0) := std_logic_vector(signed(rs2v(15 downto 0)) * signed(rs3v(15 downto 0)) + signed(rs1v(31 downto 0)));
                    out1 := saturatedRounding(out1, 0);

                --Signed Integer Multiply-Add High with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 2) then
					out1(31 downto 0) := std_logic_vector(signed(rs2v(31 downto 16)) * signed(rs3v(31 downto 16)) + signed(rs1v(31 downto 0)));
                    out1 := saturatedRounding(out1, 0);

                --Signed Integer Multiply-Subtract Low with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 3) then
                    out1(31 downto 0) := std_logic_vector(signed(rs2v(15 downto 0)) * signed(rs3v(15 downto 0)) - signed(rs1v(31 downto 0)));
                    out1 := saturatedRounding(out1, 0);

                --Signed Integer Multiply-Subtract High with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 4) then
					out1(31 downto 0) := std_logic_vector(signed(rs2v(31 downto 16)) * signed(rs3v(31 downto 16)) - signed(rs1v(31 downto 0)));
                    out1 := saturatedRounding(out1, 0);

                --Signed Long Integer Multiply-Add Low with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 5) then
                    out1(63 downto 0) := std_logic_vector(signed(rs2v(31 downto 0)) * signed(rs3v(31 downto 0)) + signed(rs1v(63 downto 0)));
                    out1 := saturatedRounding(out1, 1);

                --Signed Long Integer Multiply-Add High with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 6) then
                    out1(63 downto 0) := std_logic_vector(signed(rs2v(63 downto 32)) * signed(rs3v(63 downto 32)) + signed(rs1v(63 downto 0)));
                    out1 := saturatedRounding(out1, 1);

                --Signed Long Integer Multiply-Subtract Low with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 7) then
                    out1(63 downto 0) := std_logic_vector(signed(rs2v(31 downto 0)) * signed(rs3v(31 downto 0)) - signed(rs1v(63 downto 0)));
                    out1 := saturatedRounding(out1, 1);

                --Signed Long Integer Multiply-Subtract High with Saturation
                elsif(to_integer(unsigned(cop(4 downto 0))) = 8) then
                    out1(63 downto 0) := std_logic_vector(signed(rs2v(63 downto 32)) * signed(rs3v(63 downto 32)) - signed(rs1v(63 downto 0)));
                    out1 := saturatedRounding(out1, 1);

                --R3 Instruction Format

                --NOP
                elsif(to_integer(unsigned(cop(4 downto 0))) = 9) then
					out1(127 downto 0) := std_logic_vector(to_unsigned(0, 128));

                --Add Halfword (AH)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 10) then
                    for i in 0 to 7 loop
                        out1(16 * i + 15 downto 16 * i) := std_logic_vector(unsigned(rs1v((16 * i + 15) downto (16 * i))) + unsigned(rs2v((16 * i + 15) downto (16 * i))));
                    end loop;

                --Add Halfword Saturated (AHS)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 11) then
                    for i in 0 to 7 loop
                        if(to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) + signed(rs2v((16 * i + 15) downto (16 * i)))) < 32767 and to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) + signed(rs2v((16 * i + 15) downto (16 * i)))) > -32768) then
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(signed(rs1v((16 * i + 15) downto (16 * i))) + signed(rs2v((16 * i + 15) downto (16 * i))));                        
                        
                        elsif(to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) + signed(rs2v((16 * i + 15) downto (16 * i)))) > 32767) then
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(to_signed(32767, 16));

                        else
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(to_signed(-32768, 16));
                        
                        end if;
                    end loop;
					
				--Broadcast Words (BCW)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 12) then
                    for i in 0 to 3 loop
                        out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs1v(31 downto 0)));
                    end loop;
				
                --Carry Generate Halfword (CGH)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 13) then
					out1(127 downto 0) := std_logic_vector(to_unsigned(0, 128));
					
                    for i in 0 to 7 loop
                        if((to_integer(unsigned(rs1v((16 * i + 15) downto (16 * i)))) + to_integer(unsigned(rs2v((16 * i + 15) downto (16 * i))))) > 65535) then
                            out1(16 * i downto 16 * i) := "1";

                        else
                            out1(16 * i downto 16 * i) := "0";
                        
                        end if;	
                    end loop;

                --Count Leading Zeros in Words (CLZ)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 14) then
                    for i in 0 to 3 loop
                        while(count /= 32 and to_integer(unsigned(rs1v((32 * i + 31 - count) downto (32 * i + 31 - count)))) /= 1) loop
                            count := count + 1;
                        end loop;

                        out1(32 * i + 31 downto 32 * i) := std_logic_vector(to_unsigned(count, 32));
                        count := 0;
                    end loop;
					
				--Max Signed Word (MAX)
				elsif(to_integer(unsigned(cop(4 downto 0))) = 15) then
                    for i in 0 to 3 loop
                        if(signed(rs1v((32 * i + 31) downto (32 * i))) > signed(rs2v((32 * i + 31) downto (32 * i)))) then
                            out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs1v((32 * i + 31) downto (32 * i))));
                        else 
                            out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs2v((32 * i + 31) downto (32 * i))));
                        end if;
                    end loop;

                --Min Signed Word (MIN)
				elsif(to_integer(unsigned(cop(4 downto 0))) = 16) then
                    for i in 0 to 3 loop
                        if(signed(rs1v((32 * i + 31) downto (32 * i))) < signed(rs2v((32 * i + 31) downto (32 * i)))) then
                            out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs1v((32 * i + 31) downto (32 * i))));
                        else 
                            out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs2v((32 * i + 31) downto (32 * i))));
                        end if;
                    end loop;

                --Multiply Sign (MSGN) 
                elsif(to_integer(unsigned(cop(4 downto 0))) = 17) then
                    for i in 0 to 3 loop
						if(to_integer(signed(rs2v(32 * i + 31 downto 32 * i))) > 0) then
							out1(32 * i + 31 downto 32 * i) := std_logic_vector(signed(rs1v(32 * i + 31 downto 32 * i)));
						else										
							out1(32 * i + 31 downto 32 * i) := std_logic_vector(to_signed(-1 * to_integer(signed(rs1v(32 * i + 31 downto 32 * i))), 32));
						end if;

                    end loop;
                

                --Count Ones in Halfwords (POPCNTH)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 18) then
                    for i in 0 to 7 loop
                        for j in 0 to 15 loop
                            if(to_integer(unsigned(rs1v((16 * i + 15 - j) downto (16 * i + 15 - j)))) = 1) then
                                count := count + 1;
                            end if;
                        end loop;

                        out1(16 * i + 15 downto 16 * i) := std_logic_vector(to_unsigned(count, 16));
                        count := 0;
                    end loop;

                --Rotate Bits Right (ROT)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 19) then
                    for i in 0 to ((to_integer(unsigned(rs2v(6 downto 0)))) - 1) loop
                        LSB := rs1v(0 downto 0); 
						
						rs1v := std_logic_vector(shift_right(unsigned(rs1v), 1));
						
						rs1v := LSB & rs1v(126 downto 0);
                    end loop;

                    out1 := rs1v;

                --Rotate Bits in Word (ROTW)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 20) then
                    for i in 0 to (to_integer(unsigned(rs2v(4 downto 0))) - 1) loop
                        for j in 0 to 3 loop
                            LSB := rs1v(32 * j downto 32 * j);
							
							rs1v(32 * j + 31 downto 32 * j) := std_logic_vector(shift_right(unsigned(rs1v(32 * j + 31 downto 32 * j)), 1));
						
							rs1v(32 * j + 31 downto 32 * j) := LSB & rs1v(32 * j + 30 downto 32 * j);

                        end loop;
                    end loop;

                    out1 := rs1v;

                --Shift Left Halfword Immediate (SHLHI)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 21) then
					for i in 0 to 7 loop
						for j in 0 to ((to_integer(unsigned(rs2v(3 downto 0)))) - 1) loop
							rs1v(16 * i + 15 downto 16 * i) := std_logic_vector(shift_left(unsigned(rs1v(16 * i + 15 downto 16 * i)), 1));
						end loop;
                    end loop;

                    out1 := rs1v;

                --Subtract From Halfword (SFH)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 22) then
                    for i in 0 to 7 loop
                        out1(16 * i + 15 downto 16 * i) := std_logic_vector(unsigned(rs1v((16 * i + 15) downto (16 * i))) - unsigned(rs2v((16 * i + 15) downto (16 * i))));
                    end loop;

                --Subtract From Halfword Saturated (SFHS)
                elsif(to_integer(unsigned(cop(4 downto 0))) = 23) then
                    for i in 0 to 7 loop
                        if(to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) - signed(rs2v((16 * i + 15) downto (16 * i)))) < 32767 and to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) - signed(rs2v((16 * i + 15) downto (16 * i)))) > -32768) then
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(signed(rs1v((16 * i + 15) downto (16 * i))) - signed(rs2v((16 * i + 15) downto (16 * i))));                        
                        
                        elsif(to_integer(signed(rs1v((16 * i + 15) downto (16 * i))) - signed(rs2v((16 * i + 15) downto (16 * i)))) > 32767) then
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(to_signed(32767, 16));

                        else
                            out1(16 * i + 15 downto 16 * i) := std_logic_vector(to_signed(-32768, 16));
                        
                        end if;
                    end loop;

                --XOR
                elsif(to_integer(unsigned(cop(4 downto 0))) = 24) then
                    out1 := rs1v xor rs2v;

                --Invalid Cop value
                else
                    report "Invalid Cop value\n";

                end if;

                rd <= out1;
            end process;

end behavioral; 

