library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eight_bit_pc is
    Port (
        CLOCK   : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        IN_DATA : in  STD_LOGIC_VECTOR(7 downto 0);
        OUT_DATA : out STD_LOGIC_VECTOR(7 downto 0)--;

        -- Debug outputs, for building and testing the CPU
        --DEBUG_BUS : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_PC  : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_IR  : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_A   : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_B   : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_MAR : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_MDR : out STD_LOGIC_VECTOR(7 downto 0);
        --DEBUG_FLAGS : out STD_LOGIC_VECTOR(2 downto 0);
        --DEBUG_HALT  : out STD_LOGIC
    );
end eight_bit_pc;

architecture STRUCTURAL of eight_bit_pc is
    signal bus_data : STD_LOGIC_VECTOR(7 downto 0);

    signal pc_data  : STD_LOGIC_VECTOR(7 downto 0);
    signal rom_data : STD_LOGIC_VECTOR(7 downto 0);
    signal ir_data  : STD_LOGIC_VECTOR(7 downto 0);
    signal a_data   : STD_LOGIC_VECTOR(7 downto 0);
    signal b_data   : STD_LOGIC_VECTOR(7 downto 0);
    signal mar_data : STD_LOGIC_VECTOR(7 downto 0);
    signal mdr_data : STD_LOGIC_VECTOR(7 downto 0);
    signal out_data1 : STD_LOGIC_VECTOR(7 downto 0);

    signal alu_result   : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_carry   : STD_LOGIC;
    signal alu_negative : STD_LOGIC;
    signal alu_zero    : STD_LOGIC;
    signal alu_op      : STD_LOGIC_VECTOR(2 downto 0);

    signal ram_data : STD_LOGIC_VECTOR(7 downto 0);

    signal flags : STD_LOGIC_VECTOR(2 downto 0) := "000";

    signal pc_out      : STD_LOGIC;
    signal a_out       : STD_LOGIC;
    signal b_out       : STD_LOGIC;
    signal mdr_out     : STD_LOGIC;
    signal alu_out     : STD_LOGIC;
    signal rom_out     : STD_LOGIC;
    signal in_out      : STD_LOGIC;

    signal pc_load     : STD_LOGIC;
    signal pc_store    : STD_LOGIC;
    signal mar_store   : STD_LOGIC;
    signal mdr_store   : STD_LOGIC;
    signal ir_store    : STD_LOGIC;
    signal a_store     : STD_LOGIC;
    signal b_store     : STD_LOGIC;
    signal out_store   : STD_LOGIC;
    signal flags_store : STD_LOGIC;

    signal ram_read  : STD_LOGIC;
    signal ram_write : STD_LOGIC;
    signal halt      : STD_LOGIC;
    
    signal pc_store_or_reset : STD_LOGIC;
begin
    ----------------------------------------------------------------
    -- CONTROL UNIT
    ----------------------------------------------------------------
    CU1 : entity work.control_unit
        port map (
            CLOCK       => CLOCK,
            RESET       => RESET,
            IR          => ir_data,
            ZERO        => flags(2),

            PC_OUT      => pc_out,
            A_OUT       => a_out,
            B_OUT       => b_out,
            MDR_OUT     => mdr_out,
            ALU_OUT     => alu_out,
            ROM_OUT     => rom_out,
            IN_OUT      => in_out,

            PC_LOAD     => pc_load,
            PC_STORE    => pc_store,
            MAR_STORE   => mar_store,
            MDR_STORE   => mdr_store,
            IR_STORE    => ir_store,
            A_STORE     => a_store,
            B_STORE     => b_store,
            OUT_STORE   => out_store,
            FLAGS_STORE => flags_store,

            RAM_READ    => ram_read,
            RAM_WRITE   => ram_write,

            ALU_OP      => alu_op,
            HALT        => halt
        );

    ----------------------------------------------------------------
    -- PROGRAM COUNTER
    ----------------------------------------------------------------
    
    pc_store_or_reset <= pc_store or RESET;
    
    PC1 : entity work.PC
        port map (
            load_address => bus_data,
            load         => pc_load,
            reset        => RESET,
            store        => pc_store_or_reset,
            clock        => CLOCK,
            Y            => pc_data
        );

    ----------------------------------------------------------------
    -- PROGRAM ROM
    ----------------------------------------------------------------
    ROM1 : entity work.rom
        port map (
            address => pc_data,
            data    => rom_data
        );

    ----------------------------------------------------------------
    -- INSTRUCTION REGISTER
    ----------------------------------------------------------------
    IR1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => ir_store,
            CLOCK => CLOCK,
            Y     => ir_data
        );

    ----------------------------------------------------------------
    -- MAR / ADDRESS REGISTER
    ----------------------------------------------------------------
    MAR1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => mar_store,
            CLOCK => CLOCK,
            Y     => mar_data
        );

    ----------------------------------------------------------------
    -- MEMORY DATA REGISTER
    ----------------------------------------------------------------
    MDR1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => mdr_store,
            CLOCK => CLOCK,
            Y     => mdr_data
        );

    ----------------------------------------------------------------
    -- A REGISTER
    ----------------------------------------------------------------
    A1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => a_store,
            CLOCK => CLOCK,
            Y     => a_data
        );

    ----------------------------------------------------------------
    -- B REGISTER
    ----------------------------------------------------------------
    B1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => b_store,
            CLOCK => CLOCK,
            Y     => b_data
        );

    ----------------------------------------------------------------
    -- OUTPUT REGISTER
    ----------------------------------------------------------------
    OUT1 : entity work.bit8_register_inferred
        port map (
            DATA  => bus_data,
            STORE => out_store,
            CLOCK => CLOCK,
            Y     => out_data1
        );

    ----------------------------------------------------------------
    -- ALU
    ----------------------------------------------------------------
    ALU1 : entity work.alu
        port map (
            A        => a_data,
            B        => b_data,
            ALU_OP   => alu_op,
            RESULT   => alu_result,
            CARRY    => alu_carry,
            NEGATIVE => alu_negative,
            ZERO     => alu_zero
        );

    ----------------------------------------------------------------
    -- DATA RAM
    ----------------------------------------------------------------
    RAM1 : entity work.ram
        port map (
            CLOCK    => CLOCK,
            READ     => ram_read,
            WRITE    => ram_write,
            ADDRESS  => mar_data,
            DATA_IN  => bus_data,
            DATA_OUT => ram_data
        );

    ----------------------------------------------------------------
    -- FLAGS REGISTER
    -- bit 2 = ZERO
    -- bit 1 = NEGATIVE
    -- bit 0 = CARRY
    ----------------------------------------------------------------
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            flags <= "000";
        elsif rising_edge(CLOCK) then
            if flags_store = '1' then
                flags(2) <= alu_zero;
                flags(1) <= alu_negative;
                flags(0) <= alu_carry;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- SHARED 8-BIT BUS
    ----------------------------------------------------------------
    bus_data <= pc_data    when pc_out  = '1' else (others => 'Z');
    bus_data <= a_data     when a_out   = '1' else (others => 'Z');
    bus_data <= b_data     when b_out   = '1' else (others => 'Z');
    bus_data <= mdr_data   when mdr_out = '1' else (others => 'Z');
    bus_data <= alu_result when alu_out = '1' else (others => 'Z');
    bus_data <= rom_data   when rom_out = '1' else (others => 'Z');
    bus_data <= IN_DATA    when in_out  = '1' else (others => 'Z');
    bus_data <= ram_data when ram_read = '1' else (others => 'Z');

    ----------------------------------------------------------------
    -- DEBUG / OUTPUT CONNECTIONS
    ----------------------------------------------------------------
    OUT_DATA    <= out_data1;
    --DEBUG_BUS   <= bus_data;
    --DEBUG_PC    <= pc_data;
    --DEBUG_IR    <= ir_data;
    --DEBUG_A     <= a_data;
    --DEBUG_B     <= b_data;
    --DEBUG_MAR   <= mar_data;
    --DEBUG_MDR   <= mdr_data;
    --DEBUG_FLAGS <= flags;
    --DEBUG_HALT  <= halt;
end architecture STRUCTURAL;
