--[[------------------------------------------------------------]]
            --[[------- june --------]]
--[[------------------------------------------------------------]]

repeat task.wait() until game:IsLoaded()

--- services
local players		= cloneref(game:GetService("Players"))
local StarterPlayer = game:GetService("StarterPlayer")
local tweenService	= cloneref(game:GetService("TweenService"))
local runService	= cloneref(game:GetService("RunService"))
local CoreGui       = cloneref(game:GetService("CoreGui"))
local UIS			= cloneref(game:GetService("UserInputService"))
local lighting      = cloneref(game:GetService("Lighting"))

local runservice = cloneref(game:GetService("RunService"))
local workspace  = cloneref(game:GetService("Workspace"))
local coregui    = cloneref(game:GetService("CoreGui"))

-- Vars
local localplayer = players.LocalPlayer
local camera = workspace.CurrentCamera

-- vars
local mouse 		= localplayer:GetMouse()
local tweenInfo 	= TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

-- Library
local Library = {
    Ui_Bind = Enum.KeyCode.RightShift,
    MenuColors = {
        Background = Color3.fromRGB(40,40,40),
        InnerContainer = Color3.fromRGB(22, 22, 22),
        Section = Color3.fromRGB(24, 24, 24),
        BorderColor = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(7, 191, 117),
        TabInactive = Color3.fromRGB(60, 60, 60),
        TabActive = Color3.fromRGB(200, 200, 200),
        ElementText = Color3.fromRGB(160, 160, 160),
        RiskyText = Color3.fromRGB(150, 0, 0),
    },
    flags = {},
}

-- Function to create an instance
function Library:Create(Class, Properties)
    local _Instance = type(Class) == 'string' and Instance.new(Class) or Class
    for Property, Value in next, Properties do
        _Instance[Property] = Value
    end
    return _Instance
end

-- QOL Functions
function Library:validate(defaults, options)
	for i,v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
    return options
end
function Library:tween(object, goal, callback)
	local tween = tweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function AddWindow(options)
    local options = options or {}
	options = Library:validate({
		name = "june.cc",
        size = UDim2.new(0, 480, 0, 540)
	}, options or {})

    local menu = {
        CurrentTab = nil
    }

    local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end)
    local ScreenGui = cloneref(Instance.new("ScreenGui")) ProtectGui(ScreenGui)
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.Name = "june.cc"

    -----------------------------
       ---- Main Window  -----
    -----------------------------

    local Background = Library:Create('Frame', {
        Name = "june",
        Size = options.size,
        AnchorPoint = Vector2.new("0.5","0.5"),
        Position = UDim2.new(0.5, -100, 0.5, 0),
        BackgroundColor3 = Library.MenuColors.Background,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })

    local UIShadow = Library:Create("ImageLabel", {
        Parent = Background,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://17391257361",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 5, 0.5, 20),
        Size = UDim2.new(1, 200, 1, 200)
    })

    local mousebutton = Library:Create("TextButton", {
        Parent = Background,
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        TextTransparency = 1,
        BorderSizePixel = 0,
        Name = "mousebutton",
        Modal = true
    })

    local Title = Library:Create("TextLabel", {
        Parent = Background,
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.new(0,10,0,1),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 11,
        RichText = true,
        Text = options.name,
        FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold),
        TextXAlignment = Enum.TextXAlignment.Left,
        Name = "Title"
    })

    local TabContainer = Library:Create("Frame", {
        Parent = Background,
        Size = UDim2.new(1, -70, 0, 22),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Name = "TabContainer"
    })

    local UIPadding = Library:Create("UIPadding", {
        Parent = TabContainer,
        PaddingRight = UDim.new(0, 10)
    })

    local TabLayout = Library:Create("UIListLayout", {
        Parent = TabContainer,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Name = "TabLayout"
    })

    local InnerContainer = Library:Create("Frame", {
        Parent = Background,
        Size = UDim2.new(1, -22, 1, -32),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 10),
        BackgroundColor3 = Library.MenuColors.InnerContainer,
        BorderSizePixel = 0,
        Name = "InnerContainer"
    })

    local UIStroke = Library:Create("UIStroke", {
        Parent = InnerContainer,
        Color = Library.MenuColors.BorderColor
    })

    local addedwidths = 0
    function menu:AddTab(options)
        options = Library:validate({
            name = "Example"
        }, options or {})

        local tab = {
            Hover = false,
            Active = false
        }

        local Tab = Library:Create("TextLabel", {
            Parent = TabContainer,
            BackgroundTransparency = 1,
            TextColor3 = Library.MenuColors.TabInactive,
            TextSize = 11,
            Text = options.name,
            FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold),
            TextXAlignment = Enum.TextXAlignment.Center,
            Size = UDim2.new(0, 0, 1, 0),
            Name = options.name,
        })
        Tab.Size = UDim2.new(0, Tab.TextBounds.X + 5, 1, 0) -- Correct Size

        local TabLine = Library:Create("Frame", {
            Parent = Tab,
            BackgroundColor3 = Library.MenuColors.TabInactive,
            BackgroundTransparency = 0.6,
            Size = UDim2.new(1, 0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, -1),
            BorderSizePixel = 0,
            Name = options.name,
        })

        -- Calculate new width for TabContainer [bcuz my tab functionality is ass :cry]
        local width = 0
        width = addedwidths + width + Tab.AbsoluteSize.X + 5
        addedwidths = width
        TabContainer.Size = UDim2.new(0, width, 0, TabContainer.Size.Y.Offset)

        -----------------------------
            --- Tab Content -----
        -----------------------------

        local InnerContainer = Library:Create("Frame", {
            Parent = InnerContainer,
            Size = UDim2.new(1, -14, 1, -14),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Active = false,
            Visible = false,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = options.name
        })
        
        local ContainerLSize = InnerContainer.AbsoluteSize.X / 2 - 10
        local LeftContainer = Library:Create("Frame", {
            Parent = InnerContainer,
            Visible = false,
            Size = UDim2.new(0, ContainerLSize, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "LeftContainer"
        })

        local ContainerRSize = InnerContainer.AbsoluteSize.X / 2 - 10
        local RightContainer = Library:Create("Frame", {
            Parent = InnerContainer,
            Visible = false,
            Size = UDim2.new(0, ContainerRSize, 1, 0),
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "RightContainer"
        })

        do -- Functionality
			function tab:Activate()
				if not tab.Active then
					if menu.CurrentTab ~= nil then
						tab:Deactivate()
					end

					tab.Active = true
					InnerContainer.Active = true
					InnerContainer.Visible = true

					LeftContainer.Visible = true
					RightContainer.Visible = true

                    Library:tween(TabLine, {BackgroundColor3 = Library.MenuColors.Accent})
                    Library:tween(TabLine, {BackgroundTransparency = 0})
                    Library:tween(Tab, {TextColor3 = Library.MenuColors.TabActive})
					menu.CurrentTab = Tab
				end
			end
			
			function tab:Deactivate()
				if tab.Active then

					tab.Active = false
					tab.Hover = false

					InnerContainer.Active = false
					InnerContainer.Visible = false

					LeftContainer.Visible = false
					RightContainer.Visible = false

                    Library:tween(TabLine, {BackgroundColor3 = Library.MenuColors.TabInactive})
                    Library:tween(TabLine, {BackgroundTransparency = 0.6})
                    Library:tween(Tab, {TextColor3 = Library.MenuColors.TabInactive})
				end
			end

			-- Logic
			Tab.MouseEnter:Connect(function()
				tab.Hover = true

				if not tab.Active then
                    Library:tween(TabLine, {BackgroundColor3 = Library.MenuColors.Accent})
                    Library:tween(TabLine, {BackgroundTransparency = 0})
                    Library:tween(Tab, {TextColor3 = Library.MenuColors.TabActive})
				end
			end)
		
			Tab.MouseLeave:Connect(function()
				tab.Hover = false

				if not tab.Active then
                    Library:tween(TabLine, {BackgroundColor3 = Library.MenuColors.TabInactive})
                    Library:tween(TabLine, {BackgroundTransparency = 0.6})
                    Library:tween(Tab, {TextColor3 = Library.MenuColors.TabInactive})
				end
			end)

			TabContainer.MouseEnter:Connect(function()
				tab.MouseInside = true
			end)

			TabContainer.MouseLeave:Connect(function()
				tab.MouseInside = false
			end)

			UIS.InputBegan:Connect(function(input,gpe)
				if gpe then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if tab.Hover then
						tab:Activate()
					elseif tab.MouseInside then
						tab:Deactivate()
					end
				end
			end)

			if menu.CurrentTab == nil then
				tab:Activate()
			end
        end

        local LeftHeight = {}
		local RightHeight = {}
		local NewPos = 0

        function tab:AddSection(options)
            options = Library:validate({
				name = "Preview",
				side = "Left",
				height = "200"
			}, options or {})
            
            local section = {
                Hover = false,
            }
			-- Calculate Section Position
			do
				if options.side == "Left" then
					if LeftHeight then
						if #LeftHeight > 0 then
							NewPos = LeftHeight[1] + 30
						else
							NewPos = 15
						end
					else
						NewPos = 15
					end
				else
					if RightHeight then
						if #RightHeight > 0 then
							NewPos = RightHeight[1] + 30
						else
							NewPos = 15
						end
					else
						NewPos = 15
					end
				end
            end

            local Section = Library:Create("Frame", {
                Size = UDim2.new(1, 0, 0, options.height),
                AnchorPoint = Vector2.new(0, 0),
                BackgroundColor3 = Library.MenuColors.Section,
                Position = UDim2.new(0, 0, 0, NewPos - 12),
                BorderSizePixel = 0,
                Name = options.name
            })

            do -- handle side picking
                if options.side == "Right" then
                    Section.Parent = RightContainer
                    table.insert(RightHeight, Section.Size.Y.Offset)
                else
                    Section.Parent = LeftContainer
                    table.insert(LeftHeight, Section.Size.Y.Offset)
                end
            end

            local SectionText = Library:Create("TextLabel", {
                Parent = Section,
                Size = UDim2.new(0, 0, 0, 1),
                Position = UDim2.new(0, 15, 0, -2),
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                FontFace = Font.fromId(12187362578, Enum.FontWeight.SemiBold),
                Text = options.name,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 10,
                Name = "SectionText",
                ZIndex = 2
            })
            

			local Size = SectionText.TextBounds.X + 20
			local LineSize = Size / -1

            local SectionLine = Library:Create("Frame", {
                Parent = Section,
                Size = UDim2.new(0, LineSize, 0, 1),
                Position = UDim2.new(0, 20, 0, -1),
                AnchorPoint = Vector2.new(1, 0),
                BackgroundColor3 = Color3.fromRGB(27, 27, 34),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Name = "SectionLine",
            })
            

            local UIStroke2 = Library:Create("UIStroke", {
                Thickness = 1,
                Color = Library.MenuColors.BorderColor,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = Section,
                Name = "UIStroke2"
            })

            local SubContainer = Library:Create("Frame", {
                Parent = Section,
                Size = UDim2.new(1, 0, 0, 16),
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.new(0, 0, 0, 6),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "SubContainer",
                Active = true
            })
            
            local SectionTabLayout = Library:Create("UIListLayout", {
                Parent = SubContainer,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 0),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Name = "SectionTabLayout"
            })

            local ElementContainer = Library:Create("Frame", {
                Parent = Section,
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1,
                Name = "ElementContainer"
            })
            
            local UIPadding1 = Library:Create("UIPadding", {
                Parent = ElementContainer,
                PaddingTop = UDim.new(0, 10),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            })

            local ElementLayout = Library:Create("UIListLayout", {
                Parent = ElementContainer,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5)
            })

            getgenv().TabsExist = false
            function section:AddTab(options)
                options = Library:validate({
                    name = "Preview"
                }, options or {})
    
                local sectiontab = {
                    Hover = false,
                    Active = false
                }
                local TabGUI = {
                    CurrentTab = nil
                }
                getgenv().TabsExist = true

				ElementContainer:Destroy()

                local TabButton = Library:Create("Frame", {
                    Parent = SubContainer,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = options.name
                })

                local SectionTabText = Library:Create("TextLabel", {
                    Parent = TabButton,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Thin),
                    Text = options.name,
                    TextColor3 = Library.MenuColors.TabInactive,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Name = "SectionText"
                })

                local SectionTabLine = Library:Create("Frame", {
                    Parent = TabButton,
                    Size = UDim2.new(1, -4, 0, 1),
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 2),
                    BackgroundColor3 = Library.MenuColors.TabInactive,
                    BackgroundTransparency = 0.6,
                    BorderSizePixel = 0,
                    Name = "SectionTabLine"
                })

				-- Calculate Tab Size To Fit
				do
					local tabCount = 0
					for _, sectiontab in ipairs(SubContainer:GetChildren()) do
						if sectiontab:IsA("Frame") then
							tabCount = tabCount + 1
						end
					end
					
					local finalValue = SubContainer.AbsoluteSize.X / tabCount
					for _, sectiontab in ipairs(SubContainer:GetChildren()) do
						if sectiontab:IsA("Frame") then
							sectiontab.Size = UDim2.new(0, finalValue, 1, 0)
						end
					end
				end

                local TabInnerContainer = Library:Create("Frame", {
                    Parent = Section,
                    Size = UDim2.new(1, 0, 1, -32),
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 0, 0, 32),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Active = false,
                    Visible = false,
                    Name = "TabInnerContainer"
                })

                local UIPadding2 = Instance.new("UIPadding")
                UIPadding2.Parent = TabInnerContainer
                UIPadding2.PaddingLeft = UDim.new(0, 10)
                UIPadding2.PaddingTop = UDim.new(0, 5)
                UIPadding2.PaddingRight = UDim.new(0, 10)
                UIPadding2.PaddingBottom = UDim.new(0, 5)
                
				getgenv().TabInnerContainer = TabInnerContainer

                -- Functionality
				do
					function sectiontab:Activate()
						if not sectiontab.Active then
							if TabGUI.CurrentTab ~= nil then
								sectiontab:Deactivate()
							end
					
							sectiontab.Active = true

							TabInnerContainer.Active = true
							TabInnerContainer.Visible = true

                            Library:tween(SectionTabLine, {BackgroundColor3 = Library.MenuColors.Accent})
                            Library:tween(SectionTabLine, {BackgroundTransparency = 0})
                            Library:tween(SectionTabText, {TextColor3 = Library.MenuColors.TabActive})
					
							TabGUI.CurrentTab = sectiontab
						end
					end

					function sectiontab:Deactivate()
						if sectiontab.Active then
					
							sectiontab.Active = false
							sectiontab.Hover = false
					
							TabInnerContainer.Active = false
							TabInnerContainer.Visible = false
					
                            Library:tween(SectionTabLine, {BackgroundColor3 = Library.MenuColors.TabInactive})
                            Library:tween(SectionTabLine, {BackgroundTransparency = 0.6})
                            Library:tween(SectionTabText, {TextColor3 = Library.MenuColors.TabInactive})
						end
					end

					-- Logic
					TabButton.MouseEnter:Connect(function()
						sectiontab.Hover = true

						if not sectiontab.Active then
                            Library:tween(SectionTabLine, {BackgroundColor3 = Library.MenuColors.Accent})
                            Library:tween(SectionTabLine, {BackgroundTransparency = 0})
                            Library:tween(SectionTabText, {TextColor3 = Library.MenuColors.TabActive})
						end
					end)
				
					TabButton.MouseLeave:Connect(function()
						sectiontab.Hover = false

						if not sectiontab.Active then
                            Library:tween(SectionTabLine, {BackgroundColor3 = Library.MenuColors.TabInactive})
                            Library:tween(SectionTabLine, {BackgroundTransparency = 0.6})
                            Library:tween(SectionTabText, {TextColor3 = Library.MenuColors.TabInactive})
						end
					end)

					SubContainer.MouseEnter:Connect(function()
						sectiontab.MouseInside = true
					end)
					
					SubContainer.MouseLeave:Connect(function()
						sectiontab.MouseInside = false
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if sectiontab.Hover then
								sectiontab:Activate()
							elseif sectiontab.MouseInside then
								sectiontab:Deactivate()
							end
						end
					end)
				end

                local ContentLayout = Library:Create("UIListLayout", {
                    Parent = TabInnerContainer,
                    FillDirection = Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Name = "ContentLayout"
                })

                return section
            end

            function section:AddButton(options)
                options = Library:validate({
                    name = "Example Button",
                    callback = function() end,
                    subbutton = {
                        enabled = false,
                        name = "Subbutton",
                        callback = function() end
                    },
                }, options or {})

                local button = {
                    Hover = false
                }
                
                if getgenv().TabsExist then
                    elementParent = getgenv().TabInnerContainer
                else
                    elementParent = ElementContainer
                end
                getgenv().elementparent = elementParent

                local ButtonContainer = Library:Create("Frame", {
                    Parent = getgenv().elementparent,
                    Size = UDim2.new(1, 0, 0, 20),
                    Name = options.name,
                    BackgroundTransparency = 1
                })

                local Button = Library:Create("Frame", {
                    Parent = ButtonContainer,
                    Position = UDim2.new(0, 15, 0, 0),
                    Name = "Button",
                    BorderSizePixel = 1,
                    BorderColor3 = Library.MenuColors.BorderColor
                })

                local UIGradient = Library:Create("UIGradient", {
                    Parent = Button,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                    },
                    Rotation = 90,
                })
                
                if options.subbutton.enabled then
                    Button.Size = UDim2.new(0.5, -30, 0, 17)
                else
                    Button.Size = UDim2.new(1, -50, 0, 17)
                end

                local ButtonTitle = Library:Create("TextLabel", {
                    Parent = Button,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = Library.MenuColors.ElementText,
                    TextSize = 11,
                    Text = options.name,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Name = "ButtonTitle"
                })
                
                -- Functionality
                do
                    Button.MouseEnter:Connect(function()
                        button.Hover = true
        
                        Library:tween(ButtonTitle, {TextColor3 = Library.MenuColors.Accent})
                    end)
                
                    Button.MouseLeave:Connect(function()
                        button.Hover = false

                        Library:tween(ButtonTitle, {TextColor3 = Library.MenuColors.ElementText})
                    end)

                    UIS.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if button.Hover then
                                options.callback()
                            end
                        end
                    end)
                end

                ---- Sub Buttons ----
                if options.subbutton.enabled then
                    local button1 = {
                        Hover = false
                    }
                    
                    local Button1 = Library:Create("Frame", {
                        Parent = ButtonContainer,
                        Size = UDim2.new(0.5, -30, 0, 17),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -30, 0.425, 0),
                        Name = "SubButton",
                        BorderSizePixel = 1,
                        BorderColor3 = Library.MenuColors.BorderColor
                    })

                    local UIGradient2 = Library:Create("UIGradient", {
                        Parent = Button1,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                        },
                        Rotation = 90,
                    })

                    local ButtonTitle1 = Library:Create("TextLabel", {
                        Parent = Button1,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = Library.MenuColors.ElementText,
                        TextSize = 11,
                        Text = options.subbutton.name,
                        FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Name = "ButtonTitle"
                    })
                
                    -- Functionality
                    do
                        Button1.MouseEnter:Connect(function()
                            button1.Hover = true
                            Library:tween(ButtonTitle1, {TextColor3 = Library.MenuColors.Accent})
                        end)
                
                        Button1.MouseLeave:Connect(function()
                            button1.Hover = false
                            Library:tween(ButtonTitle1, {TextColor3 = Library.MenuColors.ElementText})
                        end)
    
                        UIS.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if button1.Hover then
                                    options.subbutton.callback()
                                end
                            end
                        end)
                    end
                end

                return section
            end

            function section:AddToggle(options)
                options = Library:validate({
					name = "Example Toggle",
                    default = true,
                    risky = false,
                    callback = function(state) end,
                    -- keybinds
                    keybinds = {
                        enabled = false,
                        key = "A",
                        getkey = function(key) end,
                    },
                    -- colorpickers
                    colorpicker = {
                        enabled = false,
                        color = Color3.fromRGB(255, 255, 255),
                        getcolor = function(color) end
                    },
				}, options or {})

                local toggle = {
                    Hover = false,
                    State = options.default
                }
                local keybind = {
                    Hover = false,
                    key = options.keybinds.key
                }

                if not options.flag and options.name then options.flag = options.name end
                if not options.keybinds.flag and options.name then options.keybinds.flag = options.name.."keybind" end
                if not options.colorpicker.flag and options.name then options.colorpicker.flag = options.name.."colorpicker" end
                if not options.colorpicker.color and options.name then options.colorpicker.color = Color3.fromRGB(255,255,255) end

                if options.keybinds.key == "" or options.keybinds.key == nil then
                    options.keybinds.key = "..."
                    keybind.key = "..."
                end

                if getgenv().TabsExist then
                    elementParent = getgenv().TabInnerContainer
                else
                    elementParent = ElementContainer
                end
                getgenv().elementparent = elementParent

                local ToggleContainer = Library:Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 12),
                    Parent = getgenv().elementparent,
                    BackgroundTransparency = 1,
                    Name = "ToggleContainer"
                })

                local Toggle = Library:Create("Frame", {
                    Size = UDim2.new(0, 7, 0, 8),
                    BackgroundColor3 = Library.MenuColors.TabInactive,
                    BorderColor3 = Library.MenuColors.BorderColor,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Parent = ToggleContainer,
                    Name = "Toggle",
                    BorderSizePixel = 2
                })

                local UIStroke3 = Library:Create("UIStroke", {
                    Thickness = 1,
                    Color = Color3.fromRGB(0, 0, 0),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = Toggle,
                    Name = "UIStroke3"
                })

                local ToggleTitle = Library:Create("TextLabel", {
                    Parent = ToggleContainer,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 15, 0, 6),
                    BackgroundTransparency = 1,
                    TextColor3 = Library.MenuColors.ElementText,
                    TextSize = 11,
                    Text = options.name,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Name = "ToggleTitle",
                })

                if options.risky == false then
                    ToggleTitle.TextColor3 = Library.MenuColors.ElementText
                else
                    ToggleTitle.TextColor3 = Library.MenuColors.RiskyText
                end

                do -- Functionality
                    ToggleContainer.MouseEnter:Connect(function()
						toggle.Hover = true
						Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.Accent})
					end)
				
					ToggleContainer.MouseLeave:Connect(function()
						toggle.Hover = false
						if toggle.State ~= true then
							Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.InnerContainer})
						end
					end)
                    
                    if toggle.State then
                        Library.flags[options.flag] = toggle.State
                        Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.Accent})

                    else
                        Library.flags[options.flag] = toggle.State
                        Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.InnerContainer})
                        
                    end

                    UIS.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if toggle.Hover and not keybind.Hover then
                                toggle.State = not toggle.State
                                options.callback(toggle.State)
                                if toggle.State then
                                    Library.flags[options.flag] = toggle.State
                                  
                                    Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.Accent})
                                else
                                    Library.flags[options.flag] = toggle.State
                                  
                                    Library:tween(Toggle, {BackgroundColor3 = Library.MenuColors.InnerContainer})
                                end
                            end
                        end
                    end)
                end
                options.callback(toggle.State)

                ---- Keybinds ----
                local Keybind = Instance.new("Frame")
                if options.keybinds.enabled then
                    options.keybinds.getkey(keybind.key)
                
                    Keybind.Parent = ToggleContainer
                    Keybind.Size = UDim2.new(0, 45, 1, 0)
                    Keybind.AnchorPoint = Vector2.new(1, 0.5)
                    Keybind.Position = UDim2.new(1.1, 0, 0.5, 0)
                    Keybind.Name = "Keybind"
                    Keybind.BorderColor3 = Library.MenuColors.BorderColor
                    Keybind.BackgroundColor3 = Library.MenuColors.InnerContainer
                    Keybind.BorderSizePixel = 2

                    local KeybindText = Library:Create("TextLabel", {
                        Parent = Keybind,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        TextColor3 = Library.MenuColors.ElementText,
                        TextSize = 9,
                        Text = options.keybinds.key,
                        FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Name = "KeybindText"
                    })
                    
                    local UIStroke4 = Library:Create("UIStroke", {
                        Thickness = 1,
                        Color = Color3.fromRGB(0, 0, 0),
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        Parent = Keybind,
                        Name = "UIStroke4"
                    })                    
                    
                    Keybind.Size = UDim2.new(0, KeybindText.TextBounds.X + 10, 1, 0)

                    do -- Functionality
                        Keybind.MouseEnter:Connect(function()
                            keybind.Hover = true
                            Library:tween(UIStroke4, {Color = Library.MenuColors.Accent})
                        end)
                        
                        Keybind.MouseLeave:Connect(function()
                            keybind.Hover = false
                            Library:tween(UIStroke4, {Color = Color3.fromRGB(0, 0, 0)})
                        end)
                        
                        local function _wait_for_input()
                            local getkey
                            getkey = UIS.InputBegan:Connect(function(input)
                                local keyPressed = input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode
                                local disallowedKeys = { Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.UserInputType.MouseMovement }
                                local isDisallowed = false
                                for _, key in ipairs(disallowedKeys) do
                                    if keyPressed == key then
                                        isDisallowed = true
                                        break
                                    end
                                end
                                if isDisallowed then
                                    return
                                end
                                
                                if input.KeyCode == Enum.KeyCode.Backspace then
                                    options.keybinds.key = nil
                                    Library.flags[options.keybinds.flag] = "Unknown"
                                    
                                    KeybindText.Text = "..."
                                    getkey:Disconnect()
                                else
                                    local str = tostring(keyPressed)
                                    local _, Index1 = str:find("%.")
                                    local _, Index2 = str:find("%.", Index1 + 1)
                
                                    if Index2 then
                                        local formattedkey = str:sub(Index2 + 1)
                                        options.keybinds.key = formattedkey
                                        KeybindText.Text = formattedkey
                                        Keybind.Size = UDim2.new(0, KeybindText.TextBounds.X + 10, 1, 0)
                                        options.keybinds.getkey(formattedkey)
                                       if formattedkey == "MouseButton1" then
                                        Library.flags[options.keybinds.flag] = Enum.UserInputType[formattedkey]
                                       elseif formattedkey == "MouseButton2" then
                     
                                        Library.flags[options.keybinds.flag] = Enum.UserInputType[formattedkey]
                                       else
                                       
                                        Library.flags[options.keybinds.flag] = Enum.KeyCode[formattedkey]
                                       end
                                    end
                                    
                                    if keyPressed then getkey:Disconnect() end
                                end
                            end)
                        end
                        
                        UIS.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if keybind.Hover then
                                    KeybindText.Text = "..."
                                    Keybind.Size = UDim2.new(0, KeybindText.TextBounds.X + 10, 1, 0)
                                    _wait_for_input()
                                end
                            end
                        end)                                        
                    end
                end
                ---- Color Pickers ----
                if options.colorpicker.enabled then
                    local colorpicker = Instance.new("Frame")
                    local mid = Instance.new("Frame")
                    local front = Instance.new("Frame")
                    local button2 = Instance.new("TextButton")
                    local colorFrame = Instance.new("Frame")
                    local colorFrame_2 = Instance.new("Frame")
                    local hueframe = Instance.new("Frame")
                    local main = Instance.new("Frame")
                    local hue = Instance.new("ImageLabel")
                    local pickerframe = Instance.new("Frame")
                    local main_2 = Instance.new("Frame")
                    local picker = Instance.new("ImageLabel")
                    local copy = Instance.new("TextButton")

                    colorpicker.Parent = ToggleContainer
                    colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    colorpicker.BorderSizePixel = 3
                    colorpicker.AnchorPoint = Vector2.new(1, 0.5)
                    colorpicker.Size = UDim2.new(0, 15, 0, 10)
                    colorpicker.Position = UDim2.new(1.1, 0, 0.5, 0)

                    do -- Dynamic Position
                        local debounce = false

                        local function updatepos()
                            if not debounce then
                                debounce = true
                                
                                if options.keybinds.enabled then
                                    local margin = ToggleContainer.Keybind.KeybindText
                                    local pos = margin.TextBounds.X + 20
                                    ToggleContainer.Size = UDim2.new(0.5,0,0,12)
                                    colorpicker.Position = UDim2.new(2.03, -pos, 0.5, 0)
                                    Keybind.Position = UDim2.new(2.03, 0, 0.5, 0)
                                else
                                    ToggleContainer.Size = UDim2.new(0.92,0,0,12)
                                    colorpicker.Position = UDim2.new(1.1, 0, 0.5, 0)
                                    Keybind.Position = UDim2.new(1.1, 0, 0.5, 0)
                                end
                                
                                debounce = false
                            end
                        end
                        updatepos()

                        if options.keybinds.enabled then
                            ToggleContainer.Keybind.Changed:Connect(updatepos)
                        end
                    end
                    
                    mid.Name = "mid"
                    mid.Parent = colorpicker
                    mid.BackgroundColor3 = Color3.fromRGB(69, 23, 255)
                    mid.BorderColor3 = Color3.fromRGB(17, 17, 17)
                    mid.BorderSizePixel = 2
                    mid.Size = UDim2.new(1, 0, 1, 0)

                    front.Name = "front"
                    front.Name = "dontchange"
                    front.Parent = mid
                    front.BackgroundColor3 = Library.MenuColors.Background
                    front.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    front.Size = UDim2.new(1, 0, 1, 0)

                    button2.Name = "button2"
                    button2.Parent = front
                    button2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    button2.BackgroundTransparency = 1.000
                    button2.Size = UDim2.new(1, 0, 1, 0)
                    button2.Text = ""
                    button2.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    button2.TextColor3 = Color3.fromRGB(0, 0, 0)
                    button2.TextSize = 11

                    local colorpicker = Instance.new("Frame")
                    colorpicker.Name = "colorpicker"
                    colorpicker.Parent = ToggleContainer
                    colorpicker.BackgroundTransparency = 1
                    colorpicker.BackgroundColor3 = Library.MenuColors.InnerContainer
                    colorpicker.Size = UDim2.new(0, 200, 0, 160)
                    if colorpicker.Parent.Parent.Parent.Parent.Name == "RightContainer" then
                        colorpicker.Position = UDim2.new(0, 300, 0, 0)
                    else
                        colorpicker.Position = UDim2.new(0, -240, 0, -85)
                    end
                    colorpicker.BorderSizePixel = 0
                    colorpicker.ZIndex = 6
                    colorpicker.Visible = false

                    local tframe = Instance.new("Frame")
                    tframe.Name = "tframe"
                    tframe.Parent = colorpicker
                    tframe.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                    tframe.Size = UDim2.new(0, 165, 0.095, 0)
                    tframe.Position = UDim2.new(0, 4, 1, -8) 
                    tframe.ZIndex = 2
                    tframe.BorderSizePixel = 0
                    tframe.Visible = false
                    tframe.BorderColor3 = Color3.fromRGB(0, 0, 0)

                    local main_tframe = Instance.new("ImageLabel")
                    main_tframe.Name = "main_tframe"
                    main_tframe.Parent = tframe
                    main_tframe.Visible = false
                    main_tframe.ImageColor3 = Color3.fromRGB(175, 175, 175)
                    main_tframe.Size = UDim2.new(0, 14, 1, 0)
                    main_tframe.Position = UDim2.new(0, 75, 1, -90) 
                    main_tframe.Image = "rbxassetid://2615689005"
                    main_tframe.ZIndex = 2
                    main_tframe.SizeConstraint = Enum.SizeConstraint.RelativeXX
                    main_tframe.BorderSizePixel = 0
                    main_tframe.Rotation = 90
                    main_tframe.BorderColor3 = Library.MenuColors.BorderColor

                    colorFrame_2.Name = "colorFrame"
                    colorFrame_2.Parent = colorpicker 
                    colorFrame_2.BackgroundColor3 = Color3.fromRGB(12,12,12)
                    colorFrame_2.BorderColor3 = Library.MenuColors.BorderColor
                    colorFrame_2.Size = UDim2.new(1, 0, 1.25, 0)
                    colorFrame_2.BorderSizePixel = 2

                    local UIStroke10 = Instance.new("UIStroke")
                    UIStroke10.Thickness = 1
                    UIStroke10.Color = Color3.fromRGB(0, 0, 0)
                    UIStroke10.LineJoinMode = Enum.LineJoinMode.Round
                    UIStroke10.Parent = colorFrame_2
                    UIStroke10.Name = "UIStrokeColorpicker"

                    local textframe = Instance.new("Frame")
                    textframe.Name = "text1"
                    textframe.Parent = colorFrame_2
                    textframe.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                    textframe.Size = UDim2.new(0, 191, 0, 10)
                    textframe.Position = UDim2.new(0, 5, 0, 170) 
                    textframe.ZIndex = 1
                    textframe.BorderSizePixel = 2
                    textframe.Visible = false
                    textframe.BorderColor3 = Color3.fromRGB(0, 0, 0)

                    local UIStroke1660 = Instance.new("UIStroke")
                    UIStroke1660.Thickness = 1
                    UIStroke1660.Color = Color3.fromRGB(30, 30, 30)
                    UIStroke1660.LineJoinMode = Enum.LineJoinMode.Miter
                    UIStroke1660.Parent = textframe
                    UIStroke1660.Name = "UIStrokeColorpicker"

                    local textframe2 = Instance.new("TextLabel")
                    textframe2.Parent = textframe
                    textframe2.Size = UDim2.new(1, 0, 1, 0)
                    textframe2.BackgroundTransparency = 1
                    textframe2.TextColor3 = Library.MenuColors.ElementText
                    textframe2.TextSize = 11
                    textframe2.RichText = true
                    textframe2.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    textframe2.TextXAlignment = Enum.TextXAlignment.Center
                    textframe2.Name = "colorpickertext"
                    textframe2.Visible = false

                    local buttonframe = Instance.new("Frame")
                    buttonframe.Name = "button1"
                    buttonframe.Parent = colorFrame_2
                    buttonframe.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                    buttonframe.Size = UDim2.new(0, 191, 0, 10)
                    buttonframe.Position = UDim2.new(0, 5, 0, 185) 
                    buttonframe.ZIndex = 1
                    buttonframe.BorderSizePixel = 2
                    buttonframe.Visible = false
                    buttonframe.BorderColor3 = Color3.fromRGB(0, 0, 0)            

                    local UIStroke121660 = Instance.new("UIStroke")
                    UIStroke121660.Thickness = 1
                    UIStroke121660.Color = Color3.fromRGB(30, 30, 30)
                    UIStroke121660.LineJoinMode = Enum.LineJoinMode.Miter
                    UIStroke121660.Parent = buttonframe
                    UIStroke121660.Name = "UIStrokeColorpicker"

                    local copybutton = Instance.new("TextButton")
                    copybutton.Parent = buttonframe
                    copybutton.Size = UDim2.new(0, 90, 0, 10)
                    copybutton.Position = UDim2.new(0, 0, 0, 0) 
                    copybutton.BackgroundTransparency = 1
                    copybutton.TextColor3 = Library.MenuColors.ElementText
                    copybutton.TextTransparency = 0
                    copybutton.TextSize = 11
                    copybutton.BorderSizePixel = 0
                    copybutton.Name = "copycolor"
                    copybutton.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    copybutton.Visible = false
                    copybutton.Modal = true
                    copybutton.Text = "Copy"

                    copybutton.MouseEnter:Connect(function()
						Library:tween(copybutton, {TextColor3 = Library.MenuColors.Accent})
					end)
					
					copybutton.MouseLeave:Connect(function()
						Library:tween(copybutton, {TextColor3 = Library.MenuColors.ElementText})
					end)

                    local pastebutton = Instance.new("TextButton")
                    pastebutton.Parent = buttonframe
                    pastebutton.Size = UDim2.new(0, 90, 0, 10)
                    pastebutton.Position = UDim2.new(0, 102, 0, 0) 
                    pastebutton.BackgroundTransparency = 1
                    pastebutton.TextTransparency = 0
                    pastebutton.BorderSizePixel = 0
                    pastebutton.TextSize = 11
                    pastebutton.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    pastebutton.Name = "pastecolor"
                    pastebutton.Modal = true
                    pastebutton.Text = "Paste"
                    pastebutton.TextColor3 = Library.MenuColors.ElementText
                    pastebutton.Visible = false

                    pastebutton.MouseEnter:Connect(function()
						Library:tween(pastebutton, {TextColor3 = Library.MenuColors.Accent})
					end)
					
					pastebutton.MouseLeave:Connect(function()
						Library:tween(pastebutton, {TextColor3 = Library.MenuColors.ElementText})
					end)

                    local buttonframe2 = Instance.new("TextLabel")
                    buttonframe2.Parent = buttonframe
                    buttonframe2.Size = UDim2.new(1, 0, 1, 0)
                    buttonframe2.BackgroundTransparency = 1
                    buttonframe2.TextColor3 = Color3.fromRGB(255, 255, 255)
                    buttonframe2.TextSize = 11
                    buttonframe2.Text = "/"
                    buttonframe2.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    buttonframe2.TextXAlignment = Enum.TextXAlignment.Center
                    buttonframe2.Name = "colorpickertext"
                    buttonframe2.TextColor3 = Library.MenuColors.ElementText
                    buttonframe2.Visible = false

                    hueframe.Name = "hueframe"
                    hueframe.Parent = colorFrame_2
                    hueframe.BackgroundColor3 = Color3.fromRGB(12,12,12)
                    hueframe.BorderColor3 = Library.MenuColors.BorderColor
                    hueframe.BorderSizePixel = 2
                    hueframe.AnchorPoint = Vector2.new(0, 0.5)
                    hueframe.Position = UDim2.new(0, 5, 0.381, 0)
                    hueframe.Size = UDim2.new(0.27, 110, 0.17, 112)

                    local color_dot = Instance.new("Frame")
                    color_dot.Name = "hue_dot"
                    color_dot.Parent = hueframe
                    color_dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    color_dot.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    color_dot.BorderSizePixel = 1
                    color_dot.Position = UDim2.new(0, 42, 0, 32)
                    color_dot.Size = UDim2.new(0, 2, 0, 2)
                    color_dot.ZIndex = 99999

                    main.Name = "main"
                    main.Parent = hueframe
                    main.BackgroundColor3 = Color3.fromRGB(11,11,11)
                    main.BorderColor3 = Library.MenuColors.BorderColor
                    main.Size = UDim2.new(1, 0, 1, 0)
                    main.ZIndex = 6

                    picker.Name = "picker"
                    picker.Parent = main
                    picker.BackgroundColor3 = options.colorpicker.color
                    picker.BorderColor3 = Library.MenuColors.InnerContainer
                    picker.BorderSizePixel = 0
                    picker.Size = UDim2.new(1, 0, 1, 0)
                    picker.ZIndex = 10
                    picker.Image = "rbxassetid://2615689005"

                    pickerframe.Name = "pickerframe"
                    pickerframe.Parent = colorpicker
                    pickerframe.BackgroundColor3 = Color3.fromRGB(11,11,11)
                    pickerframe.BorderColor3 = Color3.fromRGB(30, 30, 30)
                    pickerframe.BorderSizePixel = 1
                    pickerframe.AnchorPoint = Vector2.new(1, 0.5)
                    pickerframe.Position = UDim2.new(1, -4, 0.534, 0)
                    pickerframe.Size = UDim2.new(0, 22, 1, 4)

                    local selectpicker = Instance.new("Frame")
                    selectpicker.Name = "pickerframe_line"
                    selectpicker.Parent = pickerframe
                    selectpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    selectpicker.Size = UDim2.new(0, 22, 0, 1) 
                    selectpicker.Position = UDim2.new(0, 0, 0, 75)  
                    selectpicker.ZIndex = 8
                    selectpicker.Visible = true
                    selectpicker.BorderSizePixel = 1
                    selectpicker.BorderColor3 = Library.MenuColors.BorderColor

                    main_2.Name = "main"
                    main_2.Parent = pickerframe
                    main_2.BackgroundColor3 = Color3.fromRGB(11,11,11)
                    main_2.BorderColor3 = Library.MenuColors.BorderColor
                    main_2.Size = UDim2.new(1, 0, 1, 0)
                    main_2.ZIndex = 6

                    hue.Name = "hue"
                    hue.Parent = main_2
                    hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    hue.BorderColor3 = Library.MenuColors.BorderColor
                    hue.BorderSizePixel = 0
                    hue.Size = UDim2.new(0, 22, 1, 0)
                    hue.ZIndex = 7
                    hue.Image = "rbxassetid://2615692420"

                    copy.MouseButton1Click:Connect(function()
                        colorFrame.Visible = false
                    end)

                    button2.MouseButton1Click:Connect(function()
                        for i,v in pairs(ScreenGui:GetDescendants()) do
                            if v.Name == "colorpicker" and v.Visible == true and button2.Parent.Parent.Parent.Parent:FindFirstChild("colorpicker") and button2.Parent.Parent.Parent.Parent:FindFirstChild("colorpicker") ~= v then 
                                v.Visible = false
                            end
                        end
                        colorpicker.Visible = not colorpicker.Visible
                        tframe.Visible = not tframe.Visible
                        main_tframe.Visible = not main_tframe.Visible
                        buttonframe.Visible = not buttonframe.Visible
                        textframe.Visible = not textframe.Visible
                        copybutton.Visible = not copybutton.Visible
                        pastebutton.Visible = not pastebutton.Visible
                        buttonframe2.Visible = not buttonframe2.Visible
                        textframe2.Visible = not textframe2.Visible
                        mid.BorderColor3 = Color3.fromRGB(17,17,17)
                    end)

                    button2.MouseEnter:Connect(function()
                        Library:tween(mid, {BorderColor3 = Library.MenuColors.Accent})
                    end)
                    
                    button2.MouseLeave:Connect(function()
                        Library:tween(mid, {BorderColor3 = Color3.fromRGB(17,17,17)})
                    end)  

                    local function updateValue(value, fakevalue)
                        if typeof(value) == "table" then value = fakevalue end
                        options.colorpicker.color = value
                        front.BackgroundColor3 = value
                        Library.flags[options.colorpicker.flag] = value
                    
                        local r, g, b = value.r * 255, value.g * 255, value.b * 255
                        textframe2.TextColor3 = value
                        textframe2.Text = string.format("#%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))                        
                        options.colorpicker.getcolor(value)
                    end
                    
                    copybutton.MouseButton1Click:Connect(function()
                        local value = options.colorpicker.color 
                        local r, g, b = value.r * 255, value.g * 255, value.b * 255
                        local hexValue = string.format("#%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))
                        setclipboard(hexValue)
                    end)

                    local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
                    local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
                    local heartbeat = runService.Heartbeat
                    local pickerX,pickerY,hueY = 0,0,0
                    local oldpercentX,oldpercentY = 0,0

                    hue.MouseEnter:Connect(function()
                    local input = hue.InputBegan:connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                                while heartbeat:wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                    local percent = (hueY-hue.AbsolutePosition.Y-36)/hue.AbsoluteSize.Y
                                    local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
                                    local startC = colors[math.floor(num)]
                                    local endC = colors[math.ceil(num)]
                                    local color = white:lerp(picker.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
                                    picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
                                    selectpicker.Position = UDim2.new(0, 0, 0, 0 + selectpicker.Parent.AbsoluteSize.Y * percent)
                                    updateValue(color)
                                end
                            end
                        end) 
                            local leave
                            leave = hue.MouseLeave:connect(function()
                            input:disconnect()
                            leave:disconnect()
                        end)
                    end)

                    local isDragging = false
                    UIS.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = true end
                    end)
                    UIS.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
                    end)

                    picker.MouseEnter:Connect(function()
                        local input = picker.InputBegan:connect(function(key)
                            if key.UserInputType == Enum.UserInputType.MouseButton1 then
                                while heartbeat:wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                    local xPercent = (pickerX - picker.AbsolutePosition.X) / picker.AbsoluteSize.X
                                    local yPercent = (pickerY - picker.AbsolutePosition.Y - 36) / picker.AbsoluteSize.Y
                                    local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
                                    updateValue(color)
                                    oldpercentX, oldpercentY = xPercent, yPercent
                                end
                            end
                        end)
                        local leave
                        leave = picker.MouseLeave:connect(function()
                            input:disconnect()
                            leave:disconnect()
                        end)
                    end)

                    UIS.InputChanged:Connect(function(input)
                        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local offsetX = pickerX - picker.AbsolutePosition.X
                            local offsetY = pickerY - picker.AbsolutePosition.Y - 35
                            color_dot.Position = UDim2.new(0, offsetX, 0, offsetY)
                        end
                    end)

                    hue.MouseMoved:connect(function(_, y)
                        hueY = y
                    end)

                    picker.MouseMoved:connect(function(x, y)
                        pickerX,pickerY = x,y
                    end)

                    options.colorpicker.color = options.colorpicker.color
                    updateValue(options.colorpicker.color or Color3.new(1,1,1)) 
                end

                return section
            end

            function section:AddSlider(options)
                options = Library:validate({
                    name = "Example Toggle",
                    default = 50,
                    suffix = "%",
                    risky = false,
                    changeby = 5, 
                    min = 0,
                    max = 100,
                    callback = function(value) end
                }, options or {})

                local slider = {
                    MouseDown = false,
                    Hover = false,
                    Connection = nil
                }

                local minus = {
                    Hover = false
                }

                local plus = {
                    Hover = false
                }

                options.value = 0
                if options.min then
                    if options.default < options.min then
                        options.default = options.min
                    end
                end
                if not options.flag and options.name then options.flag = options.name end
               
                if getgenv().TabsExist then
                    elementParent = getgenv().TabInnerContainer
                else
                    elementParent = ElementContainer
                end
                getgenv().elementparent = elementParent

                local SliderContainer = Library:Create("Frame", {
                    Parent = getgenv().elementparent,
                    Size = UDim2.new(1, 0, 0, 16),
                    BackgroundTransparency = 1,
                    Name = "SliderContainer"
                })
                
                local SliderTitle = Library:Create("TextLabel", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -4, 1, -7),
                    Position = UDim2.new(0, 15, 0, -3),
                    BackgroundTransparency = 1,
                    TextColor3 = Library.MenuColors.ElementText,
                    TextSize = 11,
                    Text = options.name,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Name = "SliderTitle"
                })
                
                if options.risky == true then
                    SliderTitle.TextColor3 = Library.MenuColors.RiskyText
                else
                    SliderTitle.TextColor3 = Library.MenuColors.ElementText
                end

                local SliderBack = Library:Create("Frame", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -50, 0, 4),
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 15, 1, -2),
                    BackgroundColor3 = Color3.fromRGB(17, 17, 17),
                    Name = "Slider",
                    BorderColor3 = Library.MenuColors.BorderColor,
                    BorderSizePixel = 2
                })

                local UIStroke3 = Library:Create("UIStroke", {
                    Thickness = 1,
                    Color = Color3.fromRGB(0, 0, 0),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = SliderBack,
                    Name = "UIStrokeBackSlider"
                })

                local Slider = Library:Create("Frame", {
                    Parent = SliderBack,
                    Size = UDim2.new(1, -80, 1, 0),
                    BackgroundColor3 = Library.MenuColors.Accent,
                    Name = "Slider",
                    ZIndex = 2,
                    BorderSizePixel = 0
                })                

                local SliderValue = Library:Create("TextLabel", {
                    Size = UDim2.new(0, 10, 0, 10),
                    Parent = Slider,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Position = UDim2.new(1, -10, 0, 5),
                    BackgroundTransparency = 1,
                    TextColor3 = Library.MenuColors.ElementText,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Bold),
                    Text = options.value,
                    TextSize = 9,
                    Name = options.name
                })                

                local ValueOutline = Library:Create("UIStroke", {
                    Thickness = 1,
                    Color = Color3.new(0, 0, 0),
                    Parent = SliderValue
                })                
                
                local buttoncontainer1 = Library:Create("Frame", {
                    Parent = SliderBack,
                    Size = UDim2.new(0, 7, 0, 7),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, -19, 0.5, 1),
                    BackgroundTransparency = 1
                })                

                local buttoncontainer2 = Library:Create("Frame", {
                    Parent = SliderBack,
                    Size = UDim2.new(0, 7, 0, 7),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 15, 0.5, 1),
                    BackgroundTransparency = 1
                })                

                local minusbutton = Library:Create("TextLabel", {
                    Parent = buttoncontainer1,
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 4, 0.5, 0),
                    Text = "-",
                    TextColor3 = Library.MenuColors.ElementText,
                    TextSize = 9,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                })                

                local plusbutton = Library:Create("TextLabel", {
                    Parent = buttoncontainer2,
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 1, 0.5, 0),
                    Text = "+",
                    TextColor3 = Library.MenuColors.ElementText,
                    TextSize = 9,
                    FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular),
                })                

                -- Methods
                function slider:SetValue(v)
                    if v == nil then
                        local output = (mouse.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X
                  
                        local slidervalue = math.clamp(math.round(output * (options.max - options.min) + options.min), options.min, options.max)
                      
                        SliderValue.Text = slidervalue.. (options.suffix or "")
                        Slider.Size = UDim2.fromScale((slidervalue - options.min) / (options.max - options.min), 1)
                      
                    else
                        SliderValue.Text = v.. (options.suffix or "")
                    end
                    options.callback(slider:GetValue())
                end
                function SetValue(v)
                   
                        local output = v / 100
                       
                        local slidervalue = math.clamp(math.round(output * (options.max - options.min) + options.min), options.min, options.max)
                   

                        SliderValue.Text = slidervalue.. (options.suffix or "")
                        Slider.Size = UDim2.fromScale((slidervalue - options.min) / (options.max - options.min), 1)
                      
                end
                
                function slider:GetValue()
                    local value = tonumber(SliderValue.Text)
                    if options.suffix then
                        local suffixLength = string.len(options.suffix)
         
                        Library.flags[options.flag] = {tonumber(string.sub(SliderValue.Text, 1, -suffixLength - 1)),changeState = SetValue}
                        return tonumber(string.sub(SliderValue.Text, 1, -suffixLength - 1))
                    else
                    
                        Library.flags[options.flag] = {tonumber(string.sub(SliderValue.Text, 1, -suffixLength - 1)), changeState = SetValue}
                        return value
                    end
                end

                Slider.Size = UDim2.fromScale((options.default - options.min) / (options.max - options.min), 1)
                SliderValue.Text = options.default.. (options.suffix or "")

				-- Functionality
				do
					SliderBack.MouseEnter:Connect(function()
						slider.Hover = true
						Library:tween(SliderValue, {TextColor3 = Library.MenuColors.Accent})
					end)
					
					SliderBack.MouseLeave:Connect(function()
						slider.Hover = false
						Library:tween(SliderValue, {TextColor3 = Library.MenuColors.ElementText})
					end)
					
					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and slider.Hover then
							slider.MouseDown = true
							-- slider value
							if not slider.Connection then
								slider.Connection = runService.RenderStepped:Connect(function()
									slider:SetValue()
                                    if not slider.Hover then
                                        Library:tween(SliderValue, {TextColor3 = Library.MenuColors.Accent})
                                    end
								end)
							end
						end
					end)
					
					UIS.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							slider.MouseDown = false
							slider.Hover = false
							-- Stop slider value
							if slider.Connection then
								slider.Connection:Disconnect()
                                if not slider.Hover then
                                    Library:tween(SliderValue, {TextColor3 = Color3.fromRGB(150, 150, 150)})
                                end
							end
							slider.Connection = nil
						end
					end)

                    buttoncontainer1.MouseEnter:Connect(function()
                        minus.Hover = true
					end)
					
					buttoncontainer1.MouseLeave:Connect(function()
                        minus.Hover = false
					end)

                    buttoncontainer2.MouseEnter:Connect(function()
                        plus.Hover = true
					end)
					
					buttoncontainer2.MouseLeave:Connect(function()
                        plus.Hover = false
					end)

                    UIS.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and minus.Hover then
                            if slider:GetValue() > options.min then
                                newvalue = math.round(slider:GetValue() - options.changeby)
                                if newvalue > options.min - options.changeby then
                                    slider:SetValue(newvalue)
                                end
                                Slider.Size = UDim2.fromScale((slider:GetValue() - options.min) / (options.max - options.min), 1)
                            end
                        end
                    end)

                    UIS.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and plus.Hover then
                            if slider:GetValue() < options.max then
                                newvalue = math.round(slider:GetValue() + options.changeby)
                                if newvalue < options.max + options.changeby then
                                    slider:SetValue(newvalue)
                                end
                                Slider.Size = UDim2.fromScale((slider:GetValue() - options.min) / (options.max - options.min), 1)
                            end
                        end
                    end)
				end

                options.callback(slider:GetValue())
                return section
            end

            function section:AddDropdown(options)
                options = Library:validate({
                    name = "Example Dropdown",
                    list = {"Example 1", "Example 2", "Example 3", "Example 4"},
                    min = 1,
                    max = 3,
                    default = 1,
                    callback = function(active) end
                }, options or {})
                
                options.default = options.default or 1

                local dropdown = {
                    Hover = false,
                    active = {options.list[options.default]},
                    state = false
                }
            
                if not options.flag and options.name then options.flag = options.name.."dr" end

                if getgenv().TabsExist then
                    elementParent = getgenv().TabInnerContainer
                else
                    elementParent = ElementContainer
                end
                getgenv().elementparent = elementParent

                local DropdownContainer = Instance.new("Frame")
                DropdownContainer.Parent = getgenv().elementparent
                DropdownContainer.Size = UDim2.new(1, 0, 0, 30)
                DropdownContainer.Name = options.name
                DropdownContainer.BorderSizePixel = 0
                DropdownContainer.BackgroundTransparency = 1

                local DropdownImage = Instance.new("ImageLabel")
                DropdownImage.Name = "Triangle"
                DropdownImage.Parent = DropdownContainer
                DropdownImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                DropdownImage.BackgroundTransparency = 1.000
                DropdownImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownImage.BorderSizePixel = 0
                DropdownImage.AnchorPoint = Vector2.new(1, 0.5)
                DropdownImage.Position = UDim2.new(1, -34, 0.5, 8)
                DropdownImage.Size = UDim2.new(0, 7, 0, 6)
                DropdownImage.Image = "rbxassetid://8532000591"
                DropdownImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
                local DropdownText = Instance.new("TextLabel")
                DropdownText.Size = UDim2.new(1,0,1,-20)
                DropdownText.Parent = DropdownContainer
                DropdownText.Position = UDim2.new(0, 15, 0, -2)
                DropdownText.BackgroundTransparency = 1
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                DropdownText.Text = options.name
                DropdownText.TextColor3 = Library.MenuColors.ElementText
                DropdownText.TextSize = 11
                DropdownText.Name = options.name
            
                local ActiveChoice = Instance.new("Frame")
                ActiveChoice.Size = UDim2.new(1, -50, 1 , -13)
                ActiveChoice.AnchorPoint = Vector2.new(0.5, 1)
                ActiveChoice.Position = UDim2.new(0.5, -10, 1, 0)
                ActiveChoice.Parent = DropdownContainer
                ActiveChoice.BorderSizePixel = 1
                ActiveChoice.BorderColor3 = Library.MenuColors.BorderColor
                ActiveChoice.Name = "ActiveChoice"

                local UIGradient2 = Library:Create("UIGradient", {
                    Parent = ActiveChoice,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                    },
                    Rotation = 90,
                })
            
                local ActiveText = Instance.new("TextLabel")
                ActiveText.Size = UDim2.new(1,0,0,0)
                ActiveText.Parent = ActiveChoice
                ActiveText.Position = UDim2.new(0.5, 0, 0.5, 0)
                ActiveText.AnchorPoint = Vector2.new(0.5, 0.5)
                ActiveText.BackgroundTransparency = 1
                ActiveText.TextXAlignment = Enum.TextXAlignment.Center
                ActiveText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                ActiveText.Text = "Active"
                ActiveText.TextColor3 = Library.MenuColors.ElementText
                ActiveText.TextSize = 11
                ActiveText.Name = "DropdownText"
                ActiveText.ZIndex = 4

                local ChoiceHolder = Instance.new("Frame")
                ChoiceHolder.Size = UDim2.new(1,0,1,5)
                ChoiceHolder.Position = UDim2.new(0.5, 0, 0, 17)
                ChoiceHolder.Parent = ActiveChoice
                ChoiceHolder.AnchorPoint = Vector2.new(0.5,0)
                ChoiceHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ChoiceHolder.Visible = false
                ChoiceHolder.BorderSizePixel = 0
                ChoiceHolder.ZIndex = 4
            
                local ChoiceLayout = Instance.new("UIListLayout")
                ChoiceLayout.Parent = ChoiceHolder
                ChoiceLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ChoiceLayout.FillDirection = Enum.FillDirection.Vertical
                ChoiceLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                ChoiceLayout.Padding = UDim.new(0, 0)
                ChoiceLayout.Name = "ChoiceLayout"
            
                function dropdown:AddChoice(name)
                    local choice = {
                        Name = name,
                        Hover = false,
                        state = false
                    }
            
                    if dropdown.active == choice.Name then
                        choice.state = true
                    end
            
                    ChoiceHolder.Size = UDim2.new(1,0,0,ChoiceHolder.Size.Y.Offset)
            
                    local Choice = Instance.new("Frame")
                    Choice.Size = UDim2.new(1,-2,0,15)
                    Choice.Parent = ChoiceHolder
                    Choice.AnchorPoint = Vector2.new(0.5,0)
                    Choice.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
                    Choice.BorderSizePixel = 0
                    Choice.ZIndex = 5
            
                    local ChoiceText = Instance.new("TextLabel")
                    ChoiceText.Size = UDim2.new(1,0,1,0)
                    ChoiceText.Parent = Choice
                    ChoiceText.AnchorPoint = Vector2.new(0.5,0)
                    ChoiceText.Position = UDim2.new(0.5, 0, 0, 0)
                    ChoiceText.BackgroundTransparency = 1
                    ChoiceText.FontFace = Font.fromId(12187362578, Enum.FontWeight.Regular)
                    ChoiceText.Text = name
                    ChoiceText.TextColor3 = Library.MenuColors.ElementText
                    ChoiceText.TextSize = 10
                    ChoiceText.Name = name
                    ChoiceText.ZIndex = 6
            
                    for i, name in ipairs(dropdown.active) do 
                        if name == choice.Name then
                            choice.state = true
                            ActiveText.Text = table.concat(dropdown.active, ", ")
                            Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.Accent})
                            Library.flags[options.flag] = ActiveText.Text
                            options.callback(ActiveText.Text)
                            break
                        end
                    end
            
                    -- Choice Functionality
                    do
                        Choice.MouseEnter:Connect(function()
                            if choice.state ~= true then
                                Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.Accent})
                            end
                            choice.Hover = true
                        end)
                    
                        Choice.MouseLeave:Connect(function()
                            if choice.state ~= true then
                                Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.ElementText})
                            end
                            choice.Hover = false
                        end)
            
                        UIS.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if choice.Hover == true then
                                    local count = 0
                                    for _, v in ipairs(dropdown.active) do
                                        count = count + 1
                                    end
                                    if choice.state == false and count < options.max then
                                        choice.state = not choice.state
                                        if choice.state == true then
                                            Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.Accent})
                                            table.insert(dropdown.active, choice.Name)
                                            ActiveText.Text = table.concat(dropdown.active, ", ")
                                            Library.flags[options.flag] = ActiveText.Text
                                        
                                            options.callback(ActiveText.Text)
                                        else
                                            Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.ElementText})
                                            for i, name in ipairs(dropdown.active) do
                                                if name == choice.Name then
                                                    table.remove(dropdown.active, i)
                                                    ActiveText.Text = table.concat(dropdown.active, ", ")
                                                    Library.flags[options.flag] = ActiveText.Text
                                                 
                                                    options.callback(ActiveText.Text)
                                                    break
                                                end
                                            end
                                        end
                                    elseif choice.state == true and count > options.min then
                                        choice.state = not choice.state
                                        Library:tween(ChoiceText, {TextColor3 = Library.MenuColors.ElementText})
                                        for i, name in ipairs(dropdown.active) do
                                            if name == choice.Name then
                                                table.remove(dropdown.active, i)
                                                ActiveText.Text = table.concat(dropdown.active, ", ")
                                                Library.flags[options.flag] = ActiveText.Text
                                            
                                                options.callback(ActiveText.Text)
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end -- dropdown:AddChoice

                for _,v in pairs(options.list) do
                    dropdown:AddChoice(v)
                end

                do
					local endsize = 0
					for _, choice in ipairs(ChoiceHolder:GetChildren()) do
						if choice:IsA("Frame") then
							endsize = endsize + choice.AbsoluteSize.Y
						end
					end
                    ChoiceHolder.Size = UDim2.new(1, 2, 0, endsize + 1)
                end

				-- Dropdown Functionality
				do
					ActiveChoice.MouseEnter:Connect(function()
						dropdown.Hover = true
						if dropdown.state ~= true then
							Library:tween(ActiveText, {TextColor3 = Library.MenuColors.Accent})
						end
					end)
				
					ActiveChoice.MouseLeave:Connect(function()
						dropdown.Hover = false
						if dropdown.state ~= true then
							Library:tween(ActiveText, {TextColor3 = Library.MenuColors.ElementText})
						end
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if dropdown.Hover then
								dropdown.state = not dropdown.state
								ChoiceHolder.Visible = dropdown.state
							end
						end
					end)

					if dropdown.state == true then
						Library:tween(ActiveText, {TextColor3 = Library.MenuColors.Accent})
					else
						Library:tween(ActiveText, {TextColor3 = Library.MenuColors.ElementText})
					end
				end

                return section
            end

            return section
        end
        return tab
    end

    do -- Mouse Cursor
        local cursor = Instance.new("ImageLabel")
        cursor.Size = UDim2.new(0, 18, 0, 18)
        cursor.BackgroundTransparency = 1
        cursor.ImageColor3 = Library.MenuColors.Accent
        cursor.Image = "rbxassetid://17404277477"
        cursor.Parent = ScreenGui
        cursor.ZIndex = 10
        local function followMouse()
            local mouse = game.Players.LocalPlayer:GetMouse()
            cursor.Position = UDim2.new(0, mouse.X -6, 0, mouse.Y - 2)
        end
        game:GetService("RunService").RenderStepped:Connect(followMouse)
    end

    do -- Drag GUI

        local container = {
            Hover = false
        }

        -- This prevents it from dragging on elements like sliders and colorpickers.
        InnerContainer.MouseEnter:Connect(function()
            container.Hover = true
        end)
    
        InnerContainer.MouseLeave:Connect(function()
            container.Hover = false
        end)

        local dragStart, startPos, dragging
        Background.InputBegan:Connect(function(input)
            if container.Hover ~= true then
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStart = input.Position
                    startPos = Background.Position
                end
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if container.Hover ~= true then
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = input.Position - dragStart
                    local newX = startPos.X.Offset + delta.X
                    local newY = startPos.Y.Offset + delta.Y
                    Background.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                end
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end

    -- Open / Close
    UIS.MouseIconEnabled = false
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Library.Ui_Bind then
            ScreenGui.Enabled = not ScreenGui.Enabled
            UIS.MouseIconEnabled = not ScreenGui.Enabled
        end
    end)

    -- Destroy
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Delete then
            ScreenGui:Destroy()
        end
    end)

    return menu
end

function Create(Class, Properties)
    local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
    for Property, Value in pairs(Properties) do
        _Instance[Property] = Value
    end
    return _Instance
end
