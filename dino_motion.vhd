library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dino_motion is
    Port (
        clk      : in  STD_LOGIC;  -- 25 MHz
        vsync    : in  STD_LOGIC;  -- ??????????
        btn_jump : in  STD_LOGIC;  
        dino_y   : out integer range 0 to 479
    );
end dino_motion;

architecture Behavioral of dino_motion is
    -- ??????????????????????????? (400 - ?????????? 48 = 352)
    constant GROUND_Y : integer := 352; 
    signal y_pos      : integer range 0 to 479 := GROUND_Y;
    signal y_vel      : integer := 0;
    signal btn_prev   : std_logic := '0';

    -- === [ ????????????????? ] ===
    constant JUMP_FORCE  : integer := -15; -- ????????? (?????????? 1.5x ???????)
    constant GRAVITY     : integer := 1;   -- ???????????
begin
    process(vsync)
        variable v_y, v_v : integer;
    begin
        if falling_edge(vsync) then
            v_y := y_pos; v_v := y_vel;

            if v_y < GROUND_Y then
                -- ?????????: ????????
                v_v := v_v + GRAVITY;
            else
                -- ??????????: ????????
                v_v := 0;
                -- ????????????? (Edge Detection)
                if (btn_jump = '1' and btn_prev = '0') then
                    v_v := JUMP_FORCE;
                end if;
            end if;

            v_y := v_y + v_v;

            -- ???????? (????????)
            if v_y >= GROUND_Y then 
                v_y := GROUND_Y; 
                v_v := 0; 
            end if;

            y_pos    <= v_y;
            y_vel    <= v_v;
            btn_prev <= btn_jump; 
        end if;
    end process;
    dino_y <= y_pos;
end Behavioral;
