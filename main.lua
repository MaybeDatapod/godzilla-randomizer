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

function main()
    frame = wx.wxFrame( wx.NULL, wx.wxID_ANY, "Godzilla Randomizer",
                        wx.wxDefaultPosition, wx.wxSize(300, 300),
                        wx.wxDEFAULT_FRAME_STYLE )

                        local notebook = wx.wxNotebook(frame, wx.wxID_ANY,
                                   wx.wxDefaultPosition, wx.wxDefaultSize)

    local panel = wx.wxPanel(notebook, wx.wxID_ANY)
    local sizer = wx.wxBoxSizer(wx.wxVERTICAL)

    local checkBox = wx.wxCheckBox(panel, ID_MAPS,"Shuffle Maps",
                                            wx.wxDefaultPosition, wx.wxDefaultSize,
                                            wx.wxLB_MULTIPLE, wx.wxGenericValidatorBool(checkObj))
    local checkBox2 = wx.wxCheckBox(panel, ID_BASES, "Shuffle Base Headquarters",
                                            wx.wxDefaultPosition, wx.wxDefaultSize,
                                            wx.wxLB_MULTIPLE)


    local checkBoxStaticBox = wx.wxStaticBox( panel, wx.wxID_ANY, "Map Settings")
    local checkBoxStaticBoxSizer = wx.wxStaticBoxSizer( checkBoxStaticBox, wx.wxVERTICAL );
    checkBoxStaticBoxSizer:Add(checkBox, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)
    checkBoxStaticBoxSizer:Add(checkBox2, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    checkBox2:Enable(checkObj:GetObject())

    local textCtrl   = wx.wxTextCtrl( panel, wx.wxID_ANY, tostring(os.time(os.date("!*t"))), wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER, wx.wxTextValidator(wx.wxFILTER_NUMERIC, textSeedObj))
    local textCtrlStaticBox = wx.wxStaticBox( panel, wx.wxID_ANY, "Seed")
    local textCtrlStaticBoxSizer = wx.wxStaticBoxSizer( textCtrlStaticBox, wx.wxVERTICAL );
    textCtrlStaticBoxSizer:Add(textCtrl, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    local filePicker = wx.wxFilePickerCtrl(panel, wx.wxID_ANY, wx.wxGetCwd(), wx.wxFileSelectorPromptStr, wx.wxFileSelectorDefaultWildcardStr,
                                         wx.wxDefaultPosition, wx.wxDefaultSize,
                                         wx.wxFLP_USE_TEXTCTRL)
    local filePickerStaticBox = wx.wxStaticBox( panel, wx.wxID_ANY, "ROM")
    local filePickerStaticBoxSizer = wx.wxStaticBoxSizer( filePickerStaticBox, wx.wxVERTICAL );
    filePickerStaticBoxSizer:Add(filePicker, 1, wx.wxALL + wx.wxGROW + wx.wxCENTER, 5)

    local genButton = wx.wxButton( panel, wx.wxID_OK, "&Generate")
    genButton:SetDefault()

    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
    function(event)
        if event:GetEventObject():DynamicCast("wxWindow"):GetId() == 1 then
            checkBox2:Enable(event:GetSelection())
        end
    end)

    panel:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_BUTTON_CLICKED,
    function(event)
        if checkBox:GetValue() == true then
            randomizer.mapShuffle(textCtrl:GetValue(),checkBox2:GetValue(),filePicker:GetPath())
        end
    end)

    sizer:Add(checkBoxStaticBoxSizer, 28, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(textCtrlStaticBoxSizer, 23, wx.wxALL + wx.wxGROW, 5)
    sizer:Add(filePickerStaticBoxSizer, 23, wx.wxALL + wx.wxGROW, 5)
    sizer:Add( genButton, 0, wx.wxALIGN_RIGHT+wx.wxALL, 5 )
    panel:SetSizer(sizer)
    sizer:SetSizeHints(panel)
    notebook:AddPage(panel, "Randomizer")

    frame:Show(true)
end

main()

wx.wxGetApp():MainLoop()
