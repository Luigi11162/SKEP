LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY SecureSketch_Hamming74 IS
    PORT ( input_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        secure_sketch : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END SecureSketch_Hamming74;

ARCHITECTURE Behavioral OF SecureSketch_Hamming74 IS
BEGIN
    PROCESS(input_data)
    BEGIN
-- Hamming(7,4) encoding logic
        secure_sketch(6) <= input_data(3);
        secure_sketch(5) <= input_data(2);
        secure_sketch(4) <= input_data(1);
        secure_sketch(3) <= input_data(3) XOR input_data(1) XOR input_data(0);
        secure_sketch(2) <= input_data(0);
        secure_sketch(1) <= input_data(3) XOR input_data(2) XOR input_data(0);
        secure_sketch(0) <= input_data(3) XOR input_data(2) XOR input_data(1);
    END PROCESS;
END Behavioral;

