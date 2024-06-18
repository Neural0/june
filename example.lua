local main = AddWindow({
})
------------------------- -------------------------
    --- aimbot ---       -      --- aimbot ---
------------------------- -------------------------

local First = main:AddTab({
    name = "aimbot"
})

local smooth_section = First:AddSection({
    name = "Smooth Aim",
    height = 225,
})

local silent_section = First:AddSection({
    name = "Silent Aim",
    side = "Right",
    height = 225
})

local recoil_section = First:AddSection({
    name = "Modifications",
    height = 180
})

local checks_section = First:AddSection({
    name = "Checks",
    side = "Right",
    height = 180
})

--[[
local dropdown = subtab2:AddDropdown({
    name = "HitParts",
    list = {"Head", "Torso", "Legs", "Feet"},
    default = 2,
    callback = function(active)
        print(active)
    end
}) --]]

local Second = main:AddTab({
    name = "visuals"
})

local players_section = Second:AddSection({
    name = "Players",
    height = 225
})

local screen_tab = players_section:AddTab({
    name = "Screen"
})

do -- All Esp Options

    local esp = {
        boxes = {
            enabled = false,
            color = Color3.fromRGB(255,255,255),
        },

        boxfill = {
            enabled = false,
            topcolor = Color3.fromRGB(255,255,255),
            bottomcolor = Color3.fromRGB(0,0,0),
            rotation = 100
        },
    
        names = {
            enabled = false,
            color = Color3.fromRGB(255,255,255),
        },

        distance = {
            enabled = false,
            color = Color3.fromRGB(255,255,255),
        },

        TeamCheck = false,

        Connections = {
            RunService = runservice;
        },
    }

    screen_tab:AddToggle({
        name = "boxes",
        default = false,
        risky = false,
        callback = function(state)
            esp.boxes.enabled = state
        end,
        colorpicker = {
            enabled = true,
            color = Color3.fromRGB(255, 255, 255),
            getcolor = function(value)
                esp.boxes.color = value
            end
        },
    })
    
    screen_tab:AddToggle({
        name = "names",
        default = false,
        risky = false,
        callback = function(state)
            esp.names.enabled = state
        end,
        colorpicker = {
            enabled = true,
            color = Color3.fromRGB(255, 255, 255),
            getcolor = function(value)
                esp.names.color = value
            end
        },
    })

    screen_tab:AddToggle({
        name = "distance",
        default = false,
        risky = false,
        callback = function(state)
            esp.distance.enabled = state
        end,
        colorpicker = {
            enabled = true,
            color = Color3.fromRGB(255, 255, 255),
            getcolor = function(value)
                esp.distance.color = value
            end
        },
    })

    screen_tab:AddToggle({
        name = "box fill",
        default = false,
        risky = false,
        callback = function(state)
            esp.boxfill.enabled = state
        end,
    })

    screen_tab:AddSlider({
        name = "rotation",
        default = esp.boxfill.rotation,
        min = -360,
        changeby = 1,
        suffix = "",
        max = 360,
        callback = function(value)
            esp.boxfill.rotation = value
        end
    })

    screen_tab:AddToggle({
        name = "fill top",
        default = false,
        risky = false,
        colorpicker = {
            enabled = true,
            color = esp.boxfill.topcolor,
            getcolor = function(value)
                esp.boxfill.topcolor = value
            end
        },
    })

    screen_tab:AddToggle({
        name = "fill bottom",
        default = false,
        risky = false,
        colorpicker = {
            enabled = true,
            color = esp.boxfill.bottomcolor,
            getcolor = function(value)
                esp.boxfill.bottomcolor = value
            end
        },
    })

    screen_tab:AddToggle({
        name = "Team Check",
        default = false,
        risky = false,
        callback = function(state)
            esp.TeamCheck = state
        end
    })

    local ScreenGui = Create("ScreenGui", {
        Parent = coregui,
        Name = "DrawingContainer"
    })
    local DupeCheck = function(plr)
        if ScreenGui:FindFirstChild(plr.Name) then
            ScreenGui[plr.Name]:Destroy()
        end
    end

    local function playergone()
        for _, child in ipairs(ScreenGui:GetChildren()) do
            local player = players:FindFirstChild(child.Name)
            if not player then
                ScreenGui[child.Name]:Destroy()
            end
        end
    end
    
    runService.Heartbeat:Connect(playergone)
    

    local june = esp.Connections
    function addesp(plr)
        coroutine.wrap(DupeCheck)(plr)
        local box = Create("Frame", {
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            Name = plr.Name
        })
        local outline = Create("UIStroke", {
            Parent = box,
            Color = esp.boxes.color
        })

        local fill = Create("UIGradient", {
            Parent = box,
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, esp.boxfill.topcolor),
                ColorSequenceKeypoint.new(1, esp.boxfill.bottomcolor)},
            Rotation = esp.boxfill.rotation
        });

        local name = Create("TextLabel", {
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold),
            TextColor3 = esp.names.color,
            TextSize = 9,
            Name = plr.Name,
            Text = plr.Name
        })

        local UIStroke = Library:Create("UIStroke", {
            Parent = name,
            Thickness = 2,
            Color = Color3.fromRGB(0,0,0),
            LineJoinMode = Enum.LineJoinMode.Miter,
        })

        local distance = Create("TextLabel", {
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold),
            TextColor3 = esp.names.color,
            TextSize = 8,
            Name = plr.Name,
            Text = plr.Name
        })

        local updatepos = function()
            local Connection
            Connection = june.RunService.RenderStepped:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local HRP = plr.Character.HumanoidRootPart
                    local Humanoid = plr.Character:WaitForChild("Humanoid");
                    local Pos, OnScreen = camera:WorldToScreenPoint(HRP.Position)
                    local Dist = (camera.CFrame.Position - HRP.Position).Magnitude / 3.5714285714
                        
                    if Humanoid.Health <= 0 then return end

                    if OnScreen then
                        local Size = HRP.Size.Y
                        local scaleFactor = (Size * camera.ViewportSize.Y) / (Pos.Z * 2)
                        local w, h = 2.75 * scaleFactor, 4.6 * scaleFactor
                        
                        if esp.boxes.enabled then
                            box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                            box.Size = UDim2.new(0, w, 0, h)
                            outline.Color = esp.boxes.color
                            box.Visible = esp.boxes.enabled
                            if fill.enabled then box.BackgroundTransparency = 0.5 else box.BackgroundTransparency = 1 end
                        else
                            box.Visible = false
                        end

                        if esp.names.enabled then
                            name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - h / 2 - 9)
                            name.TextColor3  = esp.names.color
                            name.Visible = esp.names.enabled
                            Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        else
                            Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                            name.Visible = false
                        end

                        if esp.distance.enabled then
                            distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7)
                            distance.TextColor3  = esp.distance.color
                            distance.Visible = esp.names.enabled
                            distance.Text = math.round(Dist)
                        else
                            distance.Visible = false
                        end

                        if esp.boxfill.enabled then
                            fill.Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, esp.boxfill.topcolor),
                                ColorSequenceKeypoint.new(1, esp.boxfill.bottomcolor)}
                            fill.Rotation = esp.boxfill.rotation
                            fill.Enabled = true
                        else
                            fill.Enabled = false
                        end

                        if esp.TeamCheck then
                            if plr.Team == localplayer.Team then
                                box.Visible = false
                                name.Visible = false
                                distance.Visible = false
                            else
                                box.Visible = true
                                name.Visible = true
                                distance.Visible = true
                            end
                        end

                    else
                        box.Visible = false
                        name.Visible = false
                        distance.Visible = false
                    end
                else
                    box.Visible = false
                    name.Visible = false
                    distance.Visible = false
                end
            end)
        end
        coroutine.wrap(updatepos)()
    end
    
    for _, v in pairs(players:GetPlayers()) do
        if v.Name ~= localplayer.Name then
            coroutine.wrap(addesp)(v)
          end
    end
    --
    players.PlayerAdded:Connect(function(v)
        coroutine.wrap(addesp)(v)
    end)
    
    players.PlayerRemoving:Connect(function(plr)
        ScreenGui[plr.Name]:Destroy()
    end)
end

local model_tab = players_section:AddTab({
    name = "Model"
})

do -- All World Options
    local world_tab = players_section:AddTab({
        name = "World"
    })
    
    do -- Ambience
        local function updateAmbience(pass1, pass2)
            local vars = {
                ambient = {
                    toggle = pass1,
                    color = pass2,
                    default = Color3.fromRGB(1,1,1)
                }
            }
            if vars.ambient.toggle then
                lighting.Ambient = vars.ambient.color
            else
                lighting.Ambient = vars.ambient.default
            end
        end
    
        local ttoggle, tcolor
        local toggle = world_tab:AddToggle({
            name = "Ambient",
            default = false,
            callback = function(state)
                ttoggle = state
                updateAmbience(ttoggle, tcolor)
            end,
            colorpicker = {
                enabled = true,
                color = Color3.fromRGB(255, 255, 255),
                getcolor = function(color)
                    tcolor = color
                    updateAmbience(ttoggle, tcolor)
                end
            },
        })
    end
    
    do -- Brightness
        local function updateBrightness(pass1)
            local vars = {
                brightness = {
                    value = pass1,
                }
            }
    
            lighting.Brightness = vars.brightness.value
        end
    
        local ttoggle
        local slider = world_tab:AddSlider({
            name = "Brightness",
            default = 2,
            min = 0,
            changeby = 1,
            suffix = "",
            max = 25,
            callback = function(value)
                updateBrightness(value)
            end
        })
    end
    
    do -- Color Shift
        local function updateShift(pass1,pass2)
            local vars = {
                shift = {
                    toggle = pass1,
                    color = pass2,
                    default = Color3.fromRGB(0,0,0)
                }
            }
    
            if vars.shift.toggle then
                lighting.ColorShift_Top = vars.shift.color
            else
                lighting.ColorShift_Top = vars.shift.default
            end
        end
    
        local ttoggle, tcolor
        local toggle = world_tab:AddToggle({
            name = "Color Shift",
            default = false,
            callback = function(state)
                ttoggle = state
                updateShift(ttoggle, tcolor)
            end,
            colorpicker = {
                enabled = true,
                color = Color3.fromRGB(255, 255, 255),
                getcolor = function(color)
                    tcolor = color
                    updateShift(ttoggle, tcolor)
                end
            },
        })
    end
    
    do -- Outdoor Ambience
        local function updateOutdoor(pass1, pass2)
            local vars = {
                outdoor = {
                    toggle = pass1,
                    color = pass2,
                    default = Color3.fromRGB(128,128,128)
                }
            }
            if vars.outdoor.toggle then
                lighting.OutdoorAmbient = vars.outdoor.color
            else
                lighting.OutdoorAmbient = vars.outdoor.default
            end
        end
    
        local ttoggle, tcolor
        local toggle = world_tab:AddToggle({
            name = "Outdoor",
            default = false,
            callback = function(state)
                ttoggle = state
                updateOutdoor(ttoggle, tcolor)
            end,
            colorpicker = {
                enabled = true,
                color = Color3.fromRGB(128, 128, 128),
                getcolor = function(color)
                    tcolor = color
                    updateOutdoor(ttoggle, tcolor)
                end
            },
        })
    end
    
    do -- Clock Time
        local function updateTime(pass1)
            local vars = {
                time = {
                    value = pass1,
                }
            }
    
            lighting.ClockTime = vars.time.value
        end
    
        local ttoggle
        local slider = world_tab:AddSlider({
            name = "Time",
            default = 14,
            min = 0,
            changeby = 1,
            suffix = "h",
            max = 24,
            callback = function(value)
                updateTime(value)
            end
        })
    end
    
    do -- Fog
        local function updateFog(pass1, pass2, pass3, pass4)
            local vars = {
                fog = {
                    toggle = pass1,
                    color = pass2,
                    start = pass3,
                    End = pass4,
                    default1 = Color3.fromRGB(192,192,192),
                    default2 = 10000,
                    default3 = 0
                }
            }
    
            if pass3 == nil then
                vars.fog.start = vars.fog.default2
            elseif pass4 == nil then
                vars.fog.End = vars.fog.default3
            end
    
            if vars.fog.toggle then
                lighting.FogColor = vars.fog.color
                lighting.FogEnd = vars.fog.End
                lighting.FogStart = vars.fog.start
            else
                lighting.FogColor = vars.fog.default1
                lighting.FogEnd = vars.fog.default2
                lighting.FogStart = vars.fog.default3
            end
        end
    
        local ttoggle, tcolor, End, start
        local toggle = world_tab:AddToggle({
            name = "Fog",
            default = false,
            callback = function(state)
                ttoggle = state
                updateFog(ttoggle, tcolor, End, start)
            end,
            colorpicker = {
                enabled = true,
                color = Color3.fromRGB(255, 255, 255),
                getcolor = function(color)
                    tcolor = color
                    updateFog(ttoggle, tcolor, End, start)
                end
            },
        })
    
        local slider = world_tab:AddSlider({
            name = "End",
            default = 100,
            min = 0,
            changeby = 1,
            suffix = "",
            max = 100,
            callback = function(value)
                End = value * 100
                updateFog(ttoggle, tcolor, start, value * 100)
            end
        })
    
        local slider2 = world_tab:AddSlider({
            name = "Start",
            default = 0,
            min = 0,
            changeby = 1,
            suffix = "",
            max = 100,
            callback = function(value)
                start = value
                updateFog(ttoggle, tcolor, value, End)
            end
        })
    
    end
end

local Third = main:AddTab({
    name = "misc"
})

local Fourth = main:AddTab({
    name = "configs"
})
