library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_register is
    Port (
        DATA : in STD_LOGIC_VECTOR(7 downto 0);
        STORE : in STD_LOGIC;
        CLOCK : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end bit8_register;

architecture EIGHT_REGISTER of bit8_register is

    signal bit1_register0_output : STD_LOGIC;
    signal bit1_register1_output : STD_LOGIC;
    signal bit1_register2_output : STD_LOGIC;
    signal bit1_register3_output : STD_LOGIC;
    signal bit1_register4_output : STD_LOGIC;
    signal bit1_register5_output : STD_LOGIC;
    signal bit1_register6_output : STD_LOGIC;
    signal bit1_register7_output : STD_LOGIC;

    component bit1_register
        Port (
            DATA : in STD_LOGIC;
            STORE : in STD_LOGIC;
            CLOCK : in STD_LOGIC;
            Y: OUT STD_LOGIC
        );
    end component;

begin

    REGISTER1_0 : bit1_register
        port map (
            DATA => DATA(0),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register0_output
        );

    REGISTER1_1 : bit1_register
        port map (
            DATA => DATA(1),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register1_output
        );

    REGISTER1_2 : bit1_register
        port map (
            DATA => DATA(2),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register2_output
        );
    
    REGISTER1_3 : bit1_register
        port map (
            DATA => DATA(3),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register3_output
        );

    REGISTER1_4 : bit1_register
        port map (
            DATA => DATA(4),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register4_output
        );

    REGISTER1_5 : bit1_register
        port map (
            DATA => DATA(5),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register5_output
        );

    REGISTER1_6 : bit1_register
        port map (
            DATA => DATA(6),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register6_output
        );

    REGISTER1_7 : bit1_register
        port map (
            DATA => DATA(7),
            STORE => STORE,
            CLOCK => CLOCK,
            Y => bit1_register7_output
        );

    Y(0) <= bit1_register0_output;
    Y(1) <= bit1_register1_output;
    Y(2) <= bit1_register2_output;
    Y(3) <= bit1_register3_output;
    Y(4) <= bit1_register4_output;
    Y(5) <= bit1_register5_output;
    Y(6) <= bit1_register6_output;
    Y(7) <= bit1_register7_output;


end EIGHT_REGISTER;