library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port (
        A        : in  STD_LOGIC_VECTOR(7 downto 0);
        B        : in  STD_LOGIC_VECTOR(7 downto 0);
        ALU_OP   : in  STD_LOGIC_VECTOR(2 downto 0);
        RESULT   : out STD_LOGIC_VECTOR(7 downto 0);
        CARRY    : out STD_LOGIC;
        NEGATIVE : out STD_LOGIC;
        ZERO     : out STD_LOGIC
    );
end alu;

architecture ALU of alu is
    signal adder_b      : STD_LOGIC_VECTOR(7 downto 0);
    signal add_result   : STD_LOGIC_VECTOR(7 downto 0);
    signal add_carry    : STD_LOGIC;
    signal result_int   : STD_LOGIC_VECTOR(7 downto 0);
    signal carry_int    : STD_LOGIC;

    component bit8_adder
        Port (
            A  : in  STD_LOGIC_VECTOR(7 downto 0);
            B  : in  STD_LOGIC_VECTOR(7 downto 0);
            CI : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR(7 downto 0);
            CO : out STD_LOGIC
        );
    end component;
begin

    adder_b(0) <= B(0) xor ALU_OP(0);   -- if we do SUB we can make B negative and use the adder (CI => ALU_OP(0) for the +1 to make b the currect value)
    adder_b(1) <= B(1) xor ALU_OP(0);
    adder_b(2) <= B(2) xor ALU_OP(0);
    adder_b(3) <= B(3) xor ALU_OP(0);
    adder_b(4) <= B(4) xor ALU_OP(0);
    adder_b(5) <= B(5) xor ALU_OP(0);
    adder_b(6) <= B(6) xor ALU_OP(0);
    adder_b(7) <= B(7) xor ALU_OP(0);

    ADDER1 : bit8_adder
        port map (
            A  => A,
            B  => adder_b,
            CI => ALU_OP(0),
            Y  => add_result,
            CO => add_carry
        );

    process(A, B, ALU_OP, add_result, add_carry)
    begin
        result_int <= (others => '0');
        carry_int  <= '0';

        case ALU_OP is
            when "000" =>                    -- ADD
                result_int <= add_result;
                carry_int  <= add_carry;

            when "001" =>                    -- SUB
                result_int <= add_result;
                carry_int  <= add_carry;

            when "010" =>                    -- AND
                result_int <= A and B;

            when "011" =>                    -- OR
                result_int <= A or B;

            when "100" =>                    -- XOR
                result_int <= A xor B;

            when "101" =>                    -- NOT A
                result_int <= not A;

            when "110" =>                    -- SHL
                result_int <= A(6 downto 0) & '0';
                carry_int  <= A(7);

            when "111" =>                    -- SHR
                result_int <= '0' & A(7 downto 1);
                carry_int  <= A(0);

            when others =>
                null;
        end case;
    end process;

    RESULT   <= result_int;
    CARRY    <= carry_int;
    NEGATIVE <= result_int(7);

    ZERO <= '1' when result_int = "00000000" else '0';
end architecture ALU;
