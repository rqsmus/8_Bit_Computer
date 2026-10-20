library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);
        B : in STD_LOGIC_VECTOR(7 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux;


architecture MUX of mux is

    signal and0_output : STD_LOGIC;
    signal and1_output : STD_LOGIC;
    signal and2_output : STD_LOGIC;
    signal and3_output : STD_LOGIC;
    signal and4_output : STD_LOGIC;
    signal and5_output : STD_LOGIC;
    signal and6_output : STD_LOGIC;
    signal and7_output : STD_LOGIC;

    signal band0_output : STD_LOGIC;
    signal band1_output : STD_LOGIC;
    signal band2_output : STD_LOGIC;
    signal band3_output : STD_LOGIC;
    signal band4_output : STD_LOGIC;
    signal band5_output : STD_LOGIC;
    signal band6_output : STD_LOGIC;
    signal band7_output : STD_LOGIC;

    signal or0_output : STD_LOGIC;
    signal or1_output : STD_LOGIC;
    signal or2_output : STD_LOGIC;
    signal or3_output : STD_LOGIC;
    signal or4_output : STD_LOGIC;
    signal or5_output : STD_LOGIC;
    signal or6_output : STD_LOGIC;
    signal or7_output : STD_LOGIC;

    signal not_select : STD_LOGIC;

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

    not_select <= not S;

    -- A input and

    AND7 : and_gate
        port map (
            A => A(7),
            B => not_select,
            Y => and7_output
        );

    AND6 : and_gate
        port map (
            A => A(6),
            B => not_select,
            Y => and6_output
        );

    AND5 : and_gate
        port map (
            A => A(5),
            B => not_select,
            Y => and5_output
        );

    AND4 : and_gate
        port map (
            A => A(4),
            B => not_select,
            Y => and4_output
        );

    AND3 : and_gate
        port map (
            A => A(3),
            B => not_select,
            Y => and3_output
        );

    AND2 : and_gate
        port map (
            A => A(2),
            B => not_select,
            Y => and2_output
        );

    AND1 : and_gate
        port map (
            A => A(1),
            B => not_select,
            Y => and1_output
        );

    AND0 : and_gate
        port map (
            A => A(0),
            B => not_select,
            Y => and0_output
        );

    -- B input and

    BAND7 : and_gate
        port map (
            A => B(7),
            B => S,
            Y => band7_output
        );

    BAND6 : and_gate
        port map (
            A => B(6),
            B => S,
            Y => band6_output
        );

    BAND5 : and_gate
        port map (
            A => B(5),
            B => S,
            Y => band5_output
        );

    BAND4 : and_gate
        port map (
            A => B(4),
            B => S,
            Y => band4_output
        );

    BAND3 : and_gate
        port map (
            A => B(3),
            B => S,
            Y => band3_output
        );

    BAND2 : and_gate
        port map (
            A => B(2),
            B => S,
            Y => band2_output
        );

    BAND1 : and_gate
        port map (
            A => B(1),
            B => S,
            Y => band1_output
        );

    BAND0 : and_gate
        port map (
            A => B(0),
            B => S,
            Y => band0_output
        );
    
    -- OR output

    OR7 : or_gate
        port map (
            A => and7_output,
            B => band7_output,
            Y => or7_output
        );

    OR6 : or_gate
        port map (
            A => and6_output,
            B => band6_output,
            Y => or6_output
        );

    OR5 : or_gate
        port map (
            A => and5_output,
            B => band5_output,
            Y => or5_output
        );

    OR4 : or_gate
        port map (
            A => and4_output,
            B => band4_output,
            Y => or4_output
        );

    OR3 : or_gate
        port map (
            A => and3_output,
            B => band3_output,
            Y => or3_output
        );

    OR2 : or_gate
        port map (
            A => and2_output,
            B => band2_output,
            Y => or2_output
        );
    
    OR1 : or_gate
        port map (
            A => and1_output,
            B => band1_output,
            Y => or1_output
        );

    OR0 : or_gate
        port map (
            A => and0_output,
            B => band0_output,
            Y => or0_output
        );

    Y(7) <= or7_output;
    Y(6) <= or6_output;
    Y(5) <= or5_output;
    Y(4) <= or4_output;
    Y(3) <= or3_output;
    Y(2) <= or2_output;
    Y(1) <= or1_output;
    Y(0) <= or0_output;

end MUX;