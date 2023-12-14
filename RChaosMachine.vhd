library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity RChaosMachine is
    Generic (
        R : real := 3.7; --Chaos parameter
        ITER    : integer := 100 --Number of iterations
    );
    Port (
        clk    : in STD_LOGIC;
        rst    : in STD_LOGIC;
        x_in   : in STD_LOGIC_VECTOR(3 downto 0);
        x_out  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end RChaosMachine;

architecture Behavioral of RChaosMachine is
    signal x : real;
    signal iter_count  : integer := 0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            x <= REAL(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(x_in)) / 2**4); --Initialize from external input
            iter_count <= 0;
        elsif rising_edge(clk) then
            if iter_count < ITER then
                x <= R * x * (1.0 - x);
                iter_count <= iter_count + 1;
            end if;
        end if;
    end process;

    x_out <= std_ulogic_vector(Std_logic(IEEE.NUMERIC_STD.UNSIGNED(x) * 2**4), 4);

end Behavioral;
