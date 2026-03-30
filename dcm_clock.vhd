library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.all;

entity dcm_clock is
    port ( i_Clk : in std_logic; o_Clk : out std_logic );
end dcm_clock;

architecture Behavioral of dcm_clock is
    signal clkfx_raw : std_logic;
    signal gnd_bit   : std_logic := '0';
begin
    U_DCM : DCM_CLKGEN
    generic map ( CLKIN_PERIOD => 50.0, CLKFX_MULTIPLY => 5, CLKFX_DIVIDE => 4 )
    port map ( CLKIN => i_Clk, CLKFX => clkfx_raw, FREEZEDCM => gnd_bit, PROGCLK => gnd_bit, PROGDATA => gnd_bit, PROGEN => gnd_bit, RST => gnd_bit );
    U_BUFG : BUFG port map ( I => clkfx_raw, O => o_Clk );
end Behavioral;
