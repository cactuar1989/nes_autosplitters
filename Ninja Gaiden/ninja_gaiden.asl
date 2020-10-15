// Based on https://github.com/saturnin55/DucktalesNESAutoSplitter by saturnin55

state("mesen", "0.9.8.0")
{
    byte act:           "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x6d;
    byte stage:         "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x6e;
    byte ryu_x:         "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x86;
    byte ryu_y:         "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x8a;
    byte timer:         "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x63;
    byte boss_hp:       "MesenCore.dll", 0x4327750, 0xB8, 0x78, 0x66;
}

state("mesen", "0.9.9.0")
{
    byte act:           "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x6d;
    byte stage:         "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x6e;
    byte ryu_x:         "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x86;
    byte ryu_y:         "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x8a;
    byte timer:         "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x63;
    byte boss_hp:       "MesenCore.dll", 0x042E0F30, 0, 0x58, 0xC90, 0x58, 0x66;
}

state("fceux", "2.2.3") 
{
    byte act:           0x003B1388, 0x006d;
    byte stage:         0x003B1388, 0x006e;
    byte ryu_x:         0x003B1388, 0x0086;
    byte ryu_y:         0x003B1388, 0x008a;
    byte timer:         0x003B1388, 0x0063;
    byte boss_hp:       0x003B1388, 0x0066;
}

state("nestopia", "1.40")
{
    // base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
    byte act:           "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xd5;
    byte stage:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xd6;
    byte ryu_x:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xee;
    byte ryu_y:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xf2;
    byte timer:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xcb;
    byte boss_hp:       "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xce;
} 

init
{
    version = modules.First().FileVersionInfo.FileVersion;
}

split
{
    if (current.timer == 0 && old.timer != 0 && current.boss_hp == 0) {
        print("SPLIT");
        return true;
    }
}

start
{
    if ((current.ryu_x != old.ryu_x || current.ryu_x != old.ryu_x) && (old.ryu_x != 0 && current.ryu_x != 0)) {
        print("TIMER START");
        return true;
    }
}