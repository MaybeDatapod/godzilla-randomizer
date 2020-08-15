local randomizer = {}
earthS = {0x01, 0x01, 0x09, 0x01, 0x09, 0x11, 0x19, 0x09, 0x09, 0x10, 0x09, 0x09, 0x11, 0x11, 0x0A, 0x0A, 0x19, 0x0C, 0x21, 0x05, 0x21, 0x0C, 0x19, 0x05, 0x06, 0x11, 0x06}
marS = {0x02, 0x0D, 0x0D, 0x02, 0x02, 0x02, 0x0A, 0x0D, 0x18, 0x18, 0x0A, 0x0A, 0x0D, 0x08, 0x0A, 0x0A, 0x12, 0x12, 0x12, 0x12, 0x12, 0x1A, 0x1A, 0x1A, 0x1A, 0x22, 0x22, 0x22, 0x0E, 0x0E}
jupS = {0x04, 0x04, 0x04, 0x04, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0x04, 0x14, 0x14, 0x18, 0x20, 0x0C, 0x14, 0x14, 0x24, 0x21, 0x21, 0x04, 0x04, 0x24, 0x24, 0x21, 0x04, 0x13, 0x13, 0x04, 0x04, 0x04, 0x13, 0x06, 0x13, 0x24, 0x16, 0x16, 0x06, 0x16}
satS = {0x03, 0x01, 0x01, 0x03, 0x0B, 0x0B, 0x03, 0x0B, 0x0B, 0x03, 0x01, 0x01, 0x01, 0x09, 0x09, 0x09, 0x21, 0x21, 0x21, 0x21, 0x09, 0x10, 0x09, 0x09, 0x01, 0x18, 0x20, 0x10, 0x13, 0x13, 0x13, 0x1B, 0x1B, 0x23, 0x23, 0x16, 0x16, 0x16, 0x16}
uraS = {0x05, 0x10, 0x15, 0x16, 0x0D, 0x15, 0x0D, 0x16, 0x08, 0x20, 0x16, 0x0D, 0x15, 0x0D, 0x05, 0x10, 0x15}
pluS = {0x01, 0x21, 0x21, 0x01, 0x02, 0x0A, 0x0A, 0x02, 0x13, 0x03, 0x03, 0x13, 0x24, 0x04, 0x04, 0x24, 0x08, 0x10, 0x20, 0x08, 0x04, 0x04, 0x04, 0x26, 0x06, 0x0C, 0x12, 0x16, 0x11, 0x1A, 0x0A, 0x09, 0x19, 0x22, 0x22, 0x13, 0x21, 0x21, 0x02, 0x12, 0x0B, 0x0B, 0x11, 0x01}
nepS = {0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x1E, 0x1E, 0x1E, 0x1E, 0x26, 0x26, 0x26, 0x26, 0x26, 0x26, 0x16, 0x16, 0x16, 0x16, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x1E, 0x1E, 0x1E, 0x1E, 0x1E, 0x26, 0x26, 0x26, 0x26, 0x26}
xstarS = {0x06, 0x06, 0x21, 0x26, 0x26, 0x22, 0x1E, 0x0E, 0x23, 0x16, 0x16, 0x24, 0x1E, 0x0E, 0x08, 0x06, 0x26}

local function mapShuffle(seed, bases, romPath)
    math.randomseed(seed)
    local f = assert(io.open(romPath, "rb"))
    local rom = f:read("*all")
    f:close()
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
    romR = io.open("godzilla randomized "..seed..".nes", "wb")
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

function string.fromhex(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

function lShuffle(list)
	for i = #list, 2, -1 do
		local j = math.random(i)
		list[i], list[j] = list[j], list[i]
	end
    return list
end

randomizer.mapShuffle = mapShuffle
return randomizer