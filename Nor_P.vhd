LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY nor_p IS
    PORT (
        clock : IN STD_LOGIC;
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        c : OUT STD_LOGIC;
        d : OUT STD_LOGIC
    );
END nor_p;

ARCHITECTURE Behavioral OF nor_p IS
BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            c<= a NOR b;
            d<= a NOR b;
        END IF;
    END PROCESS;
END Behavioral;