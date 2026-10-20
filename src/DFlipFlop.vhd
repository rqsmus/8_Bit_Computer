library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_flip_flop is
    Port (
        DATA : in STD_LOGIC;
        CLOCK : in STD_LOGIC;
        Y: OUT STD_LOGIC
    );
end D_flip_flop;

architecture DFLIPFLOP of D_flip_flop is

    signal dlatch1_output : STD_LOGIC;
    signal dlatch2_output : STD_LOGIC;

    signal not_clock    : STD_LOGIC;

    component D_latch
        Port (
            DATA : in STD_LOGIC;
            STORE : in STD_LOGIC;
            Q : out STD_LOGIC
        );
    end component;

begin

    not_clock <= not CLOCK;

    DLATCH1 : D_latch
        port map (
            DATA => DATA,
            STORE => not_clock,
            Q => dlatch1_output
        );
    
    DLATCH2 : D_latch
        port map (
            DATA => dlatch1_output,
            STORE => CLOCK,
            Q => dlatch2_output
        );
    
    Y <= dlatch2_output;

end DFLIPFLOP;