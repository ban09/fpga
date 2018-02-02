library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity shift_out is
    generic (
        INPUT_WIDTH  : natural := 32;
        OUTPUT_WIDTH : natural := 2
        );

    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        load     : in  std_logic;
        shift_en : in  std_logic;
        din      : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        dout     : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
        );
end shift_out;

architecture rtl of shift_out is

    signal data_in  : std_logic_vector(INPUT_WIDTH-1 downto 0);
    signal data_out : std_logic_vector(OUTPUT_WIDTH-1 downto 0);

begin

    process (clk, rst) is
    begin  -- process

        if rst = '0' then
            data_in <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                data_in <= din;
            else
                if shift_en = '1' then
                    data_in(INPUT_WIDTH-1 - OUTPUT_WIDTH downto 0)             <= data_in(INPUT_WIDTH-1 downto OUTPUT_WIDTH);
                    data_in(INPUT_WIDTH-1 downto INPUT_WIDTH-1 - OUTPUT_WIDTH) <= (others => '0');
                else
                    data_in <= data_in;
                end if;

            end if;
        end if;

    end process;
    dout(OUTPUT_WIDTH-1 downto 0) <= data_in(OUTPUT_WIDTH-1 downto 0);

end rtl;
