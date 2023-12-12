LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY RecoveryProcedure_Hamming74 IS
    PORT ( sketch : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        recovered_data : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END RecoveryProcedure_Hamming74;
ARCHITECTURE Behavioral OF RecoveryProcedure_Hamming74 IS
    SIGNAL message_data : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL parity_data : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL control_code : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    PROCESS(sketch, message_data, parity_data, control_code)
    BEGIN
        message_data(3) <= sketch(6);
        message_data(2) <= sketch(5);
        message_data(1) <= sketch(4);
        message_data(0) <= sketch(2);
        parity_data(2) <= sketch(3);
        parity_data(1) <= sketch(1);
        parity_data(0) <= sketch(0);
        control_code(0) <= message_data(0) XOR message_data(1) XOR message_data(3) XOR parity_data(0);
        control_code(1) <= message_data(0) XOR message_data(2) XOR message_data(3) XOR parity_data(1);
        control_code(2) <= message_data(1) XOR message_data(2) XOR message_data(3) XOR parity_data(2);

        recovered_data <= sketch;
        
        IF TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code)) > 0 THEN
            recovered_data(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code))-1) <= NOT(sketch(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(control_code))-1));
        END IF;


    END PROCESS;
END Behavioral;