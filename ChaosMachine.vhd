-- Assumendo che abbia implementato bene (sicuramente no), l'equazione che descrive il sistema è una relazione di ricorrenza.
-- Sia x_i il risultato dell'i-esima applicazione dell'equazione su x (una per ogni ciclo di clock). L'equazione è:

-- x_(i+1) = (x_i XOR a) AND (x_i AND b) AND (x_i OR c)

-- dove XOR/AND/OR sono operazioni bit-a-bit e a,b,c sono le tre costanti definite nel corpo di "architecture Behavioral of ChaosMachine"

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


-- CLK è il segnale di clock
-- RESET è usato per impostare il sistema alla condizione iniziale 0000
-- X_IN è l'input
-- RANDOM_OUT è l'output in seguito all'esecuzione dell'equazione che descrive il sistema caotico

ENTITY ChaosMachine IS
    PORT ( clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        x_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        random_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END ChaosMachine;

ARCHITECTURE Behavioral OF ChaosMachine IS
    SIGNAL x : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    PROCESS(clk)
        -- Parametri del sistema caotico (possiamo fare vari tentativi e cambiarli)
    CONSTANT a : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1011";
    CONSTANT b : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1101";
    CONSTANT c : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
    VARIABLE counter : NATURAL RANGE 0 TO 4 := 0;
    
    BEGIN
            -- Assumendo che il segnale di CLOCK sia asserito, viene sviluppata l'equazione che descrive il sistema caotico
            -- (others => '0') when x = "1111" evita che ci sia overflow se x raggiunge il massimo valore
        IF rising_edge(clk) THEN
            CASE counter IS
                WHEN 0 =>
                    IF reset = '1' OR x = "UUUU" THEN
                     -- Condizione iniziale del sistema imposta dopo l'asserzione del segnale di RESET
                        x <= x_in;
                    END IF;
                    counter := counter+1;
                WHEN 1 =>
                    IF x = "0000" THEN
                        x <= "1111";
                    ELSE
                        x <= (x XOR a) AND (x XOR b) AND (x XOR c);
                    END IF;

                    counter := counter +1;
                    
                WHEN OTHERS =>
                    counter := 0;
            END CASE;
            random_out <= x;
        END IF;
    END PROCESS;
END Behavioral;
