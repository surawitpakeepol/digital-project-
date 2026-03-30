library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cactus_motion is
    Port (
        vsync      : in  STD_LOGIC;
        game_state : in  integer range 0 to 2;
        cactus1_x  : out integer range -500 to 1200;
        cactus2_x  : out integer range -500 to 1200;
        type1      : out integer range 0 to 2;
        type2      : out integer range 0 to 2;
        score_val  : out integer range 0 to 999
    );
end cactus_motion;

architecture Behavioral of cactus_motion is
    signal x1 : integer range -500 to 1200 := 800;
    signal x2 : integer range -500 to 1200 := 1200;
    signal t1 : integer range 0 to 2 := 1;
    signal t2 : integer range 0 to 2 := 0;
    signal p_state : integer range 1 to 6 := 1;
    signal score : integer range 0 to 999 := 0;
    signal speed : integer := 5;
    signal cnt   : integer := 0;
begin
    process(vsync)
    begin
        if falling_edge(vsync) then
            if game_state = 1 then
                cnt <= cnt + 1;
                if cnt = 40 then cnt <= 0; if score < 999 then score <= score + 1; end if; end if;
                speed <= 5 + (score/100); if speed > 13 then speed <= 13; end if;

                x1 <= x1 - speed; x2 <= x2 - speed;

                if x1 < -100 and x2 < -100 then
                    case p_state is
                        when 1 => x1 <= 640; x2 <= 1200; t1 <= 1; t2 <= 0; p_state <= 2; -- 1 ????
                        when 2 => x1 <= 640; x2 <= 675;  t1 <= 1; t2 <= 1; p_state <= 3; -- 2 ????
                        when 3 => x1 <= 640; x2 <= 1200; t1 <= 2; t2 <= 0; p_state <= 4; -- 1 ??? 1.5x
                        when 4 => x1 <= 640; x2 <= 1200; t1 <= 1; t2 <= 0; p_state <= 5; -- 1 ????
                        when 5 => x1 <= 640; x2 <= 675;  t1 <= 2; t2 <= 1; p_state <= 6; -- ??? + ????
                        when 6 => x1 <= 640; x2 <= 675;  t1 <= 1; t2 <= 1; p_state <= 1; -- 2 ????
                    end case;
                end if;
            elsif game_state = 0 then
                x1 <= 800; x2 <= 1200; t1 <= 1; t2 <= 0; p_state <= 1; score <= 0; speed <= 5;
            end if;
        end if;
    end process;
    cactus1_x <= x1; cactus2_x <= x2; type1 <= t1; type2 <= t2; score_val <= score;
end Behavioral;
