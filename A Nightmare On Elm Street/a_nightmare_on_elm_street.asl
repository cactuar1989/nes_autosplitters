// Based on https://github.com/saturnin55/DucktalesNESAutoSplitter by saturnin55

/*
+++ RAM Map +++
door_rng        0x06F7
boss_hp         0x0113
game_over       0x069A
sleep_meter     0x06C8
screen_section  0x0422
x_pos           0x040B
player_hp       0x010A
bones           0x06EB
keys            0x06EA
boss_id         0x0691 // 3 for Freddy
freddy_beat     0x0605 // changes to 1 when freddy leaves screen
*/

state("mesen", "0.9.8.0")
{
    byte door_rng:      "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x06F7;
    byte x_pos:         "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x040B;
    byte keys:          "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x06EA;
    byte boss_id:       "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x0691;
    byte freddy_beat:   "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x0605;
}

state("mesen", "0.9.9.0")
{
    byte door_rng:      "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x06F7;
    byte x_pos:         "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x040B;
    byte keys:          "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x06EA;
    byte boss_id:       "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x0691;
    byte freddy_beat:   "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x0605;
}

state("fceux", "2.2.3") 
{
    byte door_rng:      0x003B1388, 0x06F7;
    byte x_pos:         0x003B1388, 0x040B;
    byte keys:          0x003B1388, 0x06EA;
    byte boss_id:       0x003B1388, 0x0691;
    byte freddy_beat:   0x003B1388, 0x0605;
}

state("nestopia", "1.40")
{
    // base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
    byte door_rng:      "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x075F;
    byte x_pos:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x0473;
    byte keys:          "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x0752;
    byte boss_id:       "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x06F9;
    byte freddy_beat:   "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x066D;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
}

split
{
    if (old.keys != current.keys && current.keys != 0) return true;
    if (current.boss_id == 3 && current.freddy_beat == 1 && old.freddy_beat == 0) return true;
}

start
{
    if (old.x_pos == 0 && current.x_pos != 0)
    {
        return (current.door_rng == 0);
    }
}

/*
update
{
    print(current.screen_section.ToString());
}
*/
