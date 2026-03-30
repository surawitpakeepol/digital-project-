library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity game_graphics is
    Port (
        video_on   : in  STD_LOGIC;
        pixel_x    : in  integer range 0 to 799;
        pixel_y    : in  integer range 0 to 524;
        dino_y     : in  integer range 0 to 479;
        c1_x, c2_x : in  integer range -500 to 1200;
        t1, t2     : in  integer range 0 to 2;
        score      : in  integer range 0 to 999;
        game_state : in  integer range 0 to 2;
        rgb        : out STD_LOGIC_VECTOR (2 downto 0)
    );
end game_graphics;

architecture Behavioral of game_graphics is
    -- -------------------------------------------------------------
    -- [ Dino Sprite: Slim Version (?????) ]
    -- -------------------------------------------------------------
    type sprite_type is array (0 to 23) of std_logic_vector(0 to 23);
    constant DINO : sprite_type := (
        "000000000000001111110000", -- 0 ?????
        "000000000000001101111000", -- 1 ?? (???????? '0')
        "000000000000001111111000", -- 2
        "000000000000001111111000", -- 3
        "000000000000001111100000", -- 4 ?????
        "000000000000001111111000", -- 5 ???????
        "000000000000011111000000", -- 6 ???????????
        "000000000001111110000000", -- 7
        "000100000011111110000000", -- 8 ????????
        "000110000111111110000000", -- 9 
        "000111001111111110000000", -- 10 ??????????????
        "000111111111111100000000", -- 11
        "000011111111111100000000", -- 12 ????????
        "000001111111111010000000", -- 13
        "000000111111111000000000", -- 14
        "000000011111110000000000", -- 15 ??????????
        "000000001111110000000000", -- 16
        "000000000111110000000000", -- 17
        "000000000110011000000000", -- 18 ??
        "000000000110011000000000", -- 19
        "000000000110011000000000", -- 20
        "000000001110111000000000", -- 21 ????
        "000000000000000000000000", -- 22
        "000000000000000000000000"  -- 23
    );

    function d_p(x, y, xo, yo, w, h : integer) return boolean is
    begin return (x >= xo and x < xo + w and y >= yo and y < yo + h); end function;

    function draw_digit(x, y, num, xo, yo : integer) return boolean is
        variable lx, ly : integer;
    begin
        lx := x - xo; ly := y - yo;
        if (lx >= 0 and lx < 12 and ly >= 0 and ly < 20) then
            case num is
                when 0 => return (lx=0 or lx=11 or ly=0 or ly=19);
                when 1 => return (lx=11);
                when 2 => return (ly=0 or ly=9 or ly=19 or (lx=11 and ly<10) or (lx=0 and ly>9));
                when 3 => return (ly=0 or ly=9 or ly=19 or lx=11);
                when 4 => return (ly=9 or lx=11 or (lx=0 and ly<10));
                when 5 => return (ly=0 or ly=9 or ly=19 or (lx=0 and ly<10) or (lx=11 and ly>9));
                when 6 => return (ly=0 or ly=9 or ly=19 or lx=0 or (lx=11 and ly>9));
                when 7 => return (ly=0 or lx=11);
                when 8 => return (ly=0 or ly=9 or ly=19 or lx=0 or lx=11);
                when 9 => return (ly=0 or ly=9 or ly=19 or lx=11 or (lx=0 and ly<10));
                when others => return false;
            end case;
        end if; return false;
    end function;

    signal is_dino, is_text : boolean;
    signal dx, dy : integer;
