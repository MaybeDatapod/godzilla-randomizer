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

function bossShuffle(type, ghidora)
    xstarM = lShuffle({0xE88C, 0xE88B, 0xE88A, 0xE889, 0xE888, 0xE887, 0xE886, 0xE885})
    damM = lShuffle({0x1E9A1, 0x1E9A2, 0x1E9A3, 0x1E9A4, 0x1E9A5, 0x1E9A6, 0x1E9A7, 0x1E9A8})
    earthO = lShuffle({0xE838, 0xE836})
    marO = lShuffle({0xE844, 0xE843, 0xE842})
    jupO = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D})
    satO = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE857})
    uraO = lShuffle({0xE868, 0xE867, 0xE866, 0xE865, 0xE864, 0xE863})
    pluO = lShuffle({0xE874, 0xE873, 0xE872, 0xE871, 0xE870, 0xE86F, 0xE86E})
    nepO = lShuffle({0xE880, 0xE87F, 0xE87E, 0xE87D, 0xE87C, 0xE87B, 0xE87A})
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
        earthM = lShuffle({0xE838, 0xE837, 0xE836, 0xE835, 0xE834, 0xE833, 0xE832})
        marM = lShuffle({0xE844, 0xE843, 0xE842, 0xE841, 0xE840, 0xE83F, 0xE83E})
        jupM = lShuffle({0xE850, 0xE84F, 0xE84E, 0xE84D, 0xE84C, 0xE84B, 0xE84A})
        satM = lShuffle({0xE85C, 0xE85B, 0xE85A, 0xE859, 0xE858, 0xE857, 0xE856})
    end
    if type == 2 or type == 3 then
        uraM = lShuffle({0xE868, 0xE867, 0xE866, 0xE865, 0xE864, 0xE863, 0xE862})
        pluM = lShuffle({0xE874, 0xE873, 0xE872, 0xE871, 0xE870, 0xE86F, 0xE86E})
        nepM = lShuffle({0xE880, 0xE87F, 0xE87E, 0xE87D, 0xE87C, 0xE87B, 0xE87A})
    end
    if ghidora == true and type >= 2 then
        table.insert(uraM, 1, 0xE861)
        table.insert(pluM, 1, 0xE86D)
        table.insert(nepM, 1, 0xE879)
        uraM = lShuffle(uraM)
        pluM = lShuffle(pluM)
        nepM = lShuffle(nepM)
        if type == 3 then
            table.insert(earthM, 1, 0xE831)
            table.insert(marM, 1, 0xE83D)
            table.insert(jupM, 1, 0xE849)
            table.insert(satM, 1, 0xE855)
            earthM = lShuffle(earthM)
            marM = lShuffle(marM)
            jupM = lShuffle(jupM)
            satM = lShuffle(satM)
        end
    end
    local earthS = {0x25, 0x20}
    local marS = {0x28, 0x34, 0x2A}
    local jupS = {0x3E, 0x29, 0x34, 0x36}
    local satS = {0x3B, 0x46, 0x25, 0x2F, 0x22}
    local uraS = {0x0C, 0x11, 0x17, 0x1D, 0x12, 0x07}
    local pluS = {0x1E, 0x1B, 0x27, 0x2B, 0x14, 0x17, 0x12}
    local nepS = {0x24, 0x11, 0x23, 0x25, 0x12, 0x14, 0x15}
    local xstarS = {0x3F, 0x39, 0x2E, 0x3A, 0x34, 0x29, 0x2F, 0x23}
    local damS = {0x26, 0x20, 0x1B, 0x25, 0x24, 0x1F, 0x1A, 0x15}
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
    for i = 1, 8 do
        rom = replaceByte(damM[i], rom, damS[i])
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
    if math.random(0, 1) == 1 then
        rom = replaceByte(0x1E99D, rom, 0x01)
        rom = replaceByte(0x1E99E, rom, 0x00)
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
    rom = replaceByte(0x1E99C + monster, rom, 0xF1)
end

function paletteRand()
    gBytes1 = {0x1D125, 0x1D126}
    gBytes2 = {0x1D0ED, 0x1D0EE, 0x1D0EF, 0x1D0F0, 0x1D0F1, 0x1D0F2, 0x1D127, 0x1D143, 0x1D144, 0x1D145, 0xF0D9, 0xF0DA}
    mBytes1 = {0x1AF40, 0x1D186, 0x1D324}
    mBytes2 = {0xF0DD, 0x1AF3E, 0x1AF3F, 0x1AF6E, 0x1D17F, 0x1D322, 0x1D323}
    mBytes3 = {0x1AF6F, 0x1AF70, 0x1D182, 0x1D183, 0x1D184, 0x1D185, 0x1D187}
    gpal = math.random(0, 11)
    gpal2 = gpal
    if gpal2 > 0 then
        gpal2 = gpal2 - 12
    end
    mpal = math.random(0, 11)
    mpal2, mpal3, mpal4, mpal5 = mpal, mpal, mpal, mpal
    if mpal >= 11 then
        mpal2 = mpal2 - 12
        mpal3 = mpal3 - 12
        mpal4 = mpal4 - 12
        mpal5 = mpal5 - 12
    elseif mpal >= 7 then
        mpal3 = mpal3 - 12
        mpal4 = mpal4 - 12
        mpal5 = mpal5 - 12
    elseif mpal >= 6 then
        mpal4 = mpal4 - 12
        mpal5 = mpal5 - 12
    elseif mpal >= 5 then
        mpal5 = mpal5 - 12
    end
    for i = 1, 2 do
        rom = replaceByte(gBytes1[i], rom, tonumber(getByte(gBytes1[i], rom), 16)+gpal)
    end
    for i = 1, 12 do
        rom = replaceByte(gBytes2[i], rom, tonumber(getByte(gBytes2[i], rom), 16)+gpal2)
    end
    rom = replaceByte(0xF0DE, rom, tonumber(getByte(0xF0DE, rom), 16)+mpal)
    rom = replaceByte(0x1D180, rom, tonumber(getByte(0x1D180, rom), 16)+mpal2)
    for i = 1, 3 do
        if mBytes1[i] == 0x1D324 then
            rom = replaceByte(mBytes1[i], rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x10, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x20, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x30, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x40, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x50, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x5D, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x87, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0x97, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0xA7, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0xB7, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0xC7, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0xD7, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            rom = replaceByte(mBytes1[i] + 0xE7, rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
            
        else
            rom = replaceByte(mBytes1[i], rom, tonumber(getByte(mBytes1[i], rom), 16)+mpal3)
        end
    end
    for i = 1, 7 do
        if mBytes2[i] == 0x1D322 or mBytes2[i] == 0x1D323 then
            rom = replaceByte(mBytes2[i], rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x10, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x20, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x30, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x40, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x50, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x5D, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x87, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0x97, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0xA7, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0xB7, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0xC7, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0xD7, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
            rom = replaceByte(mBytes2[i] + 0xE7, rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
        else
            rom = replaceByte(mBytes2[i], rom, tonumber(getByte(mBytes2[i], rom), 16)+mpal4)
        end
    end
    for i = 1, 7 do
        rom = replaceByte(mBytes3[i], rom, tonumber(getByte(mBytes3[i], rom), 16)+mpal5)
    end
end

function musicRand()--type)
    --if type == 1 then
        local tracks = {0x10648, 0x10649, 0x1064A, 0x1064B, 0x1064C, 0x1064D, 0x1064E, 0x1064F, 0x10650, 0x10651, 0x10652, 0x10653, 0x10654, 0x10655, 0x10656, 0x10657, 0x1397E, 0x1E266, 0x1F40B, 0x1F574}
        local songs = lShuffle({0x14, 0x12, 0x10, 0x11, 0x0F, 0x0F, 0x1B, 0x13, 0x02, 0x09, 0x0C, 0x0B, 0x0E, 0x0D, 0x0A, 0x08, 0x19, 0x08, 0x09, 0x17})
        for i = 1, 20 do
            if i > 8 and i < 17 then
                rom = replaceByte(tracks[i], rom, songs[i])
                rom = replaceByte(tracks[i]+0xE3EC, rom, songs[i])
                rom = replaceByte(tracks[i]+0xE65F, rom, songs[i])
            elseif tracks[i] == 0x1397E then
                rom = replaceByte(0x1397E, rom, songs[i])
                rom = replaceByte(0x1797E, rom, songs[i])
                rom = replaceByte(0x1B980, rom, songs[i])
            else
                rom = replaceByte(tracks[i], rom, songs[i])
            end
        end
    --elseif type == 2 then
    --    local tracks = {0x10648, 0x10649, 0x1064A, 0x1064B, 0x1064C, 0x1064D, 0x1064E, 0x1064F, 0x10650, 0x10651, 0x10652, 0x10653, 0x10654, 0x10655, 0x10656, 0x10657, 0x1397E, 0x1797E, 0x1B980, 0x1E266, 0x1EA3C, 0x1EA3D, 0x1EA3E, 0x1EA3F, 0x1EA40, 0x1EA41, 0x1EA42, 0x1EA43, 0x1ECAF, 0x1ECB0, 0x1ECB1, 0x1ECB2, 0x1ECB3, 0x1ECB4, 0x1ECB5, 0x1ECB6, 0x1F40B, 0x1F574}
    --    for i = 1, 38 do
    --        rom = replaceByte(tracks[i], rom, 0x00)
    --    end
    --end
end

function miscSettings(time, move, intro, level)
    if time == true then
        rom = replaceByte(0x1C640, rom, 0xA5)
    end
    if move == true then
        rom = replaceByte(0xE44A, rom, 0xA5)
    end
    if intro == true then
        rom = replaceByte(0x1BED2, rom, 0x00)
        rom = replaceByte(0x1F46C, rom, 0x00)
    end
    if level > 0 then
        rom = replaceByte(0x1E91E, rom, level)
    end
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
randomizer.paletteRand = paletteRand
randomizer.musicRand = musicRand
randomizer.miscSettings = miscSettings
randomizer.romSetup = romSetup
randomizer.writeRom = writeRom
return randomizer
