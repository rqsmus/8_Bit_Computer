library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_adder is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);
        B : in STD_LOGIC_VECTOR(7 downto 0);
        CI : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0);
        CO: OUT STD_LOGIC
    );
end bit8_adder;

architecture EIGHT_ADDER of bit8_adder is

    signal adder1_output : STD_LOGIC;
    signal adder2_output : STD_LOGIC;
    signal adder3_output : STD_LOGIC;
    signal adder4_output : STD_LOGIC;
    signal adder5_output : STD_LOGIC;
    signal adder6_output : STD_LOGIC;
    signal adder7_output : STD_LOGIC;
    signal adder8_output : STD_LOGIC;

    signal adder1_carry_output : STD_LOGIC;
    signal adder2_carry_output : STD_LOGIC;
    signal adder3_carry_output : STD_LOGIC;
    signal adder4_carry_output : STD_LOGIC;
    signal adder5_carry_output : STD_LOGIC;
    signal adder6_carry_output : STD_LOGIC;
    signal adder7_carry_output : STD_LOGIC;
    signal adder8_carry_output : STD_LOGIC;

    component adder_gate
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            C_in : in STD_LOGIC;
            SUM : out STD_LOGIC;
            C_out: OUT STD_LOGIC
        );
    end component;

begin

    ADDER1 : adder_gate
        port map (
            A => A(0),
            B => B(0),
            C_in => CI,
            SUM => adder1_output,
            C_out => adder1_carry_output
        );

    ADDER2 : adder_gate
        port map (
            A => A(1),
            B => B(1),
            C_in => adder1_carry_output,
            SUM => adder2_output,
            C_out => adder2_carry_output
        );

    ADDER3 : adder_gate
        port map (
            A => A(2),
            B => B(2),
            C_in => adder2_carry_output,
            SUM => adder3_output,
            C_out => adder3_carry_output
        );

    ADDER4 : adder_gate
        port map (
            A => A(3),
            B => B(3),
            C_in => adder3_carry_output,
            SUM => adder4_output,
            C_out => adder4_carry_output
        );

    ADDER5 : adder_gate
        port map (
            A => A(4),
            B => B(4),
            C_in => adder4_carry_output,
            SUM => adder5_output,
            C_out => adder5_carry_output
        );

    ADDER6 : adder_gate
        port map (
            A => A(5),
            B => B(5),
            C_in => adder5_carry_output,
            SUM => adder6_output,
            C_out => adder6_carry_output
        );

    ADDER7 : adder_gate
        port map (
            A => A(6),
            B => B(6),
            C_in => adder6_carry_output,
            SUM => adder7_output,
            C_out => adder7_carry_output
        );

    ADDER8 : adder_gate
        port map (
            A => A(7),
            B => B(7),
            C_in => adder7_carry_output,
            SUM => adder8_output,
            C_out => adder8_carry_output
        );

    Y(0) <= adder1_output;
    Y(1) <= adder2_output;
    Y(2) <= adder3_output;
    Y(3) <= adder4_output;
    Y(4) <= adder5_output;
    Y(5) <= adder6_output;
    Y(6) <= adder7_output;
    Y(7) <= adder8_output;
    CO <= adder8_carry_output;


end EIGHT_ADDER;