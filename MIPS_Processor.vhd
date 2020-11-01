library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Humberto Tello A01196965 
-- Pablo Cesar Ruiz A01197044

entity Add is
	Port (A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
			B: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
			C: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end Add;


architecture Behavioral of Add is
	begin
	
		C <= A + B;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ShiftLeft2_26 is
	Port (A: in STD_LOGIC_VECTOR (25 DOWNTO 0) := (others => '0');
			B: out STD_LOGIC_VECTOR (27 DOWNTO 0) := (others => '0'));
end ShiftLeft2_26;

architecture Behavioral of ShiftLeft2_26 is
	begin
		B <= A & "00";
	
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ShiftLeft2 is
	Port(A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  B: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end ShiftLeft2;

architecture Behavioral of ShiftLeft2 is
	begin
				B <= A(29 DOWNTO 0) & "00";
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Program_counter is
	Port (D: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		Q: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		RESET: in STD_LOGIC := '0';
		CLK: in STD_LOGIC :='0');
end Program_counter;

architecture Behavioral of Program_counter is
	begin
		process(RESET,CLK)
			begin
				if(RESET = '1') then
					Q <= (others => '0');
				elsif (CLK = '1' and CLK'EVENT) then
					Q <= D;
				else null;
				end if;
		end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Sign_extender is
	Port(A: in STD_LOGIC_VECTOR (15 DOWNTO 0) := (others => '0');
		  B: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end Sign_extender;

architecture Behavioral of Sign_extender is
	begin
		Process(A(15)) is
			begin
				if(A(15) = '1') then
					B <= "1111111111111111" & A(15 DOWNTO 0);
				else 
					B <= "0000000000000000" & A(15 DOWNTO 0);
				end if;
			end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Mux2_1_32 is
	Port(A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  B: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  SELECTOR: in STD_LOGIC := '0';
		  C: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end Mux2_1_32;

architecture Behavioral of Mux2_1_32 is
	begin
		C <= A when (SELECTOR = '0') else B;
end Behavioral; 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Mux2_1_5 is
	Port(A: in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
		  B: in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
		  SELECTOR: in STD_LOGIC := '0';
		  C: out STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0'));
end Mux2_1_5;

architecture Behavioral of Mux2_1_5 is
	begin
		C <= A when (SELECTOR = '0') else B;
end Behavioral; 
		  
		  
				
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Humberto Tello A01196965 
-- Pablo C. Ruiz A01197044

entity ALU is
    Port(
        A: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        B: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        CONTROL: in STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
        ZERO: out std_logic := '0';
        RESULT: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end ALU;

architecture Behavioral of ALU is
	 signal RAUX : STD_LOGIC_VECTOR(31 downto 0);
    begin
        process(A,B,CONTROL)
			begin
					 RAUX <= (others => '0');
                case CONTROL is
                    when "000" => 
								RAUX <= A and B;
                    when "001" =>  
								RAUX <= A or B;
                    when "010" =>
								RAUX <= A + B;
                    when "011" =>   
								RAUX <= A;
                    when "100" =>   
								RAUX <= B(15 downto 0) & x"0000";
                    when "110" =>    
								RAUX <= A - B;
                    when "111" =>
								if(A < B) then  
									 RAUX <= "00000000000000000000000000000001";
                        else
									 RAUX <= "00000000000000000000000000000000";
                        end if;
						  when others =>
								RAUX <= (others => '0');
                end case;
			end process;
			zero <= '1' when RAUX(31 DOWNTO 0) = "00000000000000000000000000000000" else '0';
			RESULT <= RAUX(31 DOWNTO 0);
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


-- Humberto Tello A01196965 
-- Pablo C. Ruiz A01197044

entity MemoriaDeInstrucciones is
    Port(
		  READ_ADRESS: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        INSTRUCTION: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
		  );
end MemoriaDeInstrucciones;

architecture Behavioral of MemoriaDeInstrucciones is
    type arreglo is array (0 to 31) of STD_LOGIC_VECTOR(0 to 31);
    signal arr : arreglo;
	 signal arr_i : STD_LOGIC_VECTOR(4 downto 0);
    begin
	 
		  arr(0) <= "00100001001010100101100000100000";
        arr(1) <= "00000001001010100101100000100010";
        arr(3) <= "10001101001010100101100000100000";
        arr(2) <= x"00000002";
        arr(4) <= x"00000004";
        arr(5) <= x"00000005";
        arr(6) <= x"00000006";
        arr(7) <= x"00000007";
        arr(8) <= x"00000008";
        arr(9) <= x"00000009";
        arr(10) <= x"00000010";
        arr(11) <= x"00000011";
        arr(12) <= x"00000012";
        arr(13) <= x"00000013";
        arr(14) <= x"00000014";
        arr(15) <= x"00000015";
        arr(16) <= x"00000016";
        arr(17) <= x"00000017";
        arr(18) <= x"00000018";
        arr(19) <= x"00000019";
        arr(20) <= x"00000020";
        arr(21) <= x"00000021";
        arr(22) <= x"00000022";
        arr(23) <= x"00000023";
        arr(24) <= x"00000024";
        arr(25) <= x"00000025";
        arr(26) <= x"00000026";
        arr(27) <= x"00000027";
        arr(28) <= x"00000028";
        arr(29) <= x"00000029";
        arr(30) <= x"00000030";
        arr(31) <= x"00000031";
		  
		  arr_i <= READ_ADRESS(6 downto 2);
		  INSTRUCTION <= arr(to_integer(unsigned(arr_i)));
		 
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MemoriaDeDatos is
    Port(
        ENABLE: in std_logic := '0';
        WRITE_ENABLE: in std_logic := '0';
        ADDRESS: in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
        CLK: in std_logic := '0';
        WRITE_DATA: in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
        READ_ENABLE: in std_logic := '0';
        READ_DATA: out STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
end MemoriaDeDatos;
architecture Behavioral of MemoriaDeDatos is

	
   --signal arr : arreglo;
	signal arr_i : STD_LOGIC_VECTOR(4 downto 0);
	begin
		arr_i <= ADDRESS(6 downto 2); 
		process(ENABLE,CLK,WRITE_ENABLE,READ_ENABLE,arr_i) 
			type arreglo is array (0 to 31) of STD_LOGIC_VECTOR(0 to 31);
			VARIABLE arr : arreglo :=(
				others => (others => '0')
			);
			begin
				if(ENABLE = '0') then
					if(WRITE_ENABLE = '1' and READ_ENABLE = '0') then
						if(falling_edge(CLK)) then
							arr(to_integer(unsigned(arr_i))) := WRITE_DATA;
							READ_DATA <= (others => '0');
						end if;
					elsif (WRITE_ENABLE = '0' and READ_ENABLE = '1') then
							READ_DATA <= arr(to_integer(unsigned(arr_i)));
					else
							READ_DATA <= (others => '0');
					end if;
				else
					READ_DATA <= (others => '0');
				end if;
		end process;
end Behavioral; 
						
							
							
						



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package en_array_pkg is
	type array_32 is array (0 to 31) of std_logic_vector(31 downto 0);
end en_array_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.en_array_pkg.all;
use IEEE.NUMERIC_STD.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoder5_32 is
	Port(
		WriteReg: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RegWrite: IN STD_LOGIC;
		Enabler: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0')
	);
end Decoder5_32;

architecture Behavioral of Decoder5_32 is
	begin
		Enabler(0) <= '1' when RegWrite = '1' and WriteReg =  "00000" else '0';
		Enabler(1) <= '1' when RegWrite = '1' and WriteReg =  "00001" else '0';
		Enabler(2) <= '1' when RegWrite = '1' and WriteReg =  "00010" else '0';
		Enabler(3) <= '1' when RegWrite = '1' and WriteReg =  "00011" else '0';
		Enabler(4) <= '1' when RegWrite = '1' and WriteReg =  "00100" else '0';
		Enabler(5) <= '1' when RegWrite = '1' and WriteReg =  "00101" else '0';
		Enabler(6) <= '1' when RegWrite = '1' and WriteReg =  "00110" else '0';
		Enabler(7) <= '1' when RegWrite = '1' and WriteReg =  "00111" else '0';
		Enabler(8) <= '1' when RegWrite = '1' and WriteReg =  "01000" else '0';
		Enabler(9) <= '1' when RegWrite = '1' and WriteReg =  "01001" else '0';
		Enabler(10) <= '1' when RegWrite = '1' and WriteReg = "01010" else '0';
		Enabler(11) <= '1' when RegWrite = '1' and WriteReg = "01011" else '0';
		Enabler(12) <= '1' when RegWrite = '1' and WriteReg = "01100" else '0';
		Enabler(13) <= '1' when RegWrite = '1' and WriteReg = "01101" else '0';
		Enabler(14) <= '1' when RegWrite = '1' and WriteReg = "01110" else '0';
		Enabler(15) <= '1' when RegWrite = '1' and WriteReg = "01111" else '0';
		Enabler(16) <= '1' when RegWrite = '1' and WriteReg = "10000" else '0';
		Enabler(17) <= '1' when RegWrite = '1' and WriteReg = "10001" else '0';
		Enabler(18) <= '1' when RegWrite = '1' and WriteReg = "10010" else '0';
		Enabler(19) <= '1' when RegWrite = '1' and WriteReg = "10011" else '0';
		Enabler(20) <= '1' when RegWrite = '1' and WriteReg = "10100" else '0';
		Enabler(21) <= '1' when RegWrite = '1' and WriteReg = "10101" else '0';
		Enabler(22) <= '1' when RegWrite = '1' and WriteReg = "10110" else '0';
		Enabler(23) <= '1' when RegWrite = '1' and WriteReg = "10111" else '0';
		Enabler(24) <= '1' when RegWrite = '1' and WriteReg = "11000" else '0';
		Enabler(25) <= '1' when RegWrite = '1' and WriteReg = "11001" else '0';
		Enabler(26) <= '1' when RegWrite = '1' and WriteReg = "11010" else '0';
		Enabler(27) <= '1' when RegWrite = '1' and WriteReg = "11011" else '0';
		Enabler(28) <= '1' when RegWrite = '1' and WriteReg = "11100" else '0';
		Enabler(29) <= '1' when RegWrite = '1' and WriteReg = "11101" else '0';
		Enabler(30) <= '1' when RegWrite = '1' and WriteReg = "11110" else '0';
		Enabler(31) <= '1' when RegWrite = '1' and WriteReg = "11111" else '0';
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.en_array_pkg.all;
use IEEE.NUMERIC_STD.all;

entity Mux32_1 is
	Port(
		ReadReg : IN STD_LOGIC_VECTOR(4 downto 0);
		array_32_in : IN array_32;
		ReadData: out STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
	);
end Mux32_1;

architecture Behavioral of Mux32_1 is
	begin
		ReadData <= array_32_in(to_integer(unsigned(ReadReg)));
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.en_array_pkg.all;
use IEEE.NUMERIC_STD.all;

entity Registers is
	port(
		WriteData : IN std_logic_vector(31 downto 0);
		CLK: in std_logic;
		Enabler: in std_logic;
		Q: OUT std_logic_vector(31 downto 0) := (others => '0')
	);
end Registers;

architecture Behavioral of Registers is
	begin
		process(CLK,Enabler)
			begin
			if(CLK = '1' and CLK'EVENT) then
				if(Enabler = '1') then
					Q <= WriteData;
				end if;
			end if;
		end process;
	
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.en_array_pkg.all;
use IEEE.NUMERIC_STD.all;

entity RegisterFile is
	port(
		WriteReg : IN std_logic_vector(4 downto 0);
		RegWrite : IN std_logic;
		CLK: IN std_logic;
		WriteData: IN std_logic_vector(31 downto 0);
		ReadReg1 : IN std_logic_vector(4 downto 0);
		ReadReg2 : IN std_logic_vector(4 downto 0);
		ReadData1: OUT std_logic_vector(31 downto 0);
		ReadData2: OUT std_logic_vector(31 downto 0)
	);
end RegisterFile;



architecture Behavioral of RegisterFile is
signal Enabler : std_logic_vector(31 downto 0);
signal array_32_in : array_32 := (others=>(others => '0'));

component Decoder5_32 is
	Port(
		WriteReg: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RegWrite: IN STD_LOGIC;
		Enabler: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component Registers is
	port(
		WriteData : IN std_logic_vector(31 downto 0);
		CLK: in std_logic;
		Enabler: in std_logic;
		Q: OUT std_logic_vector(31 downto 0)
	);
end component;

component Mux32_1 is
	Port(
		ReadReg : IN STD_LOGIC_VECTOR(4 downto 0);
		array_32_in : IN array_32;
		ReadData: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

	begin
		Decoder5_32_tag : Decoder5_32 Port Map(WriteReg,RegWrite,Enabler);
		GEN_REG:
			for I in 0 to 31 generate
				ZeroReg: if I=0 generate
					ZR: Registers port map
						(x"00000000",CLK,Enabler(I),array_32_in(I));
				end generate ZeroReg;
				XReg: if I > 0 generate 
					REGX: Registers port map
						(WriteData,CLK,Enabler(I),array_32_in(I));
				end generate XReg;
			end generate GEN_REG;
		Mux32_1_1 : Mux32_1 Port Map(ReadReg1,array_32_in,ReadData1);
		Mux32_1_2 : Mux32_1 Port Map(ReadReg2,array_32_in,ReadData2);
end Behavioral;
		




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
	Port(
		OpCode: in STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
		RegDst: out STD_LOGIC := '0';
		Jump: out STD_LOGIC := '0';
		Branch: out STD_LOGIC := '0';
		MemRead: out STD_LOGIC := '0';
		MemToReg: out STD_LOGIC := '0';
		ALUop: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		MemWrite: out STD_LOGIC := '0';
		ALUSrc: out STD_LOGIC := '0';
		RegWrite: out STD_LOGIC := '0'
		);
end ControlUnit;

architecture Behavioral of ControlUnit is
	signal OUTAux : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
	begin

	OUTaux <= "10000101001" when OpCode = "000000" else
				 "00011010011" when OpCode = "100011" else
				 "-000-010110" when OpCode = "101011" else
				 "-010-110000" when OpCode = "000100" else
				 "-100----0-0" when OpCode = "000010" else
				 "00000010011" when OpCode = "001000" else
				 "00000001011" when OpCode = "001101" else 
				 "00000100011" when OpCode = "001111" else 
				 "00000000000";
				 
	RegDst <= OUTaux(10);
	Jump <= OUTAux(9);
	Branch <= OUTAux(8);
	MemRead <= OUTAux(7);
	MemToReg <= OUTAux(6);
	ALUop <= OUTAux(5 downto 3);
	MemWrite <= OUTAux(2);
	ALUSrc <= OUTAux(1);
	RegWrite <= OUTAux(0);
	
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
	port(
		Funct: in STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
		ALUop: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		ALUCntr: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		Jr: out STD_LOGIC := '0'
	);
end ALUControl;

architecture behavioral of ALUControl is
	signal OUTAux : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	begin
		OUTAux <= "0100" when Funct = "100000" and ALUop = "101" else
					 "1100" when Funct = "100010" and ALUop = "101" else
					 "0000" when Funct = "100101" and ALUop = "101" else
					 "0010" when Funct = "100101" and ALUop = "101" else
					 "1110" when Funct = "101010" and ALUop = "101" else
					 "---1" when Funct = "001000" and ALUop = "101" else
					 ALUop & '0';
					 
		ALUCntr <= OUTAux(3 downto 1);
		Jr <= OUTAux(0);
end behavioral;
					 



		
			
---------------------------------------------------
----------------------------------------------------
-----------------------------------------------------
---------------------------------------------------
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_Processor is
	Port(
		CLK: in STD_LOGIC := '0';
		RESET: in STD_LOGIC := '0';
		INSTRUCTION_OUT3: out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end MIPS_Processor;

architecture Behavioral of MIPS_Processor is

component MemoriaDeInstrucciones is
	Port(
		  READ_ADRESS: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        INSTRUCTION: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
	);
end component;

component MemoriaDeDatos is
    Port(
        ENABLE: in std_logic := '0';
        WRITE_ENABLE: in std_logic := '0';
        ADDRESS: in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
        CLK: in std_logic := '0';
        WRITE_DATA: in STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
        READ_ENABLE: in std_logic := '0';
        READ_DATA: out STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
end component;

component RegisterFile is
	port(
		WriteReg : IN std_logic_vector(4 downto 0);
		RegWrite : IN std_logic;
		CLK: IN std_logic;
		WriteData: IN std_logic_vector(31 downto 0);
		ReadReg1 : IN std_logic_vector(4 downto 0);
		ReadReg2 : IN std_logic_vector(4 downto 0);
		ReadData1: OUT std_logic_vector(31 downto 0);
		ReadData2: OUT std_logic_vector(31 downto 0)
	);
end component;

component ControlUnit is
	Port(
		OpCode: in STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
		RegDst: out STD_LOGIC := '0';
		Jump: out STD_LOGIC := '0';
		Branch: out STD_LOGIC := '0';
		MemRead: out STD_LOGIC := '0';
		MemToReg: out STD_LOGIC := '0';
		ALUop: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		MemWrite: out STD_LOGIC := '0';
		ALUSrc: out STD_LOGIC := '0';
		RegWrite: out STD_LOGIC := '0'
		);
end component;

component ALUControl is
	port(
		Funct: in STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
		ALUop: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		ALUCntr: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		Jr: out STD_LOGIC := '0'
	);
end component;

component Program_counter is
	Port (D: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		Q: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
		RESET: in STD_LOGIC := '0';
		CLK: in STD_LOGIC :='0');
end component;

component Add is
	Port (A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
			B: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
			C: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end component;

component ShiftLeft2_26 is
	Port (A: in STD_LOGIC_VECTOR (25 DOWNTO 0) := (others => '0');
			B: out STD_LOGIC_VECTOR (27 DOWNTO 0) := (others => '0'));
end component;

component ShiftLeft2 is
	Port(A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  B: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end component;

component Sign_extender is
	Port(A: in STD_LOGIC_VECTOR (15 DOWNTO 0) := (others => '0');
		  B: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end component;

component Mux2_1_32 is
	Port(A: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  B: in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
		  SELECTOR: in STD_LOGIC := '0';
		  C: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0'));
end component;

component Mux2_1_5 is
	Port(A: in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
		  B: in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
		  SELECTOR: in STD_LOGIC := '0';
		  C: out STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0'));
end component;

component ALU is
    Port(
        A: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        B: in STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
        CONTROL: in STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
        ZERO: out std_logic := '0';
        RESULT: out STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end component;
	
	signal INSTRUCTION : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal INSTRUCTION_Aux : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal INSTRUCTION_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal INSTRUCTION_OUT2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	
	signal REGISTER1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others  => '0');
	signal REGISTER2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others  => '0');
	signal ALUOUT : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal SIGN_EXTENDED : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal ALU_SOURCE : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	signal READ_ENABLE : STD_LOGIC := '0';
	signal WRITE_ENABLE : STD_LOGIC := '0';
	
	signal Write_Register_Aux : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal Read_Data_Mem : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal Write_Data_Aux : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	
	signal RegDst: STD_LOGIC := '0';
	signal Jump: STD_LOGIC := '0';
	signal Branch: STD_LOGIC := '0';
	signal MemRead: STD_LOGIC := '0';
	signal MemToReg: STD_LOGIC := '0';
	signal ALUop: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal MemWrite: STD_LOGIC := '0';
	signal ALUSrc: STD_LOGIC := '0';
	signal RegWrite: STD_LOGIC := '0';
	signal zero : STD_LOGIC := '0';
	
	signal ALUCntr : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal Jr : STD_LOGIC := '0';
	
begin

	INSTRUCTION <= x"00000004" + 4;
	MemoriaDeInstrucciones_tag : MemoriaDeInstrucciones port map(INSTRUCTION_Aux,INSTRUCTION_OUT);
	MemoriaDeDatos_tag : MemoriaDeDatos port map('0',MemWrite,INSTRUCTION,CLK,INSTRUCTION,MemRead,Read_Data_Mem);
	Mux2_1_32tag2 : Mux2_1_32 port map(ALUOUT,Read_Data_Mem,MemToReg,Write_Data_Aux);
	RegisterFile_tag : RegisterFile port map(Write_Register_Aux,RegWrite,CLK,Write_Data_Aux,INSTRUCTION_OUT(25 DOWNTO 21),INSTRUCTION_OUT(20 DOWNTO 16),REGISTER1,REGISTER2);
	Mux2_1_5_tag : Mux2_1_5 port map (INSTRUCTION_OUT(20 DOWNTO 16),INSTRUCTION_OUT(15 DOWNTO 11),RegDst,Write_Register_Aux);
	ControlUnit_tag : ControlUnit port map(INSTRUCTION_OUT(31 DOWNTO 26),RegDst,Jump,Branch,MemRead,MemToReg,ALUop,MemWrite,AluSrc,RegWrite);
	ProgramCounter : Program_Counter port map(INSTRUCTION,INSTRUCTION_AUX,RESET,CLK);
	
	ALUControl_Tag : ALUControl port map(INSTRUCTION_OUT(5 downto 0),ALUop,ALUCntr,Jr);
	ALU_Tag : ALU port map(REGISTER1,ALU_SOURCE,ALUCntr,zero,ALUOUT);
	Sign_Extender_Tag : Sign_Extender port map(INSTRUCTION_OUT(15 DOWNTO 0),SIGN_EXTENDED);
	Mux2_1_32_tag1 : Mux2_1_32 port map(REGISTER2,SIGN_EXTENDED,ALUsrc,ALU_SOURCE);
	
	
	


	
	INSTRUCTION_OUT3 <= INSTRUCTION_OUT2;
	

end Behavioral;

