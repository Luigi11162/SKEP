LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cpa_scheme IS
    PORT (
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        message : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ciphertext : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END cpa_scheme;

ARCHITECTURE Behavioral OF cpa_scheme IS
    SIGNAL key : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL out_puf_0 : STD_LOGIC;
    SIGNAL out_puf_1 : STD_LOGIC;
    SIGNAL out_puf_2 : STD_LOGIC;
    SIGNAL out_puf_3 : STD_LOGIC;
    SIGNAL in_chaos_machine : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    COMPONENT arbiter_puf IS
        PORT(
            delay : IN STD_LOGIC;
            clock : IN STD_LOGIC;
            challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            response : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT chaos_machine IS
        PORT(
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            x_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            random_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT secure_sketch_hamming_74 IS
        PORT(
            input_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            secure_sketch : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT recovery_procedure_hamming_74 IS
        PORT(
            sketch : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            recovered_data : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
    
BEGIN
    
    arbiter_puf_0: arbiter_puf
    PORT MAP(
        delay => '1',
        clock => clock,
        challenge => challenge,
        response => out_puf_0
    );
    
    arbiter_puf_1: arbiter_puf
    PORT MAP(
        delay => '0',
        clock => clock,
        challenge => challenge,
        response => out_puf_1
    );
    
    arbiter_puf_2: arbiter_puf
    PORT MAP(
        delay => '0',
        clock => clock,
        challenge => challenge,
        response => out_puf_2
    );
    
    arbiter_puf_3: arbiter_puf
    PORT MAP(
        delay => '1',
        clock => clock,
        challenge => challenge,
        response => out_puf_3
    );
    
    in_chaos_machine(3) <= out_puf_3;
    in_chaos_machine(2) <= out_puf_2;
    in_chaos_machine(1) <= out_puf_1;
    in_chaos_machine(0) <= out_puf_0;
    
    chaos_machine_0: chaos_machine
    PORT MAP(
        clk => clock,
        reset => reset,
        x_in => in_chaos_machine,
        random_out => key
    );
    
    ciphertext <= message XOR key;
    
END Behavioral;