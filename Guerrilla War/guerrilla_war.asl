// Based on https://github.com/saturnin55/DucktalesNESAutoSplitter by saturnin55

/*
+++ RAM Map +++ 
000B    level_id // 0-9
0061    player_ctrl // 0 = playing, -128 on cutscenes/transitions
05AB    boss_hp
0035    fade_out // goes to 16 on final fade_out
*/

state("mesen", "0.9.8.0")
{
    byte level_id:      "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x000B;
    byte player_ctrl:   "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x0061;
    byte fade_out:      "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x0035;
}

state("mesen", "0.9.9.0")
{
    byte level_id:      "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x000B;
    byte player_ctrl:   "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x0061;
    byte fade_out:      "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x0035;
}

state("fceux", "2.2.3") 
{
    byte level_id:      0x003B1388, 0x000B;
    byte player_ctrl:   0x003B1388, 0x0061;
    byte fade_out:      0x003B1388, 0x0035;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
}

split
{
    if (current.player_ctrl != 0 && old.player_ctrl == 0) return true;
    if (current.level_id == 9 && current.fade_out == 16 && old.fade_out == 0) return true;
}

start
{
    if (current.player_ctrl == 0 && old.player_ctrl != 0) return true;
}

