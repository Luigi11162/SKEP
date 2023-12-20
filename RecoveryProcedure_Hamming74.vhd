LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY recovery_procedure_hamming_74 IS
    PORT (
        clock : IN STD_LOGIC;
        message_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        parity_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        recovered_data : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END recovery_procedure_hamming_74;

ARCHITECTURE Behavioral OF recovery_procedure_hamming_74 IS
    SIGNAL sketch : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL control_code : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            sketch(6) <= message_data(3);
            sketch(5) <= message_data(2);
            sketch(4) <= message_data(1);
            sketch(2) <= message_data(0);
            sketch(3) <= parity_data(2);
            sketch(1) <= parity_data(1);
            sketch(0) <= parity_data(0);
            control_code(0) <= message_data(0) XOR message_data(1) XOR message_data(3) XOR parity_data(0);
            control_code(1) <= message_data(0) XOR message_data(2) XOR message_data(3) XOR parity_data(1);
            control_code(2) <= message_data(1) XOR message_data(2) XOR message_data(3) XOR parity_data(2);
            
            recovered_data <= sketch;
            
            IF TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code)) > 0 THEN
                recovered_data(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code))-1) <= NOT(sketch(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code))-1));
            END IF;
        END IF;

    END PROCESS;
END Behavioral;