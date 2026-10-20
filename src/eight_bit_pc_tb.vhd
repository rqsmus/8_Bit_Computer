library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eight_bit_pc_tb is
end eight_bit_pc_tb;

architecture TB of eight_bit_pc_tb is
    signal CLOCK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal IN_DATA : STD_LOGIC_VECTOR(7 downto 0) := "10101010";

    signal OUT_DATA : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_BUS : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_PC : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_IR : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_A : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_B : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_MAR : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_MDR : STD_LOGIC_VECTOR(7 downto 0);
    --signal DEBUG_FLAGS : STD_LOGIC_VECTOR(2 downto 0);
    --signal DEBUG_HALT : STD_LOGIC;
begin
    CLOCK <= not CLOCK after 5 ns;

    DUT : entity work.eight_bit_pc
        port map (
            CLOCK      => CLOCK,
            RESET      => RESET,
            IN_DATA    => IN_DATA,
            OUT_DATA   => OUT_DATA--,
            --DEBUG_BUS  => DEBUG_BUS,
            --DEBUG_PC   => DEBUG_PC,
            --DEBUG_IR   => DEBUG_IR,
            --DEBUG_A    => DEBUG_A,
            --DEBUG_B    => DEBUG_B,
            --DEBUG_MAR  => DEBUG_MAR,
            --DEBUG_MDR  => DEBUG_MDR,
            --DEBUG_FLAGS => DEBUG_FLAGS,
            --DEBUG_HALT => DEBUG_HALT
        );

    process
    begin
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        -- Let the CPU execute the ROM contents.
        wait for 1000 ns;

        wait;
    end process;
end architecture TB;
