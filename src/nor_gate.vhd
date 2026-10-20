library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nor_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end nor_gate;

architecture NorGate of nor_gate is

    signal or_output : STD_LOGIC;

    component or_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    OR1 : or_gate
        port map (
            A => A,
            B => B,
            Y => or_output
        );

    Y <= not or_output;

end NorGate;