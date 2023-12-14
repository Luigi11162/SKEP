LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_2to1 IS
    PORT ( sel : IN  STD_LOGIC; -- select input
    a : IN  STD_LOGIC;      -- input
    b : IN STD_LOGIC;       -- input
    x : OUT STD_LOGIC);     -- output
END mux_2to1;

ARCHITECTURE Behavioral OF mux_2to1 IS
BEGIN
    WITH sel SELECT
    x <= a WHEN '0',
    b WHEN '1',
    '0'  WHEN OTHERS;
END Behavioral;