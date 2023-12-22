LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dec_scheme IS
    PORT (
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ciphertext : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        helper_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        message : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END dec_scheme;

ARCHITECTURE Behavioral OF dec_scheme IS
    SIGNAL key : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL out_puf_0 : STD_LOGIC;
    SIGNAL out_puf_1 : STD_LOGIC;
    SIGNAL out_puf_2 : STD_LOGIC;
    SIGNAL out_puf_3 : STD_LOGIC;
    SIGNAL puf_response : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL recovered_puf : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    COMPONENT arbiter_puf IS
        PORT(
            reset : IN STD_LOGIC;
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
    
    COMPONENT recovery_procedure_hamming_74 IS
        PORT(
            clock : IN STD_LOGIC;
            message_data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            parity_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            recovered_data : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    
BEGIN
    
    arbiter_puf_0: arbiter_puf
    PORT MAP(
        reset => reset,
        delay => '1',
        clock => clock,
        challenge => challenge,
        response => out_puf_0
    );
    
    arbiter_puf_1: arbiter_puf
    PORT MAP(
        reset => reset,
        delay => '0',
        clock => clock,
        challenge => challenge,
        response => out_puf_1
    );
    
    arbiter_puf_2: arbiter_puf
    PORT MAP(
        reset => reset,
        delay => '0',
        clock => clock,
        challenge => challenge,
        response => out_puf_2
    );
    
    arbiter_puf_3: arbiter_puf
    PORT MAP(
        reset => reset,
        delay => '1',
        clock => clock,
        challenge => challenge,
        response => out_puf_3
    );
    
    puf_response(3) <= out_puf_3;
    puf_response(2) <= out_puf_2;
    puf_response(1) <= out_puf_1;
    puf_response(0) <= out_puf_0;
    
    recovery_procedure_hamming_74_0: recovery_procedure_hamming_74
    PORT MAP(
        clock => clock,
        message_data => puf_response,
        parity_data => helper_data,
        recovered_data => recovered_puf
    );
    
    chaos_machine_0: chaos_machine
    PORT MAP(
        clk => clock,
        reset => reset,
        x_in => recovered_puf,
        random_out => key
    );
    
    message <= key XOR ciphertext;
    
END Behavioral;