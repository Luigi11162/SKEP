LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY secure_sketch_hamming_74 IS
    PORT (
        clock : IN STD_LOGIC;
        input_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        parity_data : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END secure_sketch_hamming_74;

ARCHITECTURE Behavioral OF secure_sketch_hamming_74 IS
BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            -- Hamming(7,4) encoding logic
            parity_data(2) <= input_data(3) XOR input_data(1) XOR input_data(0);
            parity_data(1) <= input_data(3) XOR input_data(2) XOR input_data(0);
            parity_data(0) <= input_data(3) XOR input_data(2) XOR input_data(1);
        END IF;
    END PROCESS;
END Behavioral;

