randomizer = require("randomizer")
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

frame = nil

check_val  = false
text_seed_val = 1

checkObj  = wxlua.wxLuaObject(check_val)
textSeedObj = wxlua.wxLuaObject(text_seed_val)

ID_MAPS = 1
ID_BASES = 2
ID_BOSSES = 3
ID_GHIDORA = 4
ID_MONSTERS = 5
ID_MONTOGGLE = 6
ID_PALETTE = 7
ID_MUSIC = 8
ID_TIME = 9
ID_MOVEMENT = 10
ID_INTRO = 11
ID_LEVEL = 12

math.randomseed(os.time(os.date("!*t")))
newSeed = tostring(math.random(1000000000, 9999999999))

function main()
    frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "Godzilla Randomizer v0.3", wx.wxDefaultPosition, wx.wxSize(350, 560), wx.wxDEFAULT_FRAME_STYLE)
    local notebook = wx.wxNotebook(frame, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize)

    local panel = wx.wxPanel(notebook, wx.wxID_ANY)
    local panel2 = wx.wxPanel(notebook, wx.wxID_ANY)
    local panel3 = wx.wxPanel(notebook, wx.wxID_ANY)
    local sizer = wx.wxBoxSizer(wx.wxVERTICAL)
    local sizer2 = wx.wxBoxSizer(wx.wxVERTICAL)
    local sizer3 = wx.wxBoxSizer(wx.wxVERTICAL)

    local mapCheck = wx.wxCheckBox(panel, ID_MAPS,"Shuffle Maps", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE, wx.wxGenericValidatorBool(checkObj))
    local baseCheck = wx.wxCheckBox(panel, ID_BASES, "Shuffle Base Headquarters", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)

    local checkBoxStaticBox = wx.wxStaticBox(panel, wx.wxID_ANY, "Map Settings")
    local checkBoxStaticBoxSizer = wx.wxStaticBoxSizer(checkBoxStaticBox, wx.wxVERTICAL);
    checkBoxStaticBoxSizer:Add(mapCheck, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    checkBoxStaticBoxSizer:Add(baseCheck, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    baseCheck:Enable(false)
    
    local bossSel = wx.wxChoice(panel, ID_BOSSES, wx.wxDefaultPosition, wx.wxDefaultSize, {"Off", "Easy Shuffle", "Intermediate Shuffle", "Difficult Shuffle"}, 1)
    bossSel:SetSelection(0)
    local ghidoraCheck = wx.wxCheckBox(panel, ID_BASES, "Allow Ghidora to appear outside of Planet X", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local radioBoxStaticBox = wx.wxStaticBox(panel, wx.wxID_ANY, "Boss Shuffle")
    local radioBoxStaticBoxSizer = wx.wxStaticBoxSizer(radioBoxStaticBox, wx.wxVERTICAL);
    radioBoxStaticBoxSizer:Add(bossSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    radioBoxStaticBoxSizer:Add(ghidoraCheck, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    
    local monsterSel = wx.wxCheckBox(panel, ID_MONSTERS, "Shuffle Godzilla and Mothra", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local monBox = wx.wxStaticBox(panel, wx.wxID_ANY, "Monster Shuffle")
    local monChoice = wx.wxChoice(panel, ID_MONTOGGLE, wx.wxDefaultPosition, wx.wxDefaultSize, {"Keep Both Monsters", "No Godzilla", "No Mothra"})
    monChoice:SetSelection(0)
    local monBoxSizer = wx.wxStaticBoxSizer(monBox, wx.wxVERTICAL);
    monBoxSizer:Add(monsterSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    monBoxSizer:Add(monChoice, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    local textCtrl   = wx.wxTextCtrl(panel, wx.wxID_ANY, newSeed, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER, wx.wxTextValidator(wx.wxFILTER_NUMERIC, textSeedObj))
    local textCtrlStaticBox = wx.wxStaticBox(panel, wx.wxID_ANY, "Seed")
    local textCtrlStaticBoxSizer = wx.wxStaticBoxSizer(textCtrlStaticBox, wx.wxVERTICAL)
    textCtrlStaticBoxSizer:Add(textCtrl, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    
    local flagCtrl   = wx.wxTextCtrl(panel, wx.wxID_ANY, "0", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER, wx.wxTextValidator(wx.wxFILTER_ALPHANUMERIC, textSeedObj))
    local flagCtrlStaticBox = wx.wxStaticBox(panel, wx.wxID_ANY, "Flags")
    local flagCtrlStaticBoxSizer = wx.wxStaticBoxSizer(flagCtrlStaticBox, wx.wxVERTICAL)
    flagCtrlStaticBoxSizer:Add(flagCtrl, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    local filePicker = wx.wxFilePickerCtrl(panel, wx.wxID_ANY, wx.wxGetCwd(), wx.wxFileSelectorPromptStr, wx.wxFileSelectorDefaultWildcardStr, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxFLP_USE_TEXTCTRL)
    local filePickerStaticBox = wx.wxStaticBox(panel, wx.wxID_ANY, "ROM")
    local filePickerStaticBoxSizer = wx.wxStaticBoxSizer(filePickerStaticBox, wx.wxVERTICAL)
    filePickerStaticBoxSizer:Add(filePicker, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    local genButton = wx.wxButton(panel, wx.wxID_OK, "&Generate")
    genButton:SetDefault()
    
    local paletteSel = wx.wxCheckBox(panel2, ID_PALETTE, "Randomize Color Palettes", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local palBox = wx.wxStaticBox(panel2, wx.wxID_ANY, "Color Palette")
    local palBoxSizer = wx.wxStaticBoxSizer(palBox, wx.wxVERTICAL);
    palBoxSizer:Add(paletteSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    
    local musicSel = wx.wxCheckBox(panel2, ID_MUSIC, "Shuffle Music", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local musBox = wx.wxStaticBox(panel2, wx.wxID_ANY, "Music")
    local blankText = wx.wxStaticText(panel2, wx.wxID_ANY, "")
    local musBoxSizer = wx.wxStaticBoxSizer(musBox, wx.wxVERTICAL);
    musBoxSizer:Add(musicSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    musBoxSizer:Add(blankText, 10, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    
    local timeSel = wx.wxCheckBox(panel3, ID_TIME, "Infinite Boss Fight Timer", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local moveSel = wx.wxCheckBox(panel3, ID_MOVEMENT, "Infinite Map Movement", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local introSel = wx.wxCheckBox(panel3, ID_INTRO, "Skip Intro", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxLB_MULTIPLE)
    local staticText = wx.wxStaticText(panel3, wx.wxID_ANY, "Starting Level")
    local levelChoice = wx.wxChoice(panel3, ID_LEVEL, wx.wxDefaultPosition, wx.wxDefaultSize, {"1", "2", "3",  "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"})
    levelChoice:SetSelection(0)
    local blankText2 = wx.wxStaticText(panel3, wx.wxID_ANY, "")
    local miscBox = wx.wxStaticBox(panel3, wx.wxID_ANY, "Miscellaneous Settings")
    local miscBoxSizer = wx.wxStaticBoxSizer(miscBox, wx.wxVERTICAL);
    miscBoxSizer:Add(timeSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    miscBoxSizer:Add(moveSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    miscBoxSizer:Add(introSel, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    miscBoxSizer:Add(staticText, 0, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    miscBoxSizer:Add(levelChoice, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    miscBoxSizer:Add(blankText2, 10, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
    function(event)
        if event:GetEventObject():DynamicCast("wxWindow"):GetId() == 1 then
            baseCheck:Enable(event:GetSelection())
            if mapCheck:GetValue() == false then
                baseCheck:SetValue(false)
            end
        end
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel2:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
    function(event)
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel3:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
    function(event)
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHOICE_SELECTED,
    function(event)
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel2:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHOICE_SELECTED,
    function(event)
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel3:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHOICE_SELECTED,
    function(event)
        local levelString = levelChoice:GetSelection()
        if levelString < 10 then
            levelString = "0"..levelString
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()..bool_to_number(paletteSel:GetValue())..bool_to_number(musicSel:GetValue())..bool_to_number(timeSel:GetValue())..bool_to_number(moveSel:GetValue())..bool_to_number(introSel:GetValue())..levelString
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER,
    function(event)
        if flagCtrl:GetValue() == "" then
            flagCtrl:SetValue("0")
        end
        local flags = string.format("%.0f", tonumber(flagCtrl:GetValue(), 36)+1111111111101)
            mapCheck:SetValue((string.sub(flags, 1, 1)-1)%2)
            baseCheck:SetValue((string.sub(flags, 2, 2)-1)%2)
            bossSel:SetSelection((string.sub(flags, 3, 3)-1)%4)
            ghidoraCheck:SetValue((string.sub(flags, 4, 4)-1)%2)
            monsterSel:SetValue((string.sub(flags, 5, 5)-1)%2)
            monChoice:SetSelection((string.sub(flags, 6, 6)-1)%3)
            paletteSel:SetValue((string.sub(flags, 7, 7)-1)%2)
            musicSel:SetValue((string.sub(flags, 8, 8)-1)%2)
            timeSel:SetValue((string.sub(flags, 9, 9)-1)%2)
            moveSel:SetValue((string.sub(flags, 10, 10)-1)%2)
            introSel:SetValue((string.sub(flags, 11, 11)-1)%2)
            levelChoice:SetSelection((string.sub(flags, 12, 13)-1)%16)
    end)

    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_BUTTON_CLICKED,
    function(event)
        randomizer.romSetup(textCtrl:GetValue(), filePicker:GetPath())
        if mapCheck:GetValue() == true then
            randomizer.mapShuffle(textCtrl:GetValue(), baseCheck:GetValue())
        end
        if bossSel:GetSelection() ~= 0 then
            randomizer.bossShuffle(bossSel:GetSelection(), ghidoraCheck:GetValue())
        end
        if monsterSel:GetValue() == true then
            randomizer.shuffleMons()
        end
        if monChoice:GetSelection() ~= 0 then
            randomizer.removeMon(monChoice:GetSelection())
        end
        if paletteSel:GetValue() == true then
            randomizer.paletteRand()
        end
        if musicSel:GetValue() == true then
            randomizer.musicRand()
        end
        randomizer.miscSettings(timeSel:GetValue(), moveSel:GetValue(), introSel:GetValue(), levelChoice:GetSelection())
        randomizer.writeRom(textCtrl:GetValue())
        wx.wxMessageBox("Randomization Complete!", "", wx.wxOK + wx.wxICON_INFORMATION, panel)
    end)

    sizer:Add(checkBoxStaticBoxSizer, 28, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(radioBoxStaticBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(monBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(textCtrlStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(flagCtrlStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(filePickerStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(genButton, 0, wx.wxALIGN_RIGHT+wx.wxALL, 5)
    
    sizer2:Add(palBoxSizer, 6, wx.wxALL + wx.wxGROW, 5)
    sizer2:Add(musBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    
    sizer3:Add(miscBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    
    panel:SetSizer(sizer)
    sizer:SetSizeHints(panel)
    notebook:AddPage(panel, "Randomizer")
    panel2:SetSizer(sizer2)
    sizer2:SetSizeHints(panel2)
    notebook:AddPage(panel2, "Cosmetic")
    panel3:SetSizer(sizer3)
    sizer3:SetSizeHints(panel3)
    notebook:AddPage(panel3, "Misc.")

    frame:Show(true)
end

local floor,insert = math.floor, table.insert
function basen(n,b)
    n = floor(n)
    if not b or b == 10 then return tostring(n) end
    local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local t = {}
    local sign = ""
    if n < 0 then
        sign = "-"
    n = -n
    end
    repeat
        local d = (n % b) + 1
        n = floor(n / b)
        insert(t, 1, digits:sub(d,d))
    until n == 0
    return sign .. table.concat(t,"")
end

function bool_to_number(value)
  return value and 1 or 0
end

main()

wx.wxGetApp():MainLoop()
