library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_sync is
    Port ( clk : in STD_LOGIC; hsync, vsync, video_on : out STD_LOGIC; pixel_x : out integer range 0 to 799; pixel_y : out integer range 0 to 524 );
end vga_sync;

architecture Behavioral of vga_sync is
    signal h_cnt : integer range 0 to 799 := 0;
    signal v_cnt : integer range 0 to 524 := 0;
begin
    process(clk) begin
        if rising_edge(clk) then
            if h_cnt = 799 then h_cnt <= 0; if v_cnt = 524 then v_cnt <= 0; else v_cnt <= v_cnt + 1; end if;
            else h_cnt <= h_cnt + 1; end if;
        end if;
    end process;
    hsync <= '0' when (h_cnt >= 656 and h_cnt <= 751) else '1';
    vsync <= '0' when (v_cnt >= 490 and v_cnt <= 491) else '1';
    video_on <= '1' when (h_cnt < 640 and v_cnt < 480) else '0';
    pixel_x <= h_cnt; pixel_y <= v_cnt;
end Behavioral;
