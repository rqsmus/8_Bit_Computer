library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end nand_gate;

architecture NandGate of nand_gate is

    signal and_output : STD_LOGIC;

    component and_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

begin

    AND1 : and_gate
        port map (
            A => A,
            B => B,
            Y => and_output
        );

    Y <= not and_output;

end NandGate;