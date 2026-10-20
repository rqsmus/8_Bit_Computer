library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit8_register_inferred is
    Port (
        DATA  : in  STD_LOGIC_VECTOR(7 downto 0);
        STORE : in  STD_LOGIC;
        CLOCK : in  STD_LOGIC;
        Y     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end bit8_register_inferred;

architecture RTL of bit8_register_inferred is

    signal register_data : STD_LOGIC_VECTOR(7 downto 0);

begin

    process(CLOCK)
    begin
        if rising_edge(CLOCK) then
            if STORE = '1' then
                register_data <= DATA;
            end if;
        end if;
    end process;

    Y <= register_data;

end RTL;