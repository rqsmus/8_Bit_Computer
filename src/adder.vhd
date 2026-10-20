library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_gate is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        C_in : in STD_LOGIC;
        SUM : out STD_LOGIC;
        C_out: OUT STD_LOGIC
    );
end adder_gate;

architecture ADDER of adder_gate is

    signal and1_output : STD_LOGIC;
    signal and2_output : STD_LOGIC;
    signal or_output : STD_LOGIC;
    signal xor1_output : STD_LOGIC;
    signal xor2_output : STD_LOGIC;

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

    component xor_gate
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
            Y => and1_output
        );
    
    AND2 : and_gate
        port map (
            A => xor1_output,
            B => C_in,
            Y => and2_output
        );

    OR1 : or_gate
        port map (
            A => and2_output,
            B => and1_output,
            Y => or_output
        );

    XOR1 : xor_gate
        port map (
            A => A,
            B => B,
            Y => xor1_output
        );

    XOR2 : xor_gate
        port map (
            A => xor1_output,
            B => C_in,
            Y => xor2_output
        );
    
    SUM <= xor2_output;
    C_out <= or_output;

end ADDER;