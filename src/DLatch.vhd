library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_latch is
    Port (
        DATA : in STD_LOGIC;
        STORE : in STD_LOGIC;
        Q: OUT STD_LOGIC
    );
end D_latch;

architecture DLATCH of D_latch is

    signal set_signal : STD_LOGIC;
    signal reset_signal : STD_LOGIC;
    signal nor1_output : STD_LOGIC;
    signal nor2_output : STD_LOGIC;

    signal not_data    : STD_LOGIC;

    component and_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component nor_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    AND1 : and_gate
        port map (
            A => DATA,
            B => STORE,
            Y => set_signal
        );

    not_data <= not DATA;
    
    AND2 : and_gate
        port map (
            A => not_data,
            B => STORE,
            Y => reset_signal
        );

    NOR1 : nor_gate
        port map (
            A => set_signal,
            B => nor2_output,
            Y => nor1_output
        );

    NOR2 : nor_gate
        port map (
            A => nor1_output,
            B => reset_signal,
            Y => nor2_output
        );
    
    Q <= nor2_output;

end DLATCH;