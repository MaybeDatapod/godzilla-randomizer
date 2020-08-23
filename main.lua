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

function main()
    frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "Godzilla Randomizer v0.2.1", wx.wxDefaultPosition, wx.wxSize(350, 560), wx.wxDEFAULT_FRAME_STYLE)
    local notebook = wx.wxNotebook(frame, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize)

    local panel = wx.wxPanel(notebook, wx.wxID_ANY)
    local sizer = wx.wxBoxSizer(wx.wxVERTICAL)

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

    local textCtrl   = wx.wxTextCtrl(panel, wx.wxID_ANY, tostring(os.time(os.date("!*t"))), wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER, wx.wxTextValidator(wx.wxFILTER_NUMERIC, textSeedObj))
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

    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
    function(event)
        if event:GetEventObject():DynamicCast("wxWindow"):GetId() == 1 then
            baseCheck:Enable(event:GetSelection())
            if mapCheck:GetValue() == false then
                baseCheck:SetValue(false)
            end
        end
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHOICE_SELECTED,
    function(event)
        local flagString = bool_to_number(mapCheck:GetValue())..bool_to_number(baseCheck:GetValue())..bossSel:GetSelection()..bool_to_number(ghidoraCheck:GetValue())..bool_to_number(monsterSel:GetValue())..monChoice:GetSelection()
        flagCtrl:SetValue(basen(flagString, 36))
    end)
    
    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER,
    function(event)
        if flagCtrl:GetValue() == "" then
            flagCtrl:SetValue("0")
        end
        local flags = string.format("%.0f", tonumber(flagCtrl:GetValue(), 36)+111111)
            mapCheck:SetValue((string.sub(flags, 1, 1)-1)%2)
            baseCheck:SetValue((string.sub(flags, 2, 2)-1)%2)
            bossSel:SetSelection((string.sub(flags, 3, 3)-1)%4)
            ghidoraCheck:SetValue((string.sub(flags, 4, 4)-1)%2)
            monsterSel:SetValue((string.sub(flags, 5, 5)-1)%2)
            monChoice:SetSelection((string.sub(flags, 6, 6)-1)%3)
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
        randomizer.writeRom(textCtrl:GetValue())
    end)

    sizer:Add(checkBoxStaticBoxSizer, 28, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(radioBoxStaticBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(monBoxSizer, 34, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(textCtrlStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(flagCtrlStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(filePickerStaticBoxSizer, 22, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(genButton, 0, wx.wxALIGN_RIGHT+wx.wxALL, 5)
    panel:SetSizer(sizer)
    sizer:SetSizeHints(panel)
    notebook:AddPage(panel, "Randomizer")

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