begin
    dx <= (pixel_x - 100) / 2; dy <= (pixel_y - dino_y) / 2;
    is_dino <= (pixel_x >= 100 and pixel_x < 148 and pixel_y >= dino_y and pixel_y < dino_y + 48) and
               (dx >= 0 and dx < 24 and dy >= 0 and dy < 24) and (DINO(dy)(dx) = '1');

    process(pixel_x, pixel_y, game_state)
    begin
        is_text <= false;
        if game_state = 0 then -- START
            if d_p(pixel_x,pixel_y,260,100,12,2) or d_p(pixel_x,pixel_y,260,100,2,10) or d_p(pixel_x,pixel_y,260,109,12,2) or d_p(pixel_x,pixel_y,270,109,2,10) or d_p(pixel_x,pixel_y,260,118,12,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,275,100,12,2) or d_p(pixel_x,pixel_y,280,100,2,20) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,290,100,12,2) or d_p(pixel_x,pixel_y,290,100,2,20) or d_p(pixel_x,pixel_y,300,100,2,20) or d_p(pixel_x,pixel_y,290,110,12,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,305,100,2,20) or d_p(pixel_x,pixel_y,305,100,12,2) or d_p(pixel_x,pixel_y,315,100,2,10) or d_p(pixel_x,pixel_y,305,110,12,2) or d_p(pixel_x,pixel_y,313,110,2,10) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,320,100,12,2) or d_p(pixel_x,pixel_y,325,100,2,20) then is_text <= true; end if;
        elsif game_state = 2 then -- GAME OVER
            if d_p(pixel_x,pixel_y,220,100,12,2) or d_p(pixel_x,pixel_y,220,100,2,20) or d_p(pixel_x,pixel_y,220,118,12,2) or d_p(pixel_x,pixel_y,230,110,2,10) or d_p(pixel_x,pixel_y,225,110,7,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,235,100,12,2) or d_p(pixel_x,pixel_y,235,100,2,20) or d_p(pixel_x,pixel_y,245,100,2,20) or d_p(pixel_x,pixel_y,235,110,12,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,250,100,2,20) or d_p(pixel_x,pixel_y,262,100,2,20) or d_p(pixel_x,pixel_y,250,100,14,2) or d_p(pixel_x,pixel_y,256,100,2,10) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,267,100,12,2) or d_p(pixel_x,pixel_y,267,100,2,20) or d_p(pixel_x,pixel_y,267,110,10,2) or d_p(pixel_x,pixel_y,267,118,12,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,295,100,12,2) or d_p(pixel_x,pixel_y,295,118,12,2) or d_p(pixel_x,pixel_y,295,100,2,20) or d_p(pixel_x,pixel_y,305,100,2,20) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,310,100,2,15) or d_p(pixel_x,pixel_y,320,100,2,15) or d_p(pixel_x,pixel_y,312,115,10,4) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,327,100,12,2) or d_p(pixel_x,pixel_y,327,100,2,20) or d_p(pixel_x,pixel_y,327,110,10,2) or d_p(pixel_x,pixel_y,327,118,12,2) then is_text <= true; end if;
            if d_p(pixel_x,pixel_y,342,100,2,20) or d_p(pixel_x,pixel_y,342,100,12,2) or d_p(pixel_x,pixel_y,352,100,2,10) or d_p(pixel_x,pixel_y,342,110,12,2) or d_p(pixel_x,pixel_y,350,110,2,10) then is_text <= true; end if;
        end if;
    end process;

    process(video_on, pixel_x, pixel_y, dino_y, c1_x, c2_x, t1, t2, game_state, is_dino, is_text, score)
        variable s100, s10, s1, h1, h2 : integer;
    begin
        s100 := score/100; s10 := (score/10) mod 10; s1 := score mod 10;
        if t1=2 then h1:=340; else h1:=360; end if; if t2=2 then h2:=340; else h2:=360; end if;
        if video_on = '1' then
            if is_dino then rgb <= "010"; 
            elsif is_text then rgb <= "000"; 
            elsif draw_digit(pixel_x, pixel_y, s100, 25, 25) or draw_digit(pixel_x, pixel_y, s10, 40, 25) or draw_digit(pixel_x, pixel_y, s1, 55, 25) then rgb <= "000";
            elsif (pixel_x >= c1_x and pixel_x < c1_x + 30 and pixel_y >= h1 and pixel_y < 400) or (pixel_x >= c2_x and pixel_x < c2_x + 30 and pixel_y >= h2 and pixel_y < 400) then rgb <= "100";
            elsif (pixel_y >= 400 and pixel_y < 405) then rgb <= "001";
            else case game_state is when 0 => rgb <= "110"; when 1 => rgb <= "111"; when 2 => rgb <= "101"; when others => rgb <= "111"; end case; end if;
        else rgb <= "000"; end if;
    end process;
end Behavioral;
