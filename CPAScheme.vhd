LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cpa_scheme IS
    PORT (
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        message : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_message : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END cpa_scheme;

ARCHITECTURE Behavioral OF cpa_scheme IS
    SIGNAL out_enc_cipher : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL out_enc_helper : STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    COMPONENT enc_scheme IS
        PORT(
            reset : IN STD_LOGIC;
            clock : IN STD_LOGIC;
            challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            message : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            ciphertext : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            helper_data : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT dec_scheme IS
        PORT(
            reset : IN STD_LOGIC;
            clock : IN STD_LOGIC;
            challenge : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            ciphertext : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            helper_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            message : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    
BEGIN
    
    enc_scheme_0 :  enc_scheme
    PORT MAP(
        reset => reset,
        clock => clock,
        challenge => challenge,
        message => message,
        ciphertext => out_enc_cipher,
        helper_data => out_enc_helper
    );
    
    dec_scheme_0 : dec_scheme
    PORT MAP(
        reset => reset,
        clock => clock,
        challenge => challenge,
        ciphertext => out_enc_cipher,
        helper_data => out_enc_helper,
        message => out_message
    );
    
END Behavioral;
    
    
    