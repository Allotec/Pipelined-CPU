-------------------------------------------------------------------------------
--
-- Title       : Controller
-- Author      : Matthew Champagne
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- Generated   : Wed Nov 24 23:21:52 2021
--
-------------------------------------------------------------------------------
--
-- Description : Produces the control signals for the data path
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;



entity Control is
	port(
		--Input
		formatBits : in std_logic_vector(1 downto 0);
		r4Opcode : in std_logic_vector(2 downto 0);
		r3Opcode : in std_logic_vector(7 downto 0);

		--Output
		cop : out std_logic_vector(4 downto 0);
		regWrite : out std_logic
	);
	
end Control;


architecture behavioral of Control is

	begin
		controlGeneration : process(formatBits, r4Opcode, r3Opcode)

			begin
				regWrite <= '1'; --Assume memWrite is 1 and set as 0 for nop
				--Load Immediate Instruction Format
				if(formatBits = "00" or formatBits = "01") then
					cop <= std_logic_vector(to_unsigned(0, 5));
				--R4 Instruction format
				elsif(formatBits = "10") then
					--simal
					if(r4Opcode = "000") then
						cop <= std_logic_vector(to_unsigned(1, 5));

					--simah
					elsif(r4Opcode = "001") then
						cop <= std_logic_vector(to_unsigned(2, 5));

					--simsl
					elsif(r4Opcode = "010") then
						cop <= std_logic_vector(to_unsigned(3, 5));

					--simsh
					elsif(r4Opcode = "011") then
						cop <= std_logic_vector(to_unsigned(4, 5));

					--slimal
					elsif(r4Opcode = "100") then
						cop <= std_logic_vector(to_unsigned(5, 5));

					--slimah
					elsif(r4Opcode = "101") then
						cop <= std_logic_vector(to_unsigned(6, 5));

					--slimsl
					elsif(r4Opcode = "110") then
						cop <= std_logic_vector(to_unsigned(7, 5));

					--slimsh
					elsif(r4Opcode = "111") then
						cop <= std_logic_vector(to_unsigned(8, 5));

					end if;
				--R3 Instruction Format
				elsif(formatBits = "11") then
					--nop
					if(to_integer(unsigned(r3Opcode)) = 0) then
						cop <= std_logic_vector(to_unsigned(9, 5));
						regWrite <= '0';

					--ah
					elsif(to_integer(unsigned(r3Opcode)) = 1) then
						cop <= std_logic_vector(to_unsigned(10, 5));
						
					--ahs
					elsif(to_integer(unsigned(r3Opcode)) = 2) then
						cop <= std_logic_vector(to_unsigned(11, 5));

					--bcw
					elsif(to_integer(unsigned(r3Opcode)) = 3) then
						cop <= std_logic_vector(to_unsigned(12, 5));

					--cgh
					elsif(to_integer(unsigned(r3Opcode)) = 4) then
						cop <= std_logic_vector(to_unsigned(13, 5));

					--clz
					elsif(to_integer(unsigned(r3Opcode)) = 5) then
						cop <= std_logic_vector(to_unsigned(14, 5));

					--max
					elsif(to_integer(unsigned(r3Opcode)) = 6) then
						cop <= std_logic_vector(to_unsigned(15, 5));

					--min
					elsif(to_integer(unsigned(r3Opcode)) = 7) then
						cop <= std_logic_vector(to_unsigned(16, 5));

					--msgn
					elsif(to_integer(unsigned(r3Opcode)) = 8) then
						cop <= std_logic_vector(to_unsigned(17, 5));
						
					--popcnth
					elsif(to_integer(unsigned(r3Opcode)) = 9) then
						cop <= std_logic_vector(to_unsigned(18, 5));

					--rot
					elsif(to_integer(unsigned(r3Opcode)) = 10) then
						cop <= std_logic_vector(to_unsigned(19, 5));

					--rotw
					elsif(to_integer(unsigned(r3Opcode)) = 11) then
						cop <= std_logic_vector(to_unsigned(20, 5));

					--shlhi
					elsif(to_integer(unsigned(r3Opcode)) = 12) then
						cop <= std_logic_vector(to_unsigned(21, 5));

					--sfh
					elsif(to_integer(unsigned(r3Opcode)) = 13) then
						cop <= std_logic_vector(to_unsigned(22, 5));
					
					--sfhs
					elsif(to_integer(unsigned(r3Opcode)) = 14) then
						cop <= std_logic_vector(to_unsigned(23, 5));
					
					--xor
					elsif(to_integer(unsigned(r3Opcode)) = 15) then
						cop <= std_logic_vector(to_unsigned(24, 5));
					
					end if;

				end if;

		end process;

end behavioral;

