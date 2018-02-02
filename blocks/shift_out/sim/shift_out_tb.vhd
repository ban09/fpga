library ieee;
use ieee.std_logic_1164.all;

entity shift_out_tb is

end entity shift_out_tb;

architecture test of shift_out_tb is

    constant INPUT_WIDTH  : natural := 32;
    constant OUTPUT_WIDTH : natural := 1;

    signal clk      : std_logic                                := '0';
    signal rst      : std_logic                                := '0';
    signal load     : std_logic                                := '0';
    signal shift_en : std_logic                                := '0';
    signal din      : std_logic_vector(INPUT_WIDTH-1 downto 0) := (others => '0');
    signal dout     : std_logic_vector(OUTPUT_WIDTH-1 downto 0);

begin  -- architecture test

    clk <= not clk after 1 ns;

    process (clk, rst) is
    begin  -- process
        if rst = '0' then                   -- asynchronous reset (active low)
            shift_en <= '0';
        elsif clk'event and clk = '1' then  -- rising clock edge
            shift_en <= not shift_en;
        end if;
    end process;

    shift_out_1 : entity work.shift_out
        generic map (
            INPUT_WIDTH  => INPUT_WIDTH,
            OUTPUT_WIDTH => OUTPUT_WIDTH)
        port map (
            clk      => clk,
            rst      => rst,
            load     => load,
            shift_en => shift_en,
            din      => din,
            dout     => dout);

    process is
    begin  -- process
        rst  <= '0';
        wait until clk = '1';
        wait until clk = '1';
        rst  <= '1';
        wait until clk = '1';
        din  <= x"AAAA_AAAA";
        load <= '1';
        wait until clk = '1';
        load <= '0';
        wait for 80 ns;
        assert false report "end of test" severity note;
        wait;
    end process;

end architecture test;
