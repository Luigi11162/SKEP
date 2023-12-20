LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY enc_scheme IS
    PORT (
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        message : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ciphertext : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        helper_data : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END enc_scheme;

ARCHITECTURE Behavioral OF enc_scheme IS
    SIGNAL key : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL out_puf_0 : STD_LOGIC;
    SIGNAL out_puf_1 : STD_LOGIC;
    SIGNAL out_puf_2 : STD_LOGIC;
    SIGNAL out_puf_3 : STD_LOGIC;
    SIGNAL puf_response : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
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
            clock : IN STD_LOGIC;
            input_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            parity_data : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
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
    
    puf_response(3) <= out_puf_3;
    puf_response(2) <= out_puf_2;
    puf_response(1) <= out_puf_1;
    puf_response(0) <= out_puf_0;
    
    chaos_machine_0: chaos_machine
    PORT MAP(
        clk => clock,
        reset => reset,
        x_in => puf_response,
        random_out => key
    );
    
    secure_sketch_hamming_74_0: secure_sketch_hamming_74
    PORT MAP(
        clock => clock,
        input_data => puf_response,
        parity_data => helper_data
    );
    
    ciphertext <= message XOR key;
    
END Behavioral;