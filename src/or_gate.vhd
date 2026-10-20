library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end or_gate;

architecture OrGate of or_gate is

    signal nand1_output : STD_LOGIC;
    signal nand2_output : STD_LOGIC;
    signal nand3_output : STD_LOGIC;


    component nand_gate
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
            B => A,
            Y => nand1_output
        );

    NAND2 : nand_gate
        port map (
            A => B,
            B => B,
            Y => nand2_output
        );

    NAND3 : nand_gate
        port map (
            A => nand1_output,
            B => nand2_output,
            Y => nand3_output
        );

    Y <= nand3_output;

end OrGate;