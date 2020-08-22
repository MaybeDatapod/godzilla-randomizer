local randomizer = {}

local function romSetup(seed, romPath)
    math.randomseed(seed)
    local f = assert(io.open(romPath, "rb"))
    rom = f:read("*all")
    f:close()
end

local function mapShuffle(seed, bases)
    local earthS = {0x01, 0x01, 0x09, 0x01, 0x09, 0x11, 0x19, 0x09, 0x09, 0x10, 0x09, 0x09, 0x11, 0x11, 0x0A, 0x0A, 0x19, 0x0C, 0x21, 0x05, 0x21, 0x0C, 0x19, 0x05, 0x06, 0x11, 0x06}
    local marS = {0x02, 0x0D, 0x0D, 0x02, 0x02, 0x02, 0x0A, 0x0D, 0x18, 0x18, 0x0A, 0x0A, 0x0D, 0x08, 0x0A, 0x0A, 0x12, 0x12, 0x12, 0x12, 0x12, 0x1A, 0x1A, 0x1A, 0x1A, 0x22, 0x22, 0x22, 0x0E, 0x0E}
    local jupS = {0x04, 0x04, 0x04, 0x04, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0x04, 0x14, 0x14, 0x18, 0x20, 0x0C, 0x14, 0x14, 0x24, 0x21, 0x21, 0x04, 0x04, 0x24, 0x24, 0x21, 0x04, 0x13, 0x13, 0x04, 0x04, 0x04, 0x13, 0x06, 0x13, 0x24, 0x16, 0x16, 0x06, 0x16}
    local satS = {0x03, 0x01, 0x01, 0x03, 0x0B, 0x0B, 0x03, 0x0B, 0x0B, 0x03, 0x01, 0x01, 0x01, 0x09, 0x09, 0x09, 0x21, 0x21, 0x21, 0x21, 0x09, 0x10, 0x09, 0x09, 0x01, 0x18, 0x20, 0x10, 0x13, 0x13, 0x13, 0x1B, 0x1B, 0x23, 0x23, 0x16, 0x16, 0x16, 0x16}
    local uraS = {0x05, 0x10, 0x15, 0x16, 0x0D, 0x15, 0x0D, 0x16, 0x08, 0x20, 0x16, 0x0D, 0x15, 0x0D, 0x05, 0x10, 0x15}
    local pluS = {0x01, 0x21, 0x21, 0x01, 0x02, 0x0A, 0x0A, 0x02, 0x13, 0x03, 0x03, 0x13, 0x24, 0x04, 0x04, 0x24, 0x08, 0x10, 0x20, 0x08, 0x04, 0x04, 0x04, 0x26, 0x06, 0x0C, 0x12, 0x16, 0x11, 0x1A, 0x0A, 0x09, 0x19, 0x22, 0x22, 0x13, 0x21, 0x21, 0x02, 0x12, 0x0B, 0x0B, 0x11, 0x01}
    local nepS = {0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x1E, 0x1E, 0x1E, 0x1E, 0x26, 0x26, 0x26, 0x26, 0x26, 0x26, 0x16, 0x16, 0x16, 0x16, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x1E, 0x1E, 0x1E, 0x1E, 0x1E, 0x26, 0x26, 0x26, 0x26, 0x26}
    local xstarS = {0x06, 0x06, 0x21, 0x26, 0x26, 0x22, 0x1E, 0x0E, 0x23, 0x16, 0x16, 0x24, 0x1E, 0x0E, 0x08, 0x06, 0x26}
    if bases == true then
        table.insert(earthS, 1, 0x17)
        table.insert(marS, 1, 0x17)
        table.insert(jupS, 1, 0x1F)
        table.insert(satS, 1, 0x1F)
        table.insert(uraS, 1, 0x1F)
        table.insert(pluS, 1, 0x27)
        table.insert(nepS, 1, 0x27)
        table.insert(xstarS, 1, 0x27)
    end
    earthS = lShuffle(earthS)
    marS = lShuffle(marS)
    jupS = lShuffle(jupS)
    satS = lShuffle(satS)
    uraS = lShuffle(uraS)
    pluS = lShuffle(pluS)
    nepS = lShuffle(nepS)
    xstarS = lShuffle(xstarS)
    local skips = 0
    for i=0xF4A3, 0xF4C9 do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, earthS[i-skips-0xF4A2])
        end
    end
    local skips = 0
    for i=0xF4CF, 0xF50B do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, marS[i-skips-0xF4CE])
        end
    end
    local skips = 0
    for i=0xF50C, 0xF553 do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, jupS[i-skips-0xF50B])
        end
    end
    local skips = 0
    for i=0xF554, 0xF5A0 do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, satS[i-skips-0xF553])
        end
    end
    local skips = 0
    for i=0xF5A1, 0xF5CC do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, uraS[i-skips-0xF5A0])
        end
    end
    local skips = 0
    for i=0xF5CD, 0xF60E do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, pluS[i-skips-0xF5CC])
        end
    end
    local skips = 0
    for i=0xF60F, 0xF63A do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, nepS[i-skips-0xF60E])
        end
    end
    local skips = 0
    for i=0xF63B, 0xF682 do
        if (getByte(i, rom) == "7" or getByte(i, rom) == "f" or getByte(i, rom) == "17" or getByte(i, rom) == "1f" or getByte(i, rom) == "27") and bases == false then
            skips = skips + 1
        elseif getByte(i, rom) == "0" then
            skips = skips + 1
        else
            rom = replaceByte(i, rom, xstarS[i-skips-0xF63A])
        end
    end
end

function bossShuffle(type)
    xstarM = lShuffle({0xE88C, 0xE88B, 0xE88A, 0xE889, 0xE888, 0xE887, 0xE886, 0xE885})
    if type == 1 then
        earthM = lShuffle({0xE838, 0xE836})
        marM = lShuffle({0xE844, 0xE843, 0xE842})
        jupM = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D})
        satM = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE857})
        uraM = lShuffle({0xE868, 0xE867, 0xE866, 0xE865, 0xE864, 0xE863})
        pluM = lShuffle({0xE874, 0xE873, 0xE872, 0xE871, 0xE870, 0xE86F, 0xE86E})
        nepM = lShuffle({0xE880, 0xE87F, 0xE87E, 0xE87D, 0xE87C, 0xE87B, 0xE87A})
    elseif type == 2 then
        earthM = lShuffle({0xE838, 0xE837, 0xE836, 0xE833})
        marM = lShuffle({0xE844, 0xE843, 0xE842, 0xE841, 0xE83F})
        jupM = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D, 0xE84C, 0xE84B})
        satM = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE858, 0xE857, 0xE856})
    elseif type == 3 then
        earthM = lShuffle({0xE838, 0xE837, 0xE836, 0xE835, 0xE834, 0xE833, 0xE832, 0xE831})
        marM = lShuffle({0xE844, 0xE843, 0xE842, 0xE841, 0xE840, 0xE83F, 0xE83E, 0xE83D})
        jupM = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D, 0xE84C, 0xE84B, 0xE84A, 0xE849})
        satM = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE858, 0xE857, 0xE856, 0xE855})
    end
    if type == 2 or type == 3 then
        uraM = lShuffle({0xE868, 0xE867, 0xE866, 0xE865, 0xE864, 0xE863, 0xE862, 0xE861})
        pluM = lShuffle({0xE874, 0xE873, 0xE872, 0xE871, 0xE870, 0xE86F, 0xE86E, 0xE86D})
        nepM = lShuffle({0xE880, 0xE87F, 0xE87E, 0xE87D, 0xE87C, 0xE87B, 0xE87A, 0xE879})
        earthO = lShuffle({0xE838, 0xE836})
        marO = lShuffle({0xE844, 0xE843, 0xE842})
        jupO = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D})
        satO = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE857})
        uraO = lShuffle({0xE868, 0xE867, 0xE866, 0xE865, 0xE864, 0xE863})
        pluO = lShuffle({0xE874, 0xE873, 0xE872, 0xE871, 0xE870, 0xE86F, 0xE86E})
        nepO = lShuffle({0xE880, 0xE87F, 0xE87E, 0xE87D, 0xE87C, 0xE87B, 0xE87A})
    end
    local earthS = {0x25, 0x20}
    local marS = {0x28, 0x34, 0x2A}
    local jupS = {0x3E, 0x29, 0x34, 0x36}
    local satS = {0x3B, 0x46, 0x25, 0x2F, 0x22}
    local uraS = {0x0C, 0x11, 0x17, 0x1D, 0x12, 0x07}
    local pluS = {0x1E, 0x1B, 0x27, 0x2B, 0x14, 0x17, 0x12}
    local nepS = {0x24, 0x11, 0x23, 0x25, 0x12, 0x14, 0x15}
    local xstarS = {0x3F, 0x39, 0x2E, 0x3A, 0x34, 0x29, 0x2F, 0x23}
    for i = 1, 2 do
        rom = replaceByte(earthO[i], rom, 0xF1)
    end
    for i = 1, 3 do
        rom = replaceByte(marO[i], rom, 0xF2)
    end
    for i = 1, 4 do
        rom = replaceByte(jupO[i], rom, 0xF3)
    end
    for i = 1, 5 do
        rom = replaceByte(satO[i], rom, 0xF4)
    end
    for i = 1, 6 do
        rom = replaceByte(uraO[i], rom, 0xF5)
    end
    for i = 1, 7 do
        rom = replaceByte(pluO[i], rom, 0xF6)
    end
    for i = 1, 7 do
        rom = replaceByte(nepO[i], rom, 0xF7)
    end
    for i = 1, 2 do
        rom = replaceByte(earthM[i], rom, earthS[i])
    end
    for i = 1, 3 do
        rom = replaceByte(marM[i], rom, marS[i])
    end
    for i = 1, 4 do
        rom = replaceByte(jupM[i], rom, jupS[i])
    end
    for i = 1, 5 do
        rom = replaceByte(satM[i], rom, satS[i])
    end
    for i = 1, 6 do
        rom = replaceByte(uraM[i], rom, uraS[i])
    end
    for i = 1, 7 do
        rom = replaceByte(pluM[i], rom, pluS[i])
    end
    for i = 1, 7 do
        rom = replaceByte(nepM[i], rom, nepS[i])
    end
    for i = 1, 8 do
        rom = replaceByte(xstarM[i], rom, xstarS[i])
    end
end

function shuffleMons()
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE82D, rom, 0x01)
        rom = replaceByte(0xE82E, rom, 0x00)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE839, rom, 0x03)
        rom = replaceByte(0xE83A, rom, 0x02)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE845, rom, 0x03)
        rom = replaceByte(0xE846, rom, 0x02)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE851, rom, 0x03)
        rom = replaceByte(0xE852, rom, 0x02)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE85D, rom, 0x1A)
        rom = replaceByte(0xE85E, rom, 0x0F)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE869, rom, 0x03)
        rom = replaceByte(0xE86A, rom, 0x02)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE875, rom, 0x05)
        rom = replaceByte(0xE876, rom, 0x00)
    end
    if math.random(0, 1) == 1 then
        rom = replaceByte(0xE881, rom, 0x03)
        rom = replaceByte(0xE882, rom, 0x02)
    end
end

function removeMon(monster)
    rom = replaceByte(0xE82C + monster, rom, 0xF1)
    rom = replaceByte(0xE838 + monster, rom, 0xF2)
    rom = replaceByte(0xE844 + monster, rom, 0xF3)
    rom = replaceByte(0xE850 + monster, rom, 0xF4)
    rom = replaceByte(0xE85C + monster, rom, 0xF5)
    rom = replaceByte(0xE868 + monster, rom, 0xF6)
    rom = replaceByte(0xE874 + monster, rom, 0xF7)
    rom = replaceByte(0xE880 + monster, rom, 0xF8)
end

function writeRom(seed)
    romR = io.open("godzilla-randomized-"..seed..".nes", "wb")
    romR:write(rom)
end

function replaceChar(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

function replaceByte(pos, str, r)
    return replaceChar(pos+1, str, string.char(tonumber(r)))
end

function getByte(pos, str)
    return string.format("%x", string.byte(str:sub(pos+1, pos+1)))
end

function lShuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(i)
		list[i], list[j] = list[j], list[i]
	end
    return list
end

randomizer.mapShuffle = mapShuffle
randomizer.bossShuffle = bossShuffle
randomizer.shuffleMons = shuffleMons
randomizer.removeMon = removeMon
randomizer.romSetup = romSetup
randomizer.writeRom = writeRom
return randomizer
