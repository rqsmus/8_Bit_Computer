library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
    Port (
        load_address : in STD_LOGIC_VECTOR(7 downto 0);
        load : in STD_LOGIC;
        reset : in STD_LOGIC;
        store : in STD_LOGIC;
        clock : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end pc;

architecture PC of pc is

        signal mux1_output : STD_LOGIC_VECTOR(7 downto 0);
        signal mux2_output : STD_LOGIC_VECTOR(7 downto 0);
        signal adder_output : STD_LOGIC_VECTOR(7 downto 0);
        signal carry_out : STD_LOGIC;
        signal register8_output : STD_LOGIC_VECTOR(7 downto 0);

    component MUX
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            S : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component bit8_register_inferred
        Port (
            DATA : in STD_LOGIC_VECTOR(7 downto 0);
            STORE : in STD_LOGIC;
            CLOCK : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component bit8_adder
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            CI : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(7 downto 0);
            CO: OUT STD_LOGIC
        );
    end component;

begin

    ADDER1 : bit8_adder
        port map (
            A => register8_output,
            B => "00000001",
            CI => '0',
            Y => adder_output,
            CO => carry_out
        );

    MUX1 : MUX
        port map (
            A => adder_output,
            B => load_address,
            S => load,
            Y => mux1_output
        );

    MUX2 : MUX
        port map (
            A => mux1_output,
            B => "00000000",
            S => reset,
            Y => mux2_output
        );

    REGISTER8 : bit8_register_inferred
        port map (
            DATA => mux2_output,
            STORE => store,
            CLOCK => clock,
            Y => register8_output
        );

    Y <= register8_output;

end architecture PC;