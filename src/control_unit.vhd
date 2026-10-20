library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
        CLOCK : in STD_LOGIC;
        RESET : in STD_LOGIC;

        IR   : in STD_LOGIC_VECTOR(7 downto 0);
        ZERO : in STD_LOGIC;

        PC_OUT    : out STD_LOGIC;
        A_OUT     : out STD_LOGIC;
        B_OUT     : out STD_LOGIC;
        MDR_OUT   : out STD_LOGIC;
        ALU_OUT   : out STD_LOGIC;
        ROM_OUT   : out STD_LOGIC;
        IN_OUT    : out STD_LOGIC;

        PC_LOAD   : out STD_LOGIC;
        PC_STORE  : out STD_LOGIC;
        MAR_STORE : out STD_LOGIC;
        MDR_STORE : out STD_LOGIC;
        IR_STORE  : out STD_LOGIC;
        A_STORE   : out STD_LOGIC;
        B_STORE   : out STD_LOGIC;
        OUT_STORE : out STD_LOGIC;
        FLAGS_STORE : out STD_LOGIC;

        RAM_READ  : out STD_LOGIC;
        RAM_WRITE : out STD_LOGIC;

        ALU_OP : out STD_LOGIC_VECTOR(2 downto 0);
        HALT   : out STD_LOGIC
    );
end control_unit;

architecture CONTROL of control_unit is
    type state_type is (
        FETCH_1, FETCH_2, DECODE,
        LOAD_1, LOAD_2, LOAD_3, LOAD_4,
        STORE_1, STORE_2, STORE_3,
        ADD_1, SUB_1, AND_1, OR_1, XOR_1, NOT_1, SHL_1, SHR_1,
        JMP_1, JZ_1, JNZ_1,
        OUT_1, IN_1,
        HALT_STATE
    );

    signal state, next_state : state_type;
begin
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            state <= FETCH_1;
        elsif rising_edge(CLOCK) then
            state <= next_state;
        end if;
    end process;

    process(state, IR, ZERO)
    begin
        PC_OUT      <= '0';
        A_OUT       <= '0';
        B_OUT       <= '0';
        MDR_OUT     <= '0';
        ALU_OUT     <= '0';
        ROM_OUT     <= '0';
        IN_OUT      <= '0';

        PC_LOAD     <= '0';
        PC_STORE    <= '0';
        MAR_STORE   <= '0';
        MDR_STORE   <= '0';
        IR_STORE    <= '0';
        A_STORE     <= '0';
        B_STORE     <= '0';
        OUT_STORE   <= '0';
        FLAGS_STORE <= '0';

        RAM_READ    <= '0';
        RAM_WRITE   <= '0';

        ALU_OP      <= "000";
        HALT        <= '0';

        next_state <= FETCH_1;

        case state is

            -- fetch and decode the instruction
            when FETCH_1 =>
                ROM_OUT  <= '1';
                IR_STORE <= '1';
                next_state <= FETCH_2;

            when FETCH_2 =>
                PC_STORE <= '1';       
                next_state <= DECODE;

            when DECODE =>
                case IR(7 downto 4) is
                    when "0000" => next_state <= LOAD_1;
                    when "0001" => next_state <= STORE_1;
                    when "0010" => next_state <= ADD_1;
                    when "0011" => next_state <= SUB_1;
                    when "0100" => next_state <= AND_1;
                    when "0101" => next_state <= OR_1;
                    when "0110" => next_state <= XOR_1;
                    when "0111" => next_state <= NOT_1;
                    when "1000" => next_state <= SHL_1;
                    when "1001" => next_state <= SHR_1;
                    when "1010" => next_state <= JMP_1;
                    when "1011" => next_state <= JZ_1;
                    when "1100" => next_state <= JNZ_1;
                    when "1101" => next_state <= OUT_1;
                    when "1110" => next_state <= IN_1;
                    when "1111" => next_state <= HALT_STATE;
                    when others => next_state <= FETCH_1;
                end case;

            -- load instruction, 2 bytes
            when LOAD_1 =>
                ROM_OUT   <= '1';
                MAR_STORE <= '1';
                next_state <= LOAD_2;

            when LOAD_2 =>
                PC_STORE <= '1';
                next_state <= LOAD_3;

            when LOAD_3 =>
                RAM_READ  <= '1';
                MDR_STORE <= '1';
                next_state <= LOAD_4;

            when LOAD_4 =>
                MDR_OUT <= '1';
                if IR(3 downto 0) = "0000" then
                    A_STORE <= '1';
                elsif IR(3 downto 0) = "0001" then
                    B_STORE <= '1';
                end if;
                next_state <= FETCH_1;

            -- sotre instruction, 2 bytes
            when STORE_1 =>
                ROM_OUT   <= '1';
                MAR_STORE <= '1';
                next_state <= STORE_2;

            when STORE_2 =>
                PC_STORE <= '1';
                next_state <= STORE_3;

            when STORE_3 =>
                if IR(3 downto 0) = "0000" then
                    A_OUT <= '1';
                elsif IR(3 downto 0) = "0001" then
                    B_OUT <= '1';
                end if;
                RAM_WRITE <= '1';
                next_state <= FETCH_1;

            -- ALU operations, all the results go into A and update flags
            when ADD_1 =>
                ALU_OP      <= "000";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when SUB_1 =>
                ALU_OP      <= "001";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when AND_1 =>
                ALU_OP      <= "010";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when OR_1 =>
                ALU_OP      <= "011";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when XOR_1 =>
                ALU_OP      <= "100";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when NOT_1 =>
                ALU_OP      <= "101";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when SHL_1 =>
                ALU_OP      <= "110";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            when SHR_1 =>
                ALU_OP      <= "111";
                ALU_OUT     <= '1';
                A_STORE     <= '1';
                FLAGS_STORE <= '1';
                next_state <= FETCH_1;

            -- next rom is jump address
            when JMP_1 =>
                ROM_OUT  <= '1';
                PC_LOAD  <= '1';    --PC_LOAD=1 is to select the bus data instead of PC+1
                PC_STORE <= '1';
                next_state <= FETCH_1;

            when JZ_1 =>
                ROM_OUT <= '1';
                if ZERO = '1' then
                    PC_LOAD <= '1';
                else
                    PC_LOAD <= '0';
                end if;
                PC_STORE <= '1';
                next_state <= FETCH_1;

            when JNZ_1 =>
                ROM_OUT <= '1';
                if ZERO = '0' then
                    PC_LOAD <= '1';
                else
                    PC_LOAD <= '0';
                end if;
                PC_STORE <= '1';
                next_state <= FETCH_1;
            
            -- output data
            when OUT_1 =>
                if IR(3 downto 0) = "0000" then
                    A_OUT <= '1';
                elsif IR(3 downto 0) = "0001" then
                    B_OUT <= '1';
                end if;
                OUT_STORE <= '1';
                next_state <= FETCH_1;

            -- get data in (input)
            when IN_1 =>
                IN_OUT <= '1';
                if IR(3 downto 0) = "0000" then
                    A_STORE <= '1';
                elsif IR(3 downto 0) = "0001" then
                    B_STORE <= '1';
                end if;
                next_state <= FETCH_1;

            -- halte the computer
            when HALT_STATE =>
                HALT <= '1';
                next_state <= HALT_STATE;

            when others =>
                next_state <= FETCH_1;
        end case;
    end process;
end architecture CONTROL;
