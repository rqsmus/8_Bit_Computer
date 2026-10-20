library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit1_register is
    Port (
        DATA : in STD_LOGIC;
        STORE : in STD_LOGIC;
        CLOCK : in STD_LOGIC;
        Y: OUT STD_LOGIC
    );
end bit1_register;

architecture BIT1REGISTER of bit1_register is

    signal and1_output : STD_LOGIC;
    signal and2_output : STD_LOGIC;
    signal or1_output : STD_LOGIC;
    signal Dflipflop_output : STD_LOGIC;

    signal not_store    : STD_LOGIC;

    component D_flip_flop
        Port (
            DATA : in STD_LOGIC;
            CLOCK : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component and_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component or_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    not_store <= not STORE;

    AND1 : and_gate
        port map (
            A => DATA,
            B => STORE,
            Y => and1_output
        );

    AND2 : and_gate
        port map (
            A => Dflipflop_output,
            B => not_store,
            Y => and2_output
        );

    OR1 : or_gate
        port map (
            A => and1_output,
            B => and2_output,
            Y => or1_output
        );
    
    DFLIPFLOP1 : D_flip_flop
        port map (
            DATA => or1_output,
            CLOCK => CLOCK,
            Y => Dflipflop_output
        );
    
    Y <= Dflipflop_output;

end BIT1REGISTER;