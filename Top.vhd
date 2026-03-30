library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( 
        clk       : in  STD_LOGIC;  
        btn_jump  : in  STD_LOGIC;  
        btn_start : in  STD_LOGIC;  
        hsync     : out STD_LOGIC;
        vsync     : out STD_LOGIC;
        rgb       : out STD_LOGIC_VECTOR (2 downto 0)
    );
end top;

architecture Structural of top is
    signal c25, vid, vs_s : std_logic;
    signal px, py, dy, sc : integer;
    signal cx1, cx2 : integer range -500 to 1200;
    signal t1, t2 : integer range 0 to 2;
    signal st : integer range 0 to 2 := 0;
    signal col_s : std_logic := '0';
begin
    vsync <= vs_s;

    process(vs_s)
        variable h1, h2 : integer;
        variable c1, c2 : boolean;
    begin
        if falling_edge(vs_s) then
            if t1 = 2 then h1 := 340; else h1 := 360; end if;
            if t2 = 2 then h2 := 340; else h2 := 360; end if;
            c1 := (cx1 < 148 and cx1 + 30 > 100) and (dy + 45 > h1);
            c2 := (cx2 < 148 and cx2 + 30 > 100) and (dy + 45 > h2);
            if c1 or c2 then col_s <= '1'; else col_s <= '0'; end if;

            case st is
                when 0 => if btn_start = '0' then st <= 1; end if;
                when 1 => if col_s = '1' then st <= 2; end if;
                when 2 => if btn_start = '0' then st <= 0; end if;
            end case;
        end if;
    end process;

    U0: entity work.dcm_clock port map(i_Clk => clk, o_Clk => c25);
    U1: entity work.vga_sync port map(clk => c25, hsync => hsync, vsync => vs_s, video_on => vid, pixel_x => px, pixel_y => py);
    U2: entity work.game_graphics port map(vid, px, py, dy, cx1, cx2, t1, t2, sc, st, rgb);
    U3: entity work.dino_motion port map(clk => c25, vsync => vs_s, btn_jump => (not btn_jump), dino_y => dy);
    
    -- ???????????????? Port Map U4 ???????????? Entity
    U4: entity work.cactus_motion port map(
        vsync      => vs_s, 
        game_state => st, 
        cactus1_x  => cx1, 
        cactus2_x  => cx2, 
        type1      => t1, 
        type2      => t2, 
        score_val  => sc
    );

end Structural;
