library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end xor_gate;

architecture XorGate of xor_gate is

    signal nand_output : STD_LOGIC;
    signal or_output : STD_LOGIC;
    signal xor_output : STD_LOGIC;

    component nand_gate
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

    component and_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    NAND1 : nand_gate
        port map (
            A => A,
            B => B,
            Y => nand_output
        );

    OR1 : or_gate
        port map (
            A => A,
            B => B,
            Y => or_output
        );

    AND1 : and_gate
        port map (
            A => nand_output,
            B => or_output,
            Y => xor_output
        );

    Y <= xor_output;

end XorGate;