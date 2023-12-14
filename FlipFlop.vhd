LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY flip_flop IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN  STD_LOGIC;      -- input
        r : IN STD_LOGIC;       -- input
        q : OUT STD_LOGIC;      -- output
        q_n : OUT STD_LOGIC     -- output
    );
END flip_flop;

ARCHITECTURE Behavioral OF flip_flop IS
    COMPONENT nor_p IS
        PORT(
            clock : IN STD_LOGIC;
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            c : OUT STD_LOGIC;
            d : OUT STD_LOGIC
        );
    END COMPONENT;
    
    SIGNAL out_nor_1 : STD_LOGIC;
    SIGNAL out_nor_2 : STD_LOGIC;
BEGIN
        nor_1 : nor_p 
        PORT MAP(
            clock => clk,
            a=>s,
            b=>out_nor_2,
            c=>q_n,
            d=>out_nor_1
        );
        
        nor_2 : nor_p 
        PORT MAP(
            clock => clk,
            a=>r,
            b=>out_nor_1,
            c=>q,
            d=>out_nor_2
        );
    
END Behavioral;