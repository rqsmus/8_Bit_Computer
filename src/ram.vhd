library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
    generic (
        address_length : natural := 8;
        data_length    : natural := 8
    );
    Port (
        CLOCK      : in  STD_LOGIC;
        READ       : in  STD_LOGIC;
        WRITE      : in  STD_LOGIC;
        ADDRESS    : in  STD_LOGIC_VECTOR(address_length-1 downto 0);
        DATA_IN    : in  STD_LOGIC_VECTOR(data_length-1 downto 0);
        DATA_OUT   : out STD_LOGIC_VECTOR(data_length-1 downto 0)
    );
end ram;

architecture RAM of ram is
    type ram_type is array (0 to (2**address_length)-1)
        of STD_LOGIC_VECTOR(data_length-1 downto 0);

    signal mem : ram_type := (
        16 => "00000011", -- 0x03
        17 => "00000100", -- 0x04
        others => (others => '0')
    );
    
begin
    -- asynchronous read, when read low ram release the bus
    DATA_OUT <= mem(to_integer(unsigned(ADDRESS))) when READ = '1'
                else (others => 'Z');

    -- synchronous write
    process(CLOCK)
    begin
        if rising_edge(CLOCK) then
            if WRITE = '1' then
                mem(to_integer(unsigned(ADDRESS))) <= DATA_IN;
            end if;
        end if;
    end process;
end architecture RAM;
