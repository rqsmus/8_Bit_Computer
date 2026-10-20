library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    generic (
        address_length : natural :=8;
        data_length : natural :=8
    );

    Port (
        address : in STD_LOGIC_VECTOR((address_length-1) downto 0);
        data : out STD_LOGIC_VECTOR((data_length-1) downto 0)
    );
end rom;


architecture ROM of rom is
    type rom_type is array (0 to (2**(address_length) -1)) of STD_LOGIC_VECTOR((data_length - 1) downto 0);

    constant mem : rom_type :=
    (    
        0  => "00000000", -- LOAD A
        1  => "00010000", -- address 0x10 = 16
    
        2  => "00000001", -- LOAD B
        3  => "00010001", -- address 0x11 = 17
    
        4  => "00100000", -- ADD
        5  => "11010000", -- OUT A
    
        6 => "11110000", -- HALT
    
        others => "00000000"
    );

begin

    data <= mem(to_integer(unsigned(address)));

end architecture ROM;