library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end and_gate;

architecture andGate of and_gate is

begin

    Y <= A and B;

end architecture andGate;