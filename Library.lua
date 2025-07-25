--[[
    Library Made for both of us ofcourse
    Developed by @oz
    Modified by @lksiwjas

    I modified a bit to this library
    also fuckass if u use this your a retard person

    #bisaya on top!

    -- #1 Nigger Lover
]]--


local Library = {}

local cloneref = (cloneref or clone_ref or clonereference or clone_reference or function(Instance)
    local success, result = pcall(function()
        return getreg()
    end)
    if success and type(result) == "function" then
        local InstanceList
        repeat task.wait() until #getreg() > 0
        for b, c in pairs(getreg()) do
            if type(c) == "table" and #c then
                if rawget(c, "__mode") == "kvs" then
                    for d, e in pairs(c) do
                        if e == a then
                            InstanceList = c
                        break
                    end
                end
            end
        end
    end
    local f = {}
    function f.invalidate(g)
        if not InstanceList then
            return
        end
        for b, c in pairs(InstanceList) do
            if c == g then
                InstanceList[b] = nil
                return g
            end
        end
    end
    f.invalidate(Instance)
    else
        return Instance
    end
end)

-- // References -- \\
local Players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local TweenService = cloneref(game:GetService("TweenService"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // This function is used to protect the main UI so it doesn't get detected by the game's Anti-Cheat. \\ --
local ProtectedFolder = Instance.new("Folder")
ProtectedFolder.Parent = CoreGui
ProtectedFolder.Name = "RobloxGui"

local function Protect(Instance)
    if Instance and Instance:IsA("GuiObject") then
		local HiddenUI = gethui or gethiddenui or get_hidden_ui or get_hui or get_h_ui
        Instance.Parent = HiddenUI or cloneref(ProtectedFolder)
        Instance.Name = HttpService:GenerateGUID(false)
    else
        if Instance then
            Instance.Parent = cloneref(ProtectedFolder)
            Instance.Name = HttpService:GenerateGUID(false)
        end
    end
end

-- // Randon name generator \\ --
local NameCache = {}

local function GenerateName()
	local Name = NameCache[#NameCache] or (string.char(math.random(65, 90)) .. string.char(math.random(97, 122)) .. tostring(math.random(100, 999)))
	table.insert(NameCache, Name)
	return Name
end

--// Basic functions \\ --
function Library:Validate(defaults, options)
	for i, v in defaults do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function Library:tween(Object, Goal, Time, EaseStyle, EaseDirection, Callback)
	local tweenInfo = nil
	tweenInfo = TweenInfo.new(
		Time or 0.15,
		EaseStyle or Enum.EasingStyle.Back,
		EaseDirection or Enum.EasingDirection.Out
	)

	local Tween = TweenService:Create(Object, tweenInfo, Goal)
	Tween.Completed:Connect(Callback or function() end)
	Tween:Play()
end

local FetchIcons, Icons = pcall(function()
		return loadstring(
			game:HttpGet("https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua")
		)()
	end)

function Library:GetIcon(IconName: string)
	if not FetchIcons then
		return
	end
	local Success, Icon = pcall(Icons.GetAsset, IconName)
	if not Success then
		return
	end
	return Icon
end

function Library:ApplyIcon(obj,iconName)
	local icon = Library:GetIcon(iconName)
	if icon == nil then
		return 
	end
	obj.Image = icon.Url
	obj.ImageRectSize = icon.ImageRectSize
	obj.ImageRectOffset = icon.ImageRectOffset
end

--// Window functions \\ --
function Library:CreateWindow(opt)
	opt = Library:Validate({
		Name = "Library Library",
		Icon = "user",
		ToggleKey = Enum.KeyCode.RightShift,
		Discord = {
			Enabled = false,
			Invite = "noinvitelink",
		},
	}, opt or {})
	
	local Agreement

	local DropdownZIndex= 1000000
	
	if opt.Discord.Enabled then
		local httprequest = httprequest or http_request or (syn and syn.request)
		if httprequest then
			task.spawn(function()
				httprequest({
					Url = 'http://127.0.0.1:6463/rpc?v=1',
					Method = 'POST',
					Headers = {
						['Content-Type'] = 'application/json',
						Origin = 'https://discord.com'
					},
					Body = game:GetService("HttpService"):JSONEncode({
						cmd = 'INVITE_BROWSER',
						nonce = HttpService:GenerateGUID(false),
						args = {code = opt.Discord.Invite}
					})
				})
			end)
		end
	end
	
	local winT = {
		Keybind = nil,
		CurrentTab = nil,
		isMinimised = false,
		SettingsEnabled = false
	}

	if not isfolder("Library") then
		makefolder("Library")
		if not isfolder("Library/" .. opt.Name) then
			makefolder("Library/" .. opt.Name)
		end
	end

	if not isfolder("Library/" .. opt.Name .. "/AlrMade") then
		winT.ShouldShowAgreement = true
	else
		winT.ShouldShowAgreement = false
	end

	Agreement = winT.ShouldShowAgreement

	local ObjectToVisible = {}

	local function AddToToggleAll(obj)
		obj.Visible = false
		table.insert(ObjectToVisible,obj)
	end

	-- // General Configurationbl \\ --
	do
	winT.Keybind = opt.ToggleKey
	
	winT.isTouch = UserInputService.TouchEnabled
	if winT.isTouch then
		winT.MainWindowSize = UDim2.new(0, 500, 0, 300)
	else
		winT.MainWindowSize = UDim2.new(0, 700, 0, 440)
		
	end
	end
	
	function winT:SetToggleKey(key)
		winT.Keybind = key
	end 
	
	-- // Create UI \\ --
	do
		winT["1"] = Instance.new("ScreenGui");Protect(winT["1"])
		winT["1"].Name = GenerateName()
		winT["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		winT["1"].ResetOnSpawn = false
		winT["1"].IgnoreGuiInset = true

		-- StarterGui.Gui.Window
		winT["2"] = Instance.new("Frame", winT["1"]);
		winT["2"]["BorderSizePixel"] = 0;
		winT["2"]["BackgroundColor3"] = Color3.fromRGB(21, 21, 21);
		winT["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		if winT.ShouldShowAgreement then
			winT["2"]["Size"] =  UDim2.new(0,400,0,0);
		else
			winT["2"]["Size"] =  UDim2.new(0,winT.MainWindowSize.X.Offset,0,0);
		end
		winT["2"]["Position"] = UDim2.new(0.49943, 0, 0.5, 0);
		winT["2"]["Name"] = [[Window]];
		winT["2"]["BackgroundTransparency"] = 0.1;
		winT["2"].ClipsDescendants = true

		-- StarterGui.Gui.Window.UICorner
		winT["72"] = Instance.new("UICorner", winT["2"]);
		winT["72"].CornerRadius = UDim.new(0, 16);
		
		-- StarterGui.Gui.Window.UIGradient
		winT["93"] = Instance.new("UIGradient", winT["2"]);
		winT["93"].Rotation = 90;
		winT["93"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(21, 21, 21)), ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 0, 0))};

		if Agreement then
			do
			local InfoUi = {}
			
				-- StarterGui.Oz.ScreenGui.Info
				InfoUi["2"] = Instance.new("Frame", winT["2"]);
				InfoUi["2"]["BorderSizePixel"] = 0;
				InfoUi["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				InfoUi["2"]["Size"] = UDim2.new(1, 0, 1, 0);
				InfoUi["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				InfoUi["2"]["Name"] = [[Info]];
				InfoUi["2"]["BackgroundTransparency"] = 1;


				-- StarterGui.Oz.ScreenGui.Info.Topbar
				InfoUi["3"] = Instance.new("Frame", InfoUi["2"]);
				InfoUi["3"]["BorderSizePixel"] = 0;
				InfoUi["3"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
				InfoUi["3"]["Size"] = UDim2.new(1, 0, 0, 40);
				InfoUi["3"]["Name"] = [[Topbar]];


				-- StarterGui.Oz.ScreenGui.Info.Topbar.UIGradient
				InfoUi["4"] = Instance.new("UIGradient", InfoUi["3"]);
				InfoUi["4"]["Rotation"] = 90;
				InfoUi["4"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(41, 41, 41)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 11, 11))};


				-- StarterGui.Oz.ScreenGui.Info.Topbar.UICorner
				InfoUi["5"] = Instance.new("UICorner", InfoUi["3"]);
				InfoUi["5"]["CornerRadius"] = UDim.new(0, 16);


				-- StarterGui.Oz.ScreenGui.Info.Topbar.Warning
				InfoUi["6"] = Instance.new("TextLabel", InfoUi["3"]);
				InfoUi["6"]["TextSize"] = 20;
				InfoUi["6"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
				InfoUi["6"]["TextColor3"] = Color3.fromRGB(221, 221, 221);
				InfoUi["6"]["BackgroundTransparency"] = 1;
				InfoUi["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				InfoUi["6"]["Size"] = UDim2.new(1, -130, 1, 0);
				InfoUi["6"]["Text"] = [[Warning]];
				InfoUi["6"]["Name"] = [[Warning]];
				InfoUi["6"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


				-- StarterGui.Oz.ScreenGui.Info.Topbar.Warning.UICorner
				InfoUi["7"] = Instance.new("UICorner", InfoUi["6"]);
				InfoUi["7"]["CornerRadius"] = UDim.new(0, 12);


				-- StarterGui.Oz.ScreenGui.Info.Topbar.Exit
				InfoUi["8"] = Instance.new("ImageButton", InfoUi["3"]);
				InfoUi["8"]["BorderSizePixel"] = 0;
				InfoUi["8"]["AutoButtonColor"] = false;
				InfoUi["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				InfoUi["8"]["ImageColor3"] = Color3.fromRGB(201, 201, 201);
				InfoUi["8"]["AnchorPoint"] = Vector2.new(1, 0.5);
				InfoUi["8"]["Image"] = [[rbxassetid://10747384394]];
				InfoUi["8"]["Size"] = UDim2.new(0, 26, 0, 26);
				InfoUi["8"]["BackgroundTransparency"] = 1;
				InfoUi["8"]["Name"] = [[Exit]];
				InfoUi["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				InfoUi["8"]["Position"] = UDim2.new(1, -9, 0.5, 0);

				InfoUi["8"].MouseButton1Click:Connect(function()
					Library:tween(winT["2"],{Size = UDim2.new(0,400,0,0)}, 0.4,Enum.EasingStyle.Cubic, Enum.EasingDirection.Out,function()
					winT["1"]:Destroy()
					makefolder("Library/" .. opt.Name .. "/AlrMade")
					return
					end)
				end)
				
				-- StarterGui.Oz.ScreenGui.Info.Text
				InfoUi["9"] = Instance.new("TextLabel", InfoUi["2"]);
				InfoUi["9"]["TextWrapped"] = true;
				InfoUi["9"]["TextSize"] = 20;
				InfoUi["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				InfoUi["9"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				InfoUi["9"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
				InfoUi["9"]["TextColor3"] = Color3.fromRGB(221, 221, 221);
				InfoUi["9"]["BackgroundTransparency"] = 1;
				InfoUi["9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				InfoUi["9"]["Size"] = UDim2.new(1, 0, 1.10667, -100);
				InfoUi["9"]["Text"] = [[The developer is not responsible for any account bans that may occur from using this service. Use at your own risk.]];
				InfoUi["9"]["Name"] = [[Text]];
				InfoUi["9"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


				-- StarterGui.Oz.ScreenGui.Info.Text.UICorner
				InfoUi["a"] = Instance.new("UICorner", InfoUi["9"]);
				InfoUi["a"]["CornerRadius"] = UDim.new(0, 12);


				-- StarterGui.Oz.ScreenGui.Info.Text.UIPadding
				InfoUi["b"] = Instance.new("UIPadding", InfoUi["9"]);
				InfoUi["b"]["PaddingTop"] = UDim.new(0, 2);
				InfoUi["b"]["PaddingRight"] = UDim.new(0, 25);
				InfoUi["b"]["PaddingLeft"] = UDim.new(0, 25);


				-- StarterGui.Oz.ScreenGui.Info.Agree
				InfoUi["c"] = Instance.new("TextButton", InfoUi["2"]);
				InfoUi["c"]["BorderSizePixel"] = 0;
				InfoUi["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				InfoUi["c"]["AutoButtonColor"] = false;
				InfoUi["c"]["TextSize"] = 16;
				InfoUi["c"]["BackgroundColor3"] = Color3.fromRGB(58, 58, 58);
				InfoUi["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				InfoUi["c"]["ZIndex"] = 54;
				InfoUi["c"]["AnchorPoint"] = Vector2.new(0.5, 1);
				InfoUi["c"]["Size"] = UDim2.new(0, 90, 0, 30);
				InfoUi["c"]["BackgroundTransparency"] = 0.55;
				InfoUi["c"]["Name"] = [[Agree]];
				InfoUi["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				InfoUi["c"]["Text"] = [[I Agree]];
				InfoUi["c"]["Position"] = UDim2.new(0.5, 0, 1, -7);

				InfoUi["c"].MouseButton1Click:Connect(function()
					for _, v in ipairs(InfoUi["2"]:GetDescendants()) do
						if v:IsA("TextLabel") or v:IsA("TextButton") then
							Library:tween(v, {TextTransparency = 1}, 0.35, Enum.EasingStyle.Exponential)
							Library:tween(v, {Transparency = 1}, 0.35, Enum.EasingStyle.Exponential)
						elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
							Library:tween(v, {ImageTransparency = 1}, 0.35, Enum.EasingStyle.Exponential)
						end

						if v:IsA("Frame") then
							Library:tween(v, {BackgroundTransparency = 1}, 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, function()
								task.spawn(function()
									task.wait(2)
									--InfoUi["2"]:Destroy()
								end)
							end)
						elseif v:IsA("UIStroke") then
							Library:tween(v, {Transparency = 1}, 0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
						end
					end

					winT.ShouldShowAgreement = false
				end)
				-- StarterGui.Oz.ScreenGui.Info.Agree.UICorner
				InfoUi["d"] = Instance.new("UICorner", InfoUi["c"]);
				InfoUi["d"]["CornerRadius"] = UDim.new(0, 10);


				-- StarterGui.Oz.ScreenGui.Info.Agree.UIStroke
				InfoUi["e"] = Instance.new("UIStroke", InfoUi["c"]);
				InfoUi["e"]["Transparency"] = 0.8;
				InfoUi["e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
				InfoUi["e"]["Thickness"] = 1.5;
				InfoUi["e"]["Color"] = Color3.fromRGB(181, 181, 181);

			end
			
			task.wait(1)
			Library:tween(winT["2"],{Size = UDim2.new(0,400,0,180)}, 0.4,Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

			repeat task.wait(0.1) until winT.ShouldShowAgreement == false	
		end

		-- StarterGui.Gui.Window.Topbar
		winT["3"] = Instance.new("Frame", winT["2"]);
		winT["3"].BorderSizePixel = 0;
		winT["3"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
		winT["3"].Size = UDim2.new(1, 0, 0, 50);
		winT["3"].Name = [[Topbar]];
		if Agreement then
			AddToToggleAll(winT["3"])
		end

		-- StarterGui.Gui.Window.Topbar.UIGradient
		winT["4"] = Instance.new("UIGradient", winT["3"]);
		winT["4"].Rotation = 90;
		winT["4"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(41, 41, 41)), ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 11, 11))};


		-- StarterGui.Gui.Window.Topbar.UICorner
		winT["5"] = Instance.new("UICorner", winT["3"]);
		winT["5"].CornerRadius = UDim.new(0, 16);


		-- StarterGui.Gui.Window.Topbar.ImageButton
		winT["6"] = Instance.new("ImageLabel", winT["3"]);
		if type(opt.Icon) == "string" then
			Library:ApplyIcon(winT["6"],opt.Icon)
		else
			winT["6"].Image = "rbxassetid://" .. tostring(opt.Icon);
		end
		winT["6"].Size = UDim2.new(0, 30, 0, 30);
		winT["6"].BackgroundTransparency = 1;
		winT["6"].Position = UDim2.new(0, 10, 0, 10);


		-- StarterGui.Gui.Window.Topbar.TextLabel
		winT["7"] = Instance.new("TextLabel", winT["3"]);
		winT["7"].TextSize = 18;
		winT["7"].TextXAlignment = Enum.TextXAlignment.Left;
		winT["7"].FontFace = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
		winT["7"].TextColor3 = Color3.fromRGB(221, 221, 221);
		winT["7"].BackgroundTransparency = 1;
		winT["7"].Size = UDim2.new(1, -130, 1, 0);
		winT["7"].Text = opt.Name;
		winT["7"].Position = UDim2.new(0, 50, 0, 0);


		-- StarterGui.Gui.Window.Topbar.TextLabel.UICorner
		winT["8"] = Instance.new("UICorner", winT["7"]);
		winT["8"].CornerRadius = UDim.new(0, 12);


		-- StarterGui.Gui.Window.Topbar.X_Button
		winT["9"] = Instance.new("ImageButton", winT["3"]);
		winT["9"].BorderSizePixel = 0;
		winT["9"].AutoButtonColor = false;
		winT["9"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
		winT["9"].AnchorPoint = Vector2.new(0, 0.5);
		winT["9"].Size = UDim2.new(0, 26, 0, 26);
		winT["9"].BackgroundTransparency = 1;
		winT["9"].Name = [[X_Button]];
		winT["9"].Position = UDim2.new(1, -41, 0.5, 1);


		-- StarterGui.Gui.Window.Topbar.X_Button.UICorner
		winT["a"] = Instance.new("UICorner", winT["9"]);



		-- StarterGui.Gui.Window.Topbar.X_Button.Icon
		winT["b"] = Instance.new("ImageLabel", winT["9"]);
		winT["b"].Active = false;
		winT["b"].BorderSizePixel = 0;
		winT["b"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		winT["b"].AnchorPoint = Vector2.new(0.5, 0.5);
		winT["b"].Image = [[rbxassetid://10747384394]];
		winT["b"].Size = UDim2.new(0.8, 0, 0.8, 0);
		winT["b"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		winT["b"].BackgroundTransparency = 1;
		winT["b"].Selectable = false;
		winT["b"].Name = [[Icon]];
		winT["b"].Position = UDim2.new(0.5, 0, 0.5, 0);


		-- StarterGui.Gui.Window.Topbar.-_Button
		winT["c"] = Instance.new("ImageButton", winT["3"]);
		winT["c"].BorderSizePixel = 0;
		winT["c"].AutoButtonColor = false;
		winT["c"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
		winT["c"].AnchorPoint = Vector2.new(0, 0.5);
		winT["c"].Size = UDim2.new(0, 26, 0, 26);
		winT["c"].BackgroundTransparency = 1;
		winT["c"].Name = [[-_Button]];
		winT["c"].Position = UDim2.new(1, -75, 0.5, 0);

		-- StarterGui.Gui.Window.Topbar.-_Button.Frame
		winT["d"] = Instance.new("Frame", winT["c"]);
		winT["d"].BorderSizePixel = 0;
		winT["d"].BackgroundColor3 = Color3.fromRGB(181, 181, 181);
		winT["d"].AnchorPoint = Vector2.new(0.5, 0.5);
		winT["d"].Size = UDim2.new(0, 12, 0, 3);
		winT["d"].Position = UDim2.new(0.5, 0, 0.5, 0);
		winT["d"].BorderColor3 = Color3.fromRGB(0, 0, 0);

		-- StarterGui.Gui.Window.Topbar.-_Button.UICorner
		winT["e"] = Instance.new("UICorner", winT["c"]);
		
		-- StarterGui.Gui.Window.Main
		winT["f"] = Instance.new("Frame", winT["2"]);
		winT["f"].Size = UDim2.new(1, 0, 1, -50);
		winT["f"].Position = UDim2.new(0, 0, 0, 50);
		winT["f"].Name = [[Main]];
		winT["f"].BackgroundTransparency = 1;

		if Agreement then
			AddToToggleAll(winT["f"])
		end

		-- StarterGui.Gui.Window.Main.Side-Bar
		winT["10"] = Instance.new("Frame", winT["f"]);
		winT["10"].BorderSizePixel = 0;
		winT["10"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
		winT["10"].Size = UDim2.new(0, 160, 1, 0);
		winT["10"].Name = [[Side-Bar]];


		-- StarterGui.Gui.Window.Main.Side-Bar.UIGradient
		winT["11"] = Instance.new("UIGradient", winT["10"]);
		winT["11"].Rotation = 90;
		winT["11"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(41, 41, 41)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 11, 11))};


		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844
		winT["12"] = Instance.new("ScrollingFrame", winT["10"]);
		winT["12"].ScrollingDirection = Enum.ScrollingDirection.Y;
		winT["12"].BorderSizePixel = 0;
		winT["12"].CanvasSize = UDim2.new(0, 0, 0, 45);
		winT["12"].ElasticBehavior = Enum.ElasticBehavior.Never;
		winT["12"].TopImage = [[rbxassetid://0]];
		winT["12"].MidImage = [[rbxassetid://0]];
		winT["12"].Name = [[Iq844]];
		winT["12"].ScrollBarImageTransparency = 0.3;
		winT["12"].BottomImage = [[rbxassetid://0]];
		winT["12"].AutomaticCanvasSize = Enum.AutomaticSize.Y;
		winT["12"].Size = UDim2.new(1, 0, 0.97692, -42);
		winT["12"].ScrollBarImageColor3 = Color3.fromRGB(201, 201, 201);
		winT["12"].ScrollBarThickness = 0;
		winT["12"].BackgroundTransparency = 1;

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.UIListLayout
		winT["13"] = Instance.new("UIListLayout", winT["12"]);
		winT["13"].Padding = UDim.new(0, 5);
		winT["13"].SortOrder = Enum.SortOrder.LayoutOrder;


		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.UIPadding
		winT["14"] = Instance.new("UIPadding", winT["12"]);
		winT["14"].PaddingTop = UDim.new(0, 9);
		winT["14"].PaddingRight = UDim.new(0, 7);
		winT["14"].PaddingLeft = UDim.new(0, 7);


		-- StarterGui.Gui.Window.Main.Side-Bar.Settings
		winT["2a"] = Instance.new("ScrollingFrame", winT["10"]);
		winT["2a"].ScrollingDirection = Enum.ScrollingDirection.Y;
		winT["2a"].BorderSizePixel = 0;
		winT["2a"].CanvasSize = UDim2.new(0, 0, 0, 45);
		winT["2a"].TopImage = [[rbxassetid://0]];
		winT["2a"].MidImage = [[rbxassetid://0]];
		winT["2a"].Name = [[Settings]];
		winT["2a"].ScrollBarImageTransparency = 0.3;
		winT["2a"].BottomImage = [[rbxassetid://0]];
		winT["2a"].AnchorPoint = Vector2.new(0, 1);
		winT["2a"].Size = UDim2.new(1, 0, 0, 55);
		winT["2a"].ScrollBarImageColor3 = Color3.fromRGB(201, 201, 201);
		winT["2a"].Position = UDim2.new(0, 0, 1, 0);
		winT["2a"].ScrollBarThickness = 0;
		winT["2a"].BackgroundTransparency = 1;

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.UIPadding
		winT["2b"] = Instance.new("UIPadding", winT["2a"]);
		winT["2b"].PaddingTop = UDim.new(0, 5);
		winT["2b"].PaddingRight = UDim.new(0, 5);
		winT["2b"].PaddingLeft = UDim.new(0, 5);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab
		winT["2c"] = Instance.new("TextButton", winT["2a"]);
		winT["2c"].BorderSizePixel = 0;
		winT["2c"].TextColor3 = Color3.fromRGB(0, 0, 0);
		winT["2c"].TextSize = 14;
		winT["2c"].BackgroundColor3 = Color3.fromRGB(17, 17, 17);
		winT["2c"].FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		winT["2c"].AnchorPoint = Vector2.new(0, 0.5);
		winT["2c"].Size = UDim2.new(0, 135, 0, 36);
		winT["2c"].BackgroundTransparency = 1;
		winT["2c"].Name = [[Tab]];
		winT["2c"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		winT["2c"].Position = UDim2.new(0, 0, 0.5, 0);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.TextLabel
		winT["2d"] = Instance.new("TextLabel", winT["2c"]);
		winT["2d"].BorderSizePixel = 0;
		winT["2d"].TextSize = 16;
		winT["2d"].TextXAlignment = Enum.TextXAlignment.Left;
		winT["2d"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		winT["2d"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		winT["2d"].TextColor3 = Color3.fromRGB(181, 181, 181);
		winT["2d"].BackgroundTransparency = 1;
		winT["2d"].AnchorPoint = Vector2.new(0, 0.5);
		winT["2d"].Size = UDim2.new(0, 99, 0, 30);
		winT["2d"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		winT["2d"].Text = [[Settings]];
		winT["2d"].Position = UDim2.new(0, 34, 0.5, 0);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.TextLabel.UIPadding
		winT["2e"] = Instance.new("UIPadding", winT["2d"]);
		winT["2e"].PaddingLeft = UDim.new(0, 10);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.Icon
		
		winT["2f"] = cloneref(Instance.new("ImageLabel", winT["2c"]));
		winT["2f"].AnchorPoint = Vector2.new(0, 0.5);
		winT["2f"].Size = UDim2.new(0, 20, 0, 20);
		winT["2f"].BackgroundTransparency = 1;
		winT["2f"].Position = UDim2.new(0, 14, 0.5, 0);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.Selected
		winT["30"] = Instance.new("Frame", winT["2c"]);
		winT["30"].Visible = false;
		winT["30"].BorderSizePixel = 0;
		winT["30"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
		winT["30"].AnchorPoint = Vector2.new(0, 0.5);
		winT["30"].Size = UDim2.new(0, 3, 0, 20);
		winT["30"].Position = UDim2.new(0, 0, 0.5, 0);
		winT["30"].Name = [[Selected]];


		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.Selected.UICorner
		winT["31"] = Instance.new("UICorner", winT["30"]);

		-- StarterGui.Gui.Window.Main.Side-Bar.Settings.Tab.UICorner
		winT["32"] = Instance.new("UICorner", winT["2c"]);
		winT["32"].CornerRadius = UDim.new(0, 12);

		-- StarterGui.Gui.Window.Main.Side-Bar.UICorner
		winT["33"] = Instance.new("UICorner", winT["10"]);
		winT["33"].CornerRadius = UDim.new(0, 16);

		-- StarterGui.Gui.Window.Main.Side-Bar.Frame
		winT["34"] = Instance.new("Frame", winT["10"]);
		winT["34"].BorderSizePixel = 0;
		winT["34"].BackgroundColor3 = Color3.fromRGB(46, 46, 46);
		winT["34"].AnchorPoint = Vector2.new(0, 1);
		winT["34"].Size = UDim2.new(1, 0, 0, 1);
		winT["34"].Position = UDim2.new(0, 0, 1, -50);
		winT["34"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		
		-- StarterGui.Gui.Window.Main.Main
		winT["35"] = Instance.new("Frame", winT["f"]);
		winT["35"].BorderSizePixel = 0;
		winT["35"].Selectable = true;
		winT["35"].ClipsDescendants = true;
		winT["35"].Size = UDim2.new(1, -160, 1.01282, -5);
		winT["35"].Position = UDim2.new(0, 160, 0, 0);
		winT["35"].Name = [[Main]];
		winT["35"].BackgroundTransparency = 1;
		winT["35"].SelectionGroup = true;

		-- StarterGui.Gui.Window.Main.Main.UIPadding
		winT["36"] = Instance.new("UIPadding", winT["35"]);
		winT["36"].PaddingTop = UDim.new(0, 10);
		winT["36"].PaddingLeft = UDim.new(0, 10);


		-- StarterGui.Gui.Window.Main.Main.UIPageLayout
		winT["37"] = Instance.new("UIPageLayout", winT["35"]);
		winT["37"].EasingStyle = Enum.EasingStyle.Exponential;
		winT["37"].SortOrder = Enum.SortOrder.LayoutOrder;
		winT["37"].Padding = UDim.new(0, 12);
		winT["37"].TouchInputEnabled = false
		winT["37"].ScrollWheelInputEnabled = false
		winT["37"].GamepadInputEnabled = false
		winT["37"].TweenTime = 0.5;
		winT["37"].FillDirection = Enum.FillDirection.Vertical
		winT["37"].EasingDirection = Enum.EasingDirection.Out
	
	end
	
	-- // Main \\ --
	
	-- // Dragging \\ --
	local isDragging = false
	local dragStart = nil
	local startPos = nil
	local inputType = nil
	winT["3"].InputBegan:Connect(function(input)
		if not isDragging and input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			dragStart = input.Position
			startPos = winT["2"].Position
			inputType = input.UserInputType
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == inputType then
			isDragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mouseOffset = input.Position - dragStart
			local targetPosition = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + mouseOffset.X,
				startPos.Y.Scale, startPos.Y.Offset + mouseOffset.Y
			)
			winT["2"].Position = targetPosition
			
		end
	end)
	--]]
	
	--tabs
	function winT:CreateTab(optt)
		optt = Library:Validate({
			Name = "Tab",
			Icon = 14414089687,
		},optt or {})
		
		local Tab = {}
		
		--// Make UI \ --
		do
		Tab["15"] = Instance.new("TextButton", winT["12"]);
		Tab["15"].BorderSizePixel = 0;
		Tab["15"].TextColor3 = Color3.fromRGB(0, 0, 0);
		Tab["15"].TextSize = 14;
		Tab["15"].BackgroundColor3 = Color3.fromRGB(25, 25, 25);
		Tab["15"].FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Tab["15"].Size = UDim2.new(1, 0, 0, 40);
		Tab["15"].AutoButtonColor = false
		Tab["15"].BackgroundTransparency = 0.2;
		Tab["15"].Name = [[Tab]];
		Tab["15"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Tab["15"].Text = [[]];
		Tab["15"].ClipsDescendants = true

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.TextLabel
		Tab["16"] = Instance.new("TextLabel", Tab["15"]);
		Tab["16"].BorderSizePixel = 0;
		Tab["16"].TextSize = 16;
		Tab["16"].TextXAlignment = Enum.TextXAlignment.Left;
		Tab["16"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Tab["16"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
		Tab["16"].TextColor3 = Color3.fromRGB(201, 201, 201);
		Tab["16"].BackgroundTransparency = 1;
		Tab["16"].AnchorPoint = Vector2.new(0, 0.5);
		Tab["16"].Size = UDim2.new(0, 60, 0, 30);
		Tab["16"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Tab["16"].AutomaticSize = Enum.AutomaticSize.X;
		Tab["16"].Position = UDim2.new(0, 36, 0.5, 0);
		Tab["16"].TextTruncate = Enum.TextTruncate.AtEnd
		Tab["16"].Text = optt.Name

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.TextLabel.UIPadding
		Tab["17"] = Instance.new("UIPadding", Tab["16"]);
		Tab["17"].PaddingLeft = UDim.new(0, 10);

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.Icon
		Tab["18"] = Instance.new("ImageLabel", Tab["15"]);
		Tab["18"].ZIndex = 2;
		Tab["18"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Tab["18"].AnchorPoint = Vector2.new(0, 0.5);
		if type(optt.Icon) == "string" then
			Library:ApplyIcon(Tab["18"],optt.Icon)
		else
			Tab["18"].Image = "rbxassetid://" .. tostring(optt.Icon);
		end
		Tab["18"].Size = UDim2.new(0, 20, 0, 20);
		Tab["18"].BorderColor3 = Color3.fromRGB(131, 204, 255);
		Tab["18"].BackgroundTransparency = 1;
		Tab["18"].Name = [[Icon]];
		Tab["18"].Position = UDim2.new(0, 16, 0.5, 0);

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.Selected
		Tab["19"] = Instance.new("Frame", Tab["15"]);
		Tab["19"].BorderSizePixel = 0;
		Tab["19"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
		Tab["19"].AnchorPoint = Vector2.new(0, 0.5);
		Tab["19"].Size = UDim2.new(0, 3, 0, 20);
		Tab["19"].Position = UDim2.new(0, 0, 0.5, 0);
		Tab["19"].Name = [[Selected]];

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.Selected.UICorner
		Tab["1a"] = Instance.new("UICorner", Tab["19"]);

		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Tab.UICorner
		Tab["1b"] = Instance.new("UICorner", Tab["15"]);
		Tab["1b"].CornerRadius = UDim.new(0, 12);
		
		-- StarterGui.Gui.Window.Main.Main.ScrollingFrame
		Tab["38"] = Instance.new("ScrollingFrame", winT["35"]);
		Tab["38"].ScrollingDirection = Enum.ScrollingDirection.Y;
		Tab["38"].BorderSizePixel = 0;
		Tab["38"].CanvasSize = UDim2.new(0, 0, 0, 0);
		Tab["38"].CanvasPosition = Vector2.new(0, 80);
		Tab["38"].ElasticBehavior = Enum.ElasticBehavior.Never;
		Tab["38"].TopImage = [[rbxassetid://0]];
		Tab["38"].MidImage = [[rbxassetid://0]];
		Tab["38"].ScrollBarImageTransparency = 0.3;
		Tab["38"].BottomImage = [[rbxassetid://0]];
		Tab["38"].AutomaticCanvasSize = Enum.AutomaticSize.Y;
		Tab["38"].Size = UDim2.new(1, 0, 1, 0);
		Tab["38"].ScrollBarImageColor3 = Color3.fromRGB(201, 201, 201);
		Tab["38"].ScrollBarThickness = 6;
		Tab["38"].BackgroundTransparency = 1;
		
		-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.UIListLayout
		Tab["5d"] = Instance.new("UIListLayout", Tab["38"]);
		Tab["5d"].HorizontalAlignment = Enum.HorizontalAlignment.Center;
		Tab["5d"].Padding = UDim.new(0, 10);
		Tab["5d"].SortOrder = Enum.SortOrder.LayoutOrder;


		-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.UIPadding
		Tab["5e"] = Instance.new("UIPadding", Tab["38"]);
		Tab["5e"].PaddingTop = UDim.new(0, 4);
		Tab["5e"].PaddingRight = UDim.new(0, 10);
		Tab["5e"].PaddingLeft = UDim.new(0, 10);
		Tab["5e"].PaddingBottom = UDim.new(0, 40);
		end
		
		function Tab:Activate()
			if winT.CurrentTab then
				winT.CurrentTab:DeActivate()
			end
			Library:tween(Tab["19"], {BackgroundTransparency = 0}, 0.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			Library:tween(Tab["15"], {BackgroundTransparency = 0.2}, 0.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			winT["37"]:JumpTo(Tab["38"])
			winT.CurrentTab = Tab
		end
		
		function Tab:DeActivate()
			Library:tween(Tab["19"], {BackgroundTransparency = 1}, 0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			Library:tween(Tab["15"], {BackgroundTransparency = 1}, 0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		end
		
		Tab["15"].MouseButton1Click:Connect(function()
			if winT.CurrentTab ~= Tab then
				Tab:Activate()
			end
		end)
		
		-- startup
		if winT.CurrentTab == nil then
			Tab:Activate()
		elseif winT.CurrentTab ~= Tab then
			Tab:DeActivate()
			
		end
		--]]
		
		-- Controls
		function Tab:CreateButton(opt)
			opt = Library:Validate({
				Name = "Button",
				Callback = function() end
			},opt or {})
			
			local Button = {}
			
			do
				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button
				Button["56"] = Instance.new("ImageButton", Tab["38"]);
				Button["56"].Active = false;
				Button["56"].AutoButtonColor = false;
				Button["56"].Selectable = false;
				Button["56"].Size = UDim2.new(1, -12, 0, 45);
				Button["56"].BackgroundTransparency = 0.9;
				Button["56"].Name = [[Button]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844
				Button["57"] = Instance.new("TextButton", Button["56"]);
				Button["57"].BorderSizePixel = 0;
				Button["57"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Button["57"].AutoButtonColor = false;
				Button["57"].TextSize = 14;
				Button["57"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
				Button["57"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Button["57"].AnchorPoint = Vector2.new(0, 0.5);
				Button["57"].Size = UDim2.new(0, 52, 0, 28);
				Button["57"].BackgroundTransparency = 0.5;
				Button["57"].Name = [[Iq844]];
				Button["57"].Text = [[]];
				Button["57"].Position = UDim2.new(1, -60, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.UICorner
				Button["58"] = Instance.new("UICorner", Button["57"]);
				Button["58"].CornerRadius = UDim.new(0, 10);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.UIStroke
				Button["59"] = Instance.new("UIStroke", Button["57"]);
				Button["59"].Transparency = 0.5;
				Button["59"].Color = Color3.fromRGB(31, 31, 31);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.ImageLabel
				Button["5a"] = Instance.new("ImageLabel", Button["57"]);
				Button["5a"].BorderSizePixel = 0;
				Button["5a"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
				Button["5a"].AnchorPoint = Vector2.new(0.5, 0.5);
				Button["5a"].Image = [[rbxassetid://10734898194]];
				Button["5a"].Size = UDim2.new(0, 20, 0, 20);
				Button["5a"].BorderColor3 = Color3.fromRGB(0, 0, 0);
				Button["5a"].BackgroundTransparency = 1;
				Button["5a"].Position = UDim2.new(0.5, 0, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.UICorner
				Button["5b"] = Instance.new("UICorner", Button["56"]);
				Button["5b"].CornerRadius = UDim.new(0, 14);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Title
				Button["5c"] = Instance.new("TextLabel", Button["56"]);
				Button["5c"].TextSize = 18;
				Button["5c"].TextXAlignment = Enum.TextXAlignment.Left;
				Button["5c"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Button["5c"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Button["5c"].BackgroundTransparency = 1;
				Button["5c"].AnchorPoint = Vector2.new(0, 0.5);
				Button["5c"].Size = UDim2.new(0, 0, 0.5, 0);
				Button["5c"].Text = opt.Name;
				Button["5c"].AutomaticSize = Enum.AutomaticSize.X;
				Button["5c"].Name = [[Title]];
				Button["5c"].Position = UDim2.new(0, 10, 0.5, 0);
			end
			
			
			Button["56"].MouseEnter:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -10, 0, 47)},0.3,Enum.EasingStyle.Circular)	
			end)
			
			Button["56"].MouseLeave:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -12, 0, 45)},0.3,Enum.EasingStyle.Circular)	
			end)
			
			Button["56"].MouseButton1Down:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -12+5, 0, 47+5)},0.3,Enum.EasingStyle.Circular)	
				opt.Callback()
			end)
			
			Button["56"].MouseButton1Up:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -10, 0, 47)},0.3,Enum.EasingStyle.Circular)	
			end)
			
			function Button:SetName(name)
				Button["5c"].Text = name;
			end
			
			
			return Button
		end
		
		function Tab:CreateToggle(opt)
			opt = Library:Validate({
				Name = "Toggle",
				CurrentValue = false,
				Callback = function(v) end
			},opt or {})
			
			local Toggle = {
				isEnabled = false
			}
			
			Toggle.isEnabled = opt.CurrentValue
			
			--// Make toogle \\--
			do
				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle
				Toggle["39"] = Instance.new("Frame", Tab["38"]);
				Toggle["39"].Size = UDim2.new(1, -12, 0, 50);
				Toggle["39"].Name = [[Toggle]];
				Toggle["39"].BackgroundTransparency = 0.9;


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Title
				Toggle["3a"] = Instance.new("TextLabel", Toggle["39"]);
				Toggle["3a"].TextSize = 18;
				Toggle["3a"].TextXAlignment = Enum.TextXAlignment.Left;
				Toggle["3a"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Toggle["3a"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Toggle["3a"].BackgroundTransparency = 1;
				Toggle["3a"].AnchorPoint = Vector2.new(0, 0.5);
				Toggle["3a"].Size = UDim2.new(0, 0, 0.5, 0);
				Toggle["3a"].Text = opt.Name;
				Toggle["3a"].AutomaticSize = Enum.AutomaticSize.X;
				Toggle["3a"].Name = [[Title]];
				Toggle["3a"].Position = UDim2.new(0, 10, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Toggle
				Toggle["3b"] = Instance.new("ImageButton", Toggle["39"]);
				Toggle["3b"].BorderSizePixel = 0;
				Toggle["3b"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
				Toggle["3b"].Size = UDim2.new(0, 50, 0, 25);
				Toggle["3b"].Position = UDim2.new(1, -60, 0.5, -12);
				Toggle["3b"].Name = [[Toggle]];
				Toggle["3b"].AutoButtonColor = false


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Toggle.UICorner
				Toggle["3c"] = Instance.new("UICorner", Toggle["3b"]);
				Toggle["3c"].CornerRadius = UDim.new(0, 12);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Toggle.Back
				Toggle["3d"] = Instance.new("Frame", Toggle["3b"]);
				Toggle["3d"].BorderSizePixel = 0;
				Toggle["3d"].BackgroundColor3 = Color3.fromRGB(160, 160, 160);
				Toggle["3d"].AnchorPoint = Vector2.new(0,0.5)
				Toggle["3d"].Size = UDim2.new(0, 18, 0, 18);
				Toggle["3d"].Position = UDim2.new(0, 2, 0.5, 0);
				Toggle["3d"].Name = [[Back]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Toggle.Back.UICorner
				Toggle["3e"] = Instance.new("UICorner", Toggle["3d"]);
				Toggle["3e"].CornerRadius = UDim.new(0, 12);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.Toggle.UIPadding
				Toggle["3f"] = Instance.new("UIPadding", Toggle["3b"]);
				Toggle["3f"].PaddingRight = UDim.new(0, 3);
				Toggle["3f"].PaddingLeft = UDim.new(0, 3);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Toggle.UICorner
				Toggle["40"] = Instance.new("UICorner", Toggle["39"]);
				Toggle["40"].CornerRadius = UDim.new(0, 14);
			end
			
			if Toggle.isEnabled == true then
				Toggle["3d"].Position =UDim2.new(1, -22, 0.5, 0)
				Toggle["3d"].BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			end
			
			-- // Toggle Functionality \\ --
			do
				Toggle["3b"].MouseButton1Click:Connect(function()
					if Toggle.isEnabled then
						Toggle.isEnabled = false 
						Library:tween(Toggle["3d"],{Position = UDim2.new(0, 2, 0.5, 0)},0.5, Enum.EasingStyle.Exponential)
						Toggle["3d"].BackgroundColor3 = Color3.fromRGB(160, 160, 160);
					else
						Toggle.isEnabled = true 
						Library:tween(Toggle["3d"],{Position =UDim2.new(1, -22, 0.5, 0)},0.5, Enum.EasingStyle.Exponential)
						Toggle["3d"].BackgroundColor3 = Color3.fromRGB(200, 200, 200);
					end
					opt.Callback(Toggle.isEnabled)
				end)
			end
			
			function Toggle:SetName(t)
				Toggle["3a"].Text = t;
			end
			
			return Toggle
		end
		
		function Tab:CreateSeperator()
			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Seperator
			local Sep = {}
			
			Sep["6b"] = Instance.new("Frame", Tab["38"]);
			Sep["6b"].BorderSizePixel = 0;
			Sep["6b"].BackgroundColor3 = Color3.fromRGB(58, 58, 58);
			Sep["6b"].Size = UDim2.new(0.7, 0, 0, 6);
			Sep["6b"].BorderColor3 = Color3.fromRGB(0, 0, 0);
			Sep["6b"].Name = [[Seperator]];
			Sep["6b"].BackgroundTransparency = 0.4;


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Seperator.UICorner
			Sep["6c"] = Instance.new("UICorner", Sep["6b"]);
			Sep["6c"].CornerRadius = UDim.new(1, 0);
			
			return Sep
		end
		
		function Tab:CreateLabel(opt)
			opt = Library:Validate({
				Title = "Title",
				Content = "Content",
			}, opt or {})

			local Label = {}
			
			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Label
			Label["6d"] = Instance.new("Frame", Tab["38"]);
			Label["6d"].AutomaticSize = Enum.AutomaticSize.Y;
			Label["6d"].Size = UDim2.new(1, -12, 0, 60);
			Label["6d"].Name = [[Label]];
			Label["6d"].BackgroundTransparency = 0.9;


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Label.UICorner
			Label["6e"] = Instance.new("UICorner", Label["6d"]);
			Label["6e"].CornerRadius = UDim.new(0, 14);


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Label.Title
			Label["6f"] = Instance.new("TextLabel", Label["6d"]);
			Label["6f"].TextSize = 18;
			Label["6f"].TextXAlignment = Enum.TextXAlignment.Left;
			Label["6f"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Label["6f"].TextColor3 = Color3.fromRGB(226, 226, 226);
			Label["6f"].BackgroundTransparency = 1;
			Label["6f"].Size = UDim2.new(0.07229, 0, 0.4, 0);
			Label["6f"].Text = opt.Title;
			Label["6f"].AutomaticSize = Enum.AutomaticSize.X;
			Label["6f"].Name = [[Title]];
			Label["6f"].Position = UDim2.new(0, 10, 0.1, 0);


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Label.Text
			Label["70"] = Instance.new("TextLabel", Label["6d"]);
			Label["70"].TextWrapped = true;
			Label["70"].TextSize = 16;
			Label["70"].TextXAlignment = Enum.TextXAlignment.Left;
			Label["70"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Label["70"].TextColor3 = Color3.fromRGB(201, 201, 201);
			Label["70"].BackgroundTransparency = 1;
			Label["70"].Size = UDim2.new(0.96386, 0, 0.4, 0);
			Label["70"].Text = opt.Content;
			Label["70"].AutomaticSize = Enum.AutomaticSize.Y;
			Label["70"].Name = [[Text]];
			Label["70"].Position = UDim2.new(0, 10, 0.5, 0);


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Label.Text.UIPadding
			Label["71"] = Instance.new("UIPadding", Label["70"]);
			Label["71"].PaddingBottom = UDim.new(0, 8);
			
			function Label:SetContent(t)
				Label["70"].Text = t;
			end
			
			function Label:SetTitle(t)
				Label["6f"].Text = t;
			end
			
			return Label
		end

		function Tab:CreateInputField(opt)
			opt = Library:Validate({
				Name = "Input_Field",
				PlaceholderText = "PlaceHolder",
				Callback = function(t) end
			},opt or {})
			
			local InputField = {}
			
			
			--// Create UI \\--
			do
				InputField["50"] = Instance.new("Frame", Tab["38"]);
				InputField["50"].Size = UDim2.new(1, -12, 0, 50);
				InputField["50"].Name = "Input-Field";
				InputField["50"].BackgroundTransparency = 0.9;


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Input-Field.UICorner
				InputField["51"] = Instance.new("UICorner", InputField["50"]);
				InputField["51"].CornerRadius = UDim.new(0, 14);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Input-Field.Title
				InputField["52"] = Instance.new("TextLabel", InputField["50"]);
				InputField["52"].TextSize = 18;
				InputField["52"].TextXAlignment = Enum.TextXAlignment.Left;
				InputField["52"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				InputField["52"].TextColor3 = Color3.fromRGB(201, 201, 201);
				InputField["52"].BackgroundTransparency = 1;
				InputField["52"].AnchorPoint = Vector2.new(0, 0.5);
				InputField["52"].Size = UDim2.new(0, 0, 0.5, 0);
				InputField["52"].Text = opt.Name;
				InputField["52"].AutomaticSize = Enum.AutomaticSize.X;
				InputField["52"].Name = "Title";
				InputField["52"].Position = UDim2.new(0, 10, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Input-Field.Iq844
				InputField["53"] = Instance.new("TextBox", InputField["50"]);
				InputField["53"].Name = [[Iq844]];
				InputField["53"].BorderSizePixel = 0;
				InputField["53"].TextSize = 15;
				InputField["53"].TextColor3 = Color3.fromRGB(231, 231, 231);
				InputField["53"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
				InputField["53"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				InputField["53"].AutomaticSize = Enum.AutomaticSize.X;
				InputField["53"].AnchorPoint = Vector2.new(1, 0.5);
				InputField["53"].PlaceholderText = opt.PlaceholderText;
				InputField["53"].Size = UDim2.new(0, 55, 0, 30);
				InputField["53"].Position = UDim2.new(1, -10, 0.5, 0);
				InputField["53"].Text = [[]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Input-Field.Iq844.UICorner
				InputField["54"] = Instance.new("UICorner", InputField["53"]);
				InputField["54"].CornerRadius = UDim.new(0, 10);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Input-Field.Iq844.UIPadding
				InputField["55"] = Instance.new("UIPadding", InputField["53"]);
				InputField["55"].PaddingRight = UDim.new(0, 10);
				InputField["55"].PaddingLeft = UDim.new(0, 10);
			end
			
			InputField["53"].FocusLost:Connect(function(enterPressed)
				if enterPressed then
					opt.Callback(InputField["53"].Text)
				end
			end)
			
			function InputField:SetTitle(t)
				InputField["52"].Text = t
			end
			
			return InputField
		end
		
		function Tab:CreateKeybind(opt)
			opt = Library:Validate({
				Name = "Keybind",
				DefaultBind = Enum.KeyCode.G,
				Callback = function(v) end
			},opt or {})

			local Keybind = {
				ActiveKeybind = nil
			}
			Keybind.ActiveKeybind = opt.DefaultBind

			do
				Keybind["5f"] = Instance.new("Frame", Tab["38"]);
				Keybind["5f"].Size = UDim2.new(1, -12, 0, 50);
				Keybind["5f"].Name = [[Keybind]];
				Keybind["5f"].BackgroundTransparency = 0.9;

				Keybind["60"] = Instance.new("TextButton", Keybind["5f"]);
				Keybind["60"].BorderSizePixel = 0;
				Keybind["60"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Keybind["60"].TextSize = 15;
				Keybind["60"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
				Keybind["60"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Keybind["60"].AnchorPoint = Vector2.new(1, 0);
				Keybind["60"].AutomaticSize = Enum.AutomaticSize.X;
				Keybind["60"].Size = UDim2.new(0, 45, 0, 25);
				Keybind["60"].Name = [[Iq844]];
				Keybind["60"].Text = [[None]];
				Keybind["60"].Position = UDim2.new(1, -10, 0.5, -12);

				Keybind["61"] = Instance.new("UICorner", Keybind["60"]);
				Keybind["61"].CornerRadius = UDim.new(0, 10);

				Keybind["62"] = Instance.new("UIPadding", Keybind["60"]);
				Keybind["62"].PaddingRight = UDim.new(0, 8);
				Keybind["62"].PaddingLeft = UDim.new(0, 8);

				Keybind["63"] = Instance.new("UIStroke", Keybind["60"]);
				Keybind["63"].Transparency = 0.8;
				Keybind["63"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Keybind["63"].Thickness = 1.5;
				Keybind["63"].Color = Color3.fromRGB(181, 181, 181);

				Keybind["64"] = Instance.new("UICorner", Keybind["5f"]);
				Keybind["64"].CornerRadius = UDim.new(0, 14);

				Keybind["65"] = Instance.new("TextLabel", Keybind["5f"]);
				Keybind["65"].TextSize = 18;
				Keybind["65"].TextXAlignment = Enum.TextXAlignment.Left;
				Keybind["65"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Keybind["65"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Keybind["65"].BackgroundTransparency = 1;
				Keybind["65"].AnchorPoint = Vector2.new(0, 0.5);
				Keybind["65"].Size = UDim2.new(0, 0, 0.5, 0);
				Keybind["65"].Text = opt.Name;
				Keybind["65"].AutomaticSize = Enum.AutomaticSize.X;
				Keybind["65"].Name = opt.Name;
				Keybind["65"].Position = UDim2.new(0, 10, 0.5, 0);
			end

			do
				local UserInputService = game:GetService("UserInputService")
				
				local function getInputName(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						return input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.Gamepad1 then
						return "GP1_" .. input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.Gamepad2 then
						return "GP2_" .. input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.Gamepad3 then
						return "GP3_" .. input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.Gamepad4 then
						return "GP4_" .. input.KeyCode.Name
					else
						return input.KeyCode.Name
					end
				end

				local function isValidInput(input)
					return (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Unknown) or
						(input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode ~= Enum.KeyCode.Unknown) or
						(input.UserInputType == Enum.UserInputType.Gamepad2 and input.KeyCode ~= Enum.KeyCode.Unknown) or
						(input.UserInputType == Enum.UserInputType.Gamepad3 and input.KeyCode ~= Enum.KeyCode.Unknown) or
						(input.UserInputType == Enum.UserInputType.Gamepad4 and input.KeyCode ~= Enum.KeyCode.Unknown)
				end

				Keybind["60"].Text = getInputName({UserInputType = Enum.UserInputType.Keyboard, KeyCode = Keybind.ActiveKeybind})

				local isListening = false
				local currentConnection = nil

				Keybind["60"].MouseButton1Click:Connect(function()
					if isListening then return end
					
					isListening = true
					local running = true
					
					task.spawn(function()
						local states = {".", "..", "..."}
						local i = 1
						while running do
							Keybind["60"].Text = states[i]
							i = i % #states + 1
							task.wait(0.5)
						end
					end)

					if currentConnection then
						currentConnection:Disconnect()
					end

					currentConnection = UserInputService.InputBegan:Connect(function(input)
						if isValidInput(input) then
							running = false
							local newKeyName = getInputName(input)
							Keybind["60"].Text = newKeyName
							Keybind.ActiveKeybind = input.KeyCode
							Keybind.ActiveInputType = input.UserInputType
							isListening = false
							currentConnection:Disconnect()
							currentConnection = nil
						end
					end)
				end)

				UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed or isListening then return end
					
					if input.KeyCode == Keybind.ActiveKeybind then
						if (Keybind.ActiveInputType and input.UserInputType == Keybind.ActiveInputType) or
						(not Keybind.ActiveInputType and input.UserInputType == Enum.UserInputType.Keyboard) then
							pcall(function()
								opt.Callback(Keybind.ActiveKeybind)
							end)
						end
					end
				end)

				function Keybind:SetKeybind(keyCode, inputType)
					if typeof(keyCode) == "EnumItem" then
						Keybind.ActiveKeybind = keyCode
						Keybind.ActiveInputType = inputType or Enum.UserInputType.Keyboard
						Keybind["60"].Text = getInputName({UserInputType = Keybind.ActiveInputType, KeyCode = keyCode})
					end
				end

				function Keybind:SetName(name)
					if typeof(name) == "string" then
						Keybind["65"].Text = name
						Keybind["65"].Name = name
					end
				end
			end

			return Keybind	
		end
		
		function Tab:CreateSlider(opt)
			opt = Library:Validate({
				Name = "Slider",
				DefaultValue = 50,
				MinValue = 1,
                Increment = 0,
				MaxValue = 100,
				Callback = function(v) end
			},opt or {})

			local Slider = {
				CurrentValue = nil
			}
			--starting values
			do
			Slider.MinValue = opt.MinValue
            Slider.Increment = opt.Increment
			Slider.MaxValue = opt.MaxValue
			Slider.CurrentValue = opt.DefaultValue	
			end
			
			--// Ui \\ --
			do
				Slider["41"] = Instance.new("ImageButton", Tab["38"]);
				Slider["41"].Size = UDim2.new(1, -12, 0, 55);
				Slider["41"].Name = [[Slider]];
				Slider["41"].BackgroundTransparency = 0.9;
				Slider["41"].AutoButtonColor = false


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Count
				Slider["42"] = Instance.new("TextLabel", Slider["41"]);
				Slider["42"].TextSize = 16;
				Slider["42"].TextXAlignment = Enum.TextXAlignment.Right;
				Slider["42"].TextYAlignment = Enum.TextYAlignment.Bottom;
				Slider["42"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Slider["42"].TextColor3 = Color3.fromRGB(199, 199, 199);
				Slider["42"].BackgroundTransparency = 1;
				Slider["42"].AnchorPoint = Vector2.new(1, 0);
				Slider["42"].Size = UDim2.new(0, 40, 0, 25);
				Slider["42"].Text = [[50]];
				Slider["42"].AutomaticSize = Enum.AutomaticSize.X;
				Slider["42"].Name = [[Count]];
				Slider["42"].Position = UDim2.new(1, -10, 0, 5);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Count.UIPadding
				Slider["43"] = Instance.new("UIPadding", Slider["42"]);
				Slider["43"].PaddingRight = UDim.new(0, 7);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Slider
				Slider["44"] = Instance.new("ImageButton", Slider["41"]);
				Slider["44"].BorderSizePixel = 0;
				Slider["44"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
				Slider["44"].Size = UDim2.new(1, -26, 0, 10);
				Slider["44"].Position = UDim2.new(0, 10, 0, 35);
				Slider["44"].Name = [[Slider]];
				Slider["44"].AutoButtonColor = false


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Slider.UICorner
				Slider["45"] = Instance.new("UICorner", Slider["44"]);
				Slider["45"].CornerRadius = UDim.new(0, 5);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Slider.SliderFront
				Slider["46"] = Instance.new("Frame", Slider["44"]);
				Slider["46"].BorderSizePixel = 0;
				Slider["46"].BackgroundColor3 = Color3.fromRGB(61, 61, 61);
				Slider["46"].Size = UDim2.new(0.5, 0, 1, 0);
				Slider["46"].Name = [[SliderFront]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Slider.SliderFront.UICorner
				Slider["47"] = Instance.new("UICorner", Slider["46"]);
				Slider["47"].CornerRadius = UDim.new(0, 5);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.Title
				Slider["48"] = Instance.new("TextLabel", Slider["41"]);
				Slider["48"].TextSize = 18;
				Slider["48"].TextXAlignment = Enum.TextXAlignment.Left;
				Slider["48"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Slider["48"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Slider["48"].BackgroundTransparency = 1;
				Slider["48"].AnchorPoint = Vector2.new(0, 0.5);
				Slider["48"].Size = UDim2.new(0, 0, 0.5, 0);
				Slider["48"].Text = opt.Name;
				Slider["48"].AutomaticSize = Enum.AutomaticSize.X;
				Slider["48"].Name = [[Title]];
				Slider["48"].Position = UDim2.new(0, 10, 0.35, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Slider.UICorner
				Slider["49"] = Instance.new("UICorner", Slider["41"]);
				Slider["49"].CornerRadius = UDim.new(0, 14);
			end
			
			--// Functionality \\ --
			do
				function Slider:GetValue()
					return tonumber(Slider["42"].Text)
				end

                function Slider:SetValue(v)
                    local value
                    local range = Slider.MaxValue - Slider.MinValue

                    local steps = math.floor(range / Slider.Increment + 0.5)

                    if v == nil then
                        local percentage = math.clamp(
                            (Mouse.X - Slider["44"].AbsolutePosition.X) / Slider["44"].AbsoluteSize.X,
                            0, 1
                        )

                        local stepIndex = math.floor(percentage * steps + 0.5)
                        value = Slider.MinValue + stepIndex * Slider.Increment
                    else
                        local stepIndex = math.floor(((v - Slider.MinValue) / Slider.Increment) + 0.5)
                        stepIndex = math.clamp(stepIndex, 0, steps)
                        value = Slider.MinValue + stepIndex * Slider.Increment
                    end

                    local percentage = (value - Slider.MinValue) / range

                    Slider["42"].Text = string.format("%.3f", value)

                    Library:tween(Slider["46"], {
                        Size = UDim2.fromScale(percentage, 1)
                    }, 0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

                    opt.Callback(value)
                end


				do
					Slider["42"].Text = tostring(Slider.CurrentValue)

					Slider["46"].Size =UDim2.fromScale(((Slider.CurrentValue -Slider.MinValue) / (Slider.MaxValue - Slider.MinValue)),1)
				end
				
				Slider["44"].MouseButton1Down:Connect(function()
					if not Slider.Connection then
						Slider.Connection = game:GetService("RunService").RenderStepped:Connect(function()
							Slider:SetValue()
						end)
					end
				end)

				Slider["44"].MouseButton1Up:Connect(function()
					if Slider.Connection then Slider.Connection:Disconnect() end
					Slider.Connection = nil
				end)

				Slider["44"].MouseLeave:Connect(function()
					if Slider.Connection then Slider.Connection:Disconnect() end
					Slider.Connection = nil

				end)

			end	
			
			

			return Slider
		end
		
		function Tab:CreateDropDown(options)
			options = Library:Validate({
				Text = "DropDown",
				Options = {"Option 1","Option 2"},
				Multi = true,
				Callback = function(Options)
				end,
			},options or {})

			local DropDown = {
				Items = {
					["id"] = {
						--instance = {},
					},
				},
				isOpened = false,
				CurrentOptions = {}
			}

			--// UI \\--
			do
				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown
				DropDown["b1"] = Instance.new("Frame", Tab["38"]);
				DropDown["b1"]["BorderSizePixel"] = 0;
				DropDown["b1"]["ZIndex"] = DropdownZIndex;
				DropdownZIndex = DropdownZIndex - 1
				DropDown["b1"]["Size"] = UDim2.new(1, -12, 0, 50);
				DropDown["b1"]["BackgroundTransparency"] = 1;
				DropDown["b1"]["Name"] = [[Dropdown]];


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Title
				DropDown["b2"] = Instance.new("TextLabel", DropDown["b1"]);
				DropDown["b2"]["TextSize"] = 18;
				DropDown["b2"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				DropDown["b2"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				DropDown["b2"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
				DropDown["b2"]["BackgroundTransparency"] = 1;
				DropDown["b2"]["Size"] = UDim2.new(0, 0, 0, 25);
				DropDown["b2"]["Text"] = options.Text
				DropDown["b2"]["AutomaticSize"] = Enum.AutomaticSize.X;
				DropDown["b2"]["Name"] = [[Title]];
				DropDown["b2"]["Position"] = UDim2.new(0, 10, 0, 12);


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.BG
				DropDown["bSigma"] = Instance.new("ImageButton", DropDown["b1"]);
				DropDown["bSigma"]["AutoButtonColor"] = false;
				DropDown["bSigma"]["Selectable"] = false;
				DropDown["bSigma"]["BorderSizePixel"] = 0;
				DropDown["bSigma"]["Active"] = false;
				DropDown["bSigma"]["Size"] = UDim2.new(1, 0, 0, 50);
				DropDown["bSigma"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["bSigma"]["Name"] = [[BG]];
				DropDown["bSigma"]["BackgroundTransparency"] = 0.9;


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.BG.UICorner
				DropDown["bSigmaC"] = Instance.new("UICorner", DropDown["bSigma"]);
				DropDown["bSigmaC"]["CornerRadius"] = UDim.new(0, 14);

				
			end
			
			--// Dropdown \\--
			do
				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main
				DropDown["b3"] = Instance.new("Frame", DropDown["b1"]);
				DropDown["b3"]["BorderSizePixel"] = 0;
				DropDown["b3"]["BackgroundColor3"] = Color3.fromRGB(45, 45, 45);
				DropDown["b3"]["AnchorPoint"] = Vector2.new(1, 0);
				DropDown["b3"]["Size"] = UDim2.new(0.3, 0, 0, 38);
				DropDown["b3"]["Position"] = UDim2.new(1, -10, 0, 7);
				DropDown["b3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["b3"]["Name"] = [[Main]];
				DropDown["b3"]["BackgroundTransparency"] = 0.15;


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main.UICorner
				DropDown["b4"] = Instance.new("UICorner", DropDown["b3"]);
				DropDown["b4"]["CornerRadius"] = UDim.new(0, 11);



				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main.CurrentOption
				DropDown["b6"] = Instance.new("TextLabel", DropDown["b3"]);
				DropDown["b6"]["TextSize"] = 18;
				DropDown["b6"]["TextXAlignment"] = Enum.TextXAlignment.Center;
				DropDown["b6"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				DropDown["b6"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
				DropDown["b6"]["BackgroundTransparency"] = 1;
				DropDown["b6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				DropDown["b6"]["Size"] = UDim2.new(0.7, 0, 0, 25);
				DropDown["b6"]["Text"] = "Select something";
				DropDown["b6"]["Name"] = [[CurrentOption]];
				DropDown["b6"].TextTruncate = Enum.TextTruncate.AtEnd
				DropDown["b6"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main.Holder
				DropDown["b7"] = Instance.new("ScrollingFrame", DropDown["b3"]);
				DropDown["b7"]["Visible"] = false;
				DropDown["b7"]["BorderSizePixel"] = 0;
				DropDown["b7"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
				DropDown["b7"]["TopImage"] = [[]];
				DropDown["b7"]["MidImage"] = [[]];
				DropDown["b7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				DropDown["b7"]["Name"] = [[Holder]];
				DropDown["b7"]["Selectable"] = false;
				DropDown["b7"]["BottomImage"] = [[]];
				DropDown["b7"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
				DropDown["b7"]["Size"] = UDim2.new(1, 0, 1, 0);
				DropDown["b7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["b7"]["BackgroundTransparency"] = 1;


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main.Holder.UIListLayout
				DropDown["b8"] = Instance.new("UIListLayout", DropDown["b7"]);
				DropDown["b8"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				DropDown["b8"]["Padding"] = UDim.new(0, 10);
				DropDown["b8"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


				-- StarterGui.Oz.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Main.Holder.UIPadding
				DropDown["b9"] = Instance.new("UIPadding", DropDown["b7"]);
				DropDown["b9"]["PaddingTop"] = UDim.new(0, 10);
				DropDown["b9"]["PaddingRight"] = UDim.new(0, 10);
				DropDown["b9"]["PaddingLeft"] = UDim.new(0, 10);
				DropDown["b9"]["PaddingBottom"] = UDim.new(0, 10);

				
			end
			
			--// Logic \\--
			do
				function DropDown:Toggle()
					DropDown.isOpened = not DropDown.isOpened
					if DropDown.isOpened == true then
						task.spawn(function()
							Library:tween(DropDown["b6"],{TextTransparency = 1},0.25,Enum.EasingStyle.Exponential)
							Library:tween(DropDown["b3"],{Size = UDim2.new(0.4, 0, 0, 112)},0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out)
							task.wait(0.01)
							DropDown["b7"]["Visible"] = true;
						end)
					elseif DropDown.isOpened == false then
						task.spawn(function()
							Library:tween(DropDown["b6"],{TextTransparency = 0},0.25,Enum.EasingStyle.Exponential)
							Library:tween(DropDown["b3"],{Size = UDim2.new(0.3, 0, 0, 38)},0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out)
							task.wait(0.05)
							DropDown["b7"]["Visible"] = false;
							
						end)
					end
				end

				function DropDown:Add(id)
					DropDown.Items[id] = {
						instance = {},
						selected = false
					}

					-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Frame.Option
					DropDown.Items[id].instance["53"] = Instance.new("ImageButton", DropDown["b7"]);
					DropDown.Items[id].instance["53"]["BorderSizePixel"] = 0;
					DropDown.Items[id].instance["53"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
					DropDown.Items[id].instance["53"]["Size"] = UDim2.new(1, -10,0, 40);
					DropDown.Items[id].instance["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					DropDown.Items[id].instance["53"]["Name"] = [[Option]];
					DropDown.Items[id].instance["53"].AutoButtonColor  =false
					DropDown.Items[id].instance["53"]["BackgroundTransparency"] = 0.55;


					-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Frame.Option.UICorner
					DropDown.Items[id].instance["54"] = Instance.new("UICorner", DropDown.Items[id].instance["53"]);
					DropDown.Items[id].instance["54"]["CornerRadius"] = UDim.new(0, 10);


					-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Frame.Option.Title
					DropDown.Items[id].instance["55"] = Instance.new("TextLabel", DropDown.Items[id].instance["53"]);
					DropDown.Items[id].instance["55"]["TextSize"] = 18;
					DropDown.Items[id].instance["55"]["TextXAlignment"] = Enum.TextXAlignment.Center;
					DropDown.Items[id].instance["55"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
					DropDown.Items[id].instance["55"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
					DropDown.Items[id].instance["55"]["BackgroundTransparency"] = 1;
					DropDown.Items[id].instance["55"]["Size"] = UDim2.new(1, 0, 1, 0);
					DropDown.Items[id].instance["55"]["Text"] = id;
					DropDown.Items[id].instance["55"]["AutomaticSize"] = Enum.AutomaticSize.X;
					DropDown.Items[id].instance["55"]["Name"] = [[Title]];
					DropDown.Items[id].instance["55"]["Position"] = UDim2.new(0.5,0,0.5,0);
					DropDown.Items[id].instance["55"].TextYAlignment = Enum.TextYAlignment.Center;
					DropDown.Items[id].instance["55"].AnchorPoint = Vector2.new(0.5,0.5)


					-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Dropdown.Frame.Option.UIStroke
					DropDown.Items[id].instance["5a"] = Instance.new("UIStroke", DropDown.Items[id].instance["53"]);
					DropDown.Items[id].instance["5a"]["Transparency"] = 0.68;
					DropDown.Items[id].instance["5a"]["Thickness"] = 2.5;
					DropDown.Items[id].instance["5a"]["Color"] = Color3.fromRGB(255, 255, 255);

					DropDown.Items[id].instance["53"].MouseButton1Click:Connect(function()
						if options.Multi == false then
							DropDown["b6"].Text = id
							options.Callback(id)
							DropDown:Toggle()
						else
							DropDown.Items[id].selected = not DropDown.Items[id].selected
							if DropDown.Items[id].selected then
								table.insert(DropDown.CurrentOptions, id)
								Library:tween(DropDown.Items[id].instance["53"], {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}, 0.2, Enum.EasingStyle.Exponential)
							else
								Library:tween(DropDown.Items[id].instance["53"], {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2, Enum.EasingStyle.Exponential)
								for i, v in DropDown.CurrentOptions do
									if v == id then
										table.remove(DropDown.CurrentOptions, i)
										break
									end
								end
							end
							local sorted = {unpack(DropDown.CurrentOptions)}
							table.sort(sorted)
							DropDown["b6"].Text = table.concat(sorted, ", ")
							options.Callback(sorted)
						end
					end)

					DropDown.Items[id].instance["53"].MouseEnter:Connect(function()
						Library:tween(DropDown.Items[id].instance["53"],{Size = UDim2.new(1, -6,0, 44)},0.8,Enum.EasingStyle.Exponential)
					end)
					DropDown.Items[id].instance["53"].MouseLeave:Connect(function()
						Library:tween(DropDown.Items[id].instance["53"],{Size = UDim2.new(1, -10,0, 40)},0.8,Enum.EasingStyle.Exponential)
					end)
				end

				for _, Name in pairs(options.Options) do
					DropDown:Add(Name)
				end

				DropDown["bSigma"].MouseButton1Down:Connect(function()
					DropDown:Toggle()
				end)

				function DropDown:ClearElements()
					for key in pairs(DropDown.Items) do
						if key ~= "id" then
							DropDown.Items[key] = nil
						end
					end
					DropDown["b6"].Text = "None"
					for i,v in DropDown["b7"]:GetChildren() do
						if v:IsA("ImageButton") then
							v:Destroy()
						end
					end
				end
			end

			return DropDown
		end
		
		function Tab:CreateColorpicker(opt)
			opt = Library:Validate({
				Name = "KeyBind",
				DefaultValue = Color3.fromRGB(2,2,2),
				Callback = function(color) end,
			},opt or {})
			
			local ColorPickerSmall = {
				Value = Color3.fromRGB(1,1,1),
				isOpened = false
			}
			
			ColorPickerSmall.Value = opt.DefaultValue
			--// First dis makes the colorpicker popup bcuz doing it outside and just setting would be too confusing and complicated to setup
			function ColorPickerSmall:OpenColorPicker()
				local ColorPickerMain = {}
				ColorPickerSmall.isOpened = true
				
				--// Ui \\--
				do
					ColorPickerMain["a3"] = Instance.new("ImageButton", winT["2"]);
					ColorPickerMain["a3"].Active = false;
					ColorPickerMain["a3"].BorderSizePixel = 0;
					ColorPickerMain["a3"].Modal = true;
					ColorPickerMain["a3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["a3"].Selectable = false;
					ColorPickerMain["a3"].ZIndex = 2;
					ColorPickerMain["a3"].Size = UDim2.new(1, 0, 1, 0);
					ColorPickerMain["a3"].Name = [[ColorPickerPopup]];
					ColorPickerMain["a3"].BorderColor3 = Color3.fromRGB(0, 0, 0);


					-- StarterGui.Gui.Window.ColorPickerPopup.UIGradient
					ColorPickerMain["a4"] = Instance.new("UIGradient", ColorPickerMain["a3"]);
					ColorPickerMain["a4"].Rotation = 90;
					ColorPickerMain["a4"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0.15),NumberSequenceKeypoint.new(1.000, 0.15)};
					ColorPickerMain["a4"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 0, 0))};


					-- StarterGui.Gui.Window.ColorPickerPopup.UICorner
					ColorPickerMain["a5"] = Instance.new("UICorner", ColorPickerMain["a3"]);
					ColorPickerMain["a5"].CornerRadius = UDim.new(0, 16);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big
					ColorPickerMain["a6"] = Instance.new("Frame", ColorPickerMain["a3"]);
					ColorPickerMain["a6"].BackgroundColor3 = Color3.fromRGB(26, 26, 26);
					ColorPickerMain["a6"].AnchorPoint = Vector2.new(0.5, 0.5);
					ColorPickerMain["a6"].ClipsDescendants = true;
					ColorPickerMain["a6"].Size = UDim2.new(0, 425, 0, 250);
					ColorPickerMain["a6"].Position = UDim2.new(0.50286, 0, 0.49773, 0);
					ColorPickerMain["a6"].Name = [[ColorPicker_Big]];
					ColorPickerMain["a6"].BackgroundTransparency = 0.35;


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.UICorner
					ColorPickerMain["a7"] = Instance.new("UICorner", ColorPickerMain["a6"]);
					ColorPickerMain["a7"].CornerRadius = UDim.new(0, 14);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.Title
					ColorPickerMain["a8"] = Instance.new("TextLabel", ColorPickerMain["a6"]);
					ColorPickerMain["a8"].TextSize = 18;
					ColorPickerMain["a8"].TextXAlignment = Enum.TextXAlignment.Left;
					ColorPickerMain["a8"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
					ColorPickerMain["a8"].TextColor3 = Color3.fromRGB(201, 201, 201);
					ColorPickerMain["a8"].BackgroundTransparency = 1;
					ColorPickerMain["a8"].Size = UDim2.new(0, 0, 0, 25);
					ColorPickerMain["a8"].Text = opt.Name;
					ColorPickerMain["a8"].AutomaticSize = Enum.AutomaticSize.X;
					ColorPickerMain["a8"].Name = [[Title]];
					ColorPickerMain["a8"].Position = UDim2.new(0, 10, 0, 7);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside
					ColorPickerMain["a9"] = Instance.new("Frame", ColorPickerMain["a6"]);
					ColorPickerMain["a9"].BorderSizePixel = 0;
					ColorPickerMain["a9"].BackgroundColor3 = Color3.fromRGB(21, 21, 21);
					ColorPickerMain["a9"].AnchorPoint = Vector2.new(1, 0.5);
					ColorPickerMain["a9"].ClipsDescendants = true;
					ColorPickerMain["a9"].Size = UDim2.new(0, 200, 0, 170);
					ColorPickerMain["a9"].Position = UDim2.new(1, -40, 0.49, -3);
					ColorPickerMain["a9"].Name = [[ColorPickerInside]];
					ColorPickerMain["a9"].BackgroundTransparency = 0.1;


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.UICorner
					ColorPickerMain["aa"] = Instance.new("UICorner", ColorPickerMain["a9"]);
					ColorPickerMain["aa"].CornerRadius = UDim.new(0, 12);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.UIStroke
					ColorPickerMain["ab"] = Instance.new("UIStroke", ColorPickerMain["a9"]);
					ColorPickerMain["ab"].Transparency = 0.82;
					ColorPickerMain["ab"].Thickness = 2;
					ColorPickerMain["ab"].Color = Color3.fromRGB(255, 255, 255);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.UIStroke.UIGradient
					ColorPickerMain["ac"] = Instance.new("UIGradient", ColorPickerMain["ab"]);
					ColorPickerMain["ac"].Rotation = -33;
					ColorPickerMain["ac"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.416, 0),NumberSequenceKeypoint.new(1.000, 0)};


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame
					ColorPickerMain["ad"] = Instance.new("Frame", ColorPickerMain["a9"]);
					ColorPickerMain["ad"].BorderSizePixel = 0;
					ColorPickerMain["ad"].AnchorPoint = Vector2.new(1, 0);
					ColorPickerMain["ad"].Size = UDim2.new(0, 20, 0, 150);
					ColorPickerMain["ad"].Position = UDim2.new(1, -10, 0, 10);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.UIGradient
					ColorPickerMain["ae"] = Instance.new("UIGradient", ColorPickerMain["ad"]);
					ColorPickerMain["ae"].Rotation = 90;
					ColorPickerMain["ae"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.Frame
					ColorPickerMain["af"] = Instance.new("Frame", ColorPickerMain["ad"]);
					ColorPickerMain["af"].ZIndex = 5;
					ColorPickerMain["af"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["af"].AnchorPoint = Vector2.new(0.5, 0.5);
					ColorPickerMain["af"].Size = UDim2.new(1, 0, 0, 4);
					ColorPickerMain["af"].Position = UDim2.new(0.5, 0, 0, 0);
					ColorPickerMain["af"].Name = "Skibidi"


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame
					ColorPickerMain["b0"] = Instance.new("Frame", ColorPickerMain["a9"]);
					ColorPickerMain["b0"].BorderSizePixel = 0;
					ColorPickerMain["b0"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["b0"].Size = UDim2.new(0, 150, 0, 150);
					ColorPickerMain["b0"].Position = UDim2.new(0, 15, 0, 10);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.UIGradient
					ColorPickerMain["b1"] = Instance.new("UIGradient", ColorPickerMain["b0"]);
					ColorPickerMain["b1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 0)),ColorSequenceKeypoint.new(0.170, Color3.fromRGB(255, 255, 0)),ColorSequenceKeypoint.new(0.330, Color3.fromRGB(0, 255, 0)),ColorSequenceKeypoint.new(0.500, Color3.fromRGB(0, 255, 255)),ColorSequenceKeypoint.new(0.670, Color3.fromRGB(0, 0, 255)),ColorSequenceKeypoint.new(0.830, Color3.fromRGB(255, 0, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))};


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.Frame
					ColorPickerMain["b2"] = Instance.new("Frame", ColorPickerMain["b0"]);
					ColorPickerMain["b2"].BorderSizePixel = 0;
					ColorPickerMain["b2"].Size = UDim2.new(1, 0, 1, 0);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.Frame.UIGradient
					ColorPickerMain["b3"] = Instance.new("UIGradient", ColorPickerMain["b2"]);
					ColorPickerMain["b3"].Rotation = -90;
					ColorPickerMain["b3"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(1.000, 1)};


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.ColorPickerInside.Frame.Frame
					ColorPickerMain["b4"] = Instance.new("Frame", ColorPickerMain["b0"]);
					ColorPickerMain["b4"].ZIndex = 5;
					ColorPickerMain["b4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["b4"].AnchorPoint = Vector2.new(0.5, 0.5);
					ColorPickerMain["b4"].Size = UDim2.new(0, 6, 0, 6);
					ColorPickerMain["b4"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					
					Instance.new("UICorner",ColorPickerMain["b4"])

					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder
					ColorPickerMain["b5"] = Instance.new("Frame", ColorPickerMain["a6"]);
					ColorPickerMain["b5"].BorderSizePixel = 0;
					ColorPickerMain["b5"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["b5"].AnchorPoint = Vector2.new(0, 1);
					ColorPickerMain["b5"].Size = UDim2.new(0, 152, 0, 40);
					ColorPickerMain["b5"].Position = UDim2.new(0, 10, 1, -175);
					ColorPickerMain["b5"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					ColorPickerMain["b5"].Name = [[CurrentColorHolder]];
					ColorPickerMain["b5"].BackgroundTransparency = 1;


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.UIStroke
					ColorPickerMain["b6"] = Instance.new("UIStroke", ColorPickerMain["b5"]);
					ColorPickerMain["b6"].Thickness = 2;
					ColorPickerMain["b6"].Color = Color3.fromRGB(90, 90, 90);

					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.UICorner
					ColorPickerMain["b7"] = Instance.new("UICorner", ColorPickerMain["b5"]);

					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID
					ColorPickerMain["b8"] = Instance.new("Frame", ColorPickerMain["b5"]);
					ColorPickerMain["b8"].BorderSizePixel = 0;
					ColorPickerMain["b8"].BackgroundColor3 = Color3.fromRGB(92, 92, 92);
					ColorPickerMain["b8"].AnchorPoint = Vector2.new(0, 0.5);
					ColorPickerMain["b8"].Size = UDim2.new(0.04986, 95, 0.825, -4);
					ColorPickerMain["b8"].Position = UDim2.new(-0.04261, 11, 0.4875, 0);
					ColorPickerMain["b8"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					ColorPickerMain["b8"].Name = [[ID]];
					ColorPickerMain["b8"].BackgroundTransparency = 0.4;


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.UICorner
					ColorPickerMain["b9"] = Instance.new("UICorner", ColorPickerMain["b8"]);
					ColorPickerMain["b9"].CornerRadius = UDim.new(0, 4);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.TextBox
					ColorPickerMain["ba"] = Instance.new("TextBox", ColorPickerMain["b8"]);
					ColorPickerMain["ba"].CursorPosition = -1;
					ColorPickerMain["ba"].PlaceholderColor3 = Color3.fromRGB(179, 179, 179);
					ColorPickerMain["ba"].BorderSizePixel = 0;
					ColorPickerMain["ba"].TextSize = 14;
					ColorPickerMain["ba"].TextColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["ba"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["ba"].FontFace = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
					ColorPickerMain["ba"].PlaceholderText = [[Color]];
					ColorPickerMain["ba"].Size = UDim2.new(1, 0, 1, 0);
					ColorPickerMain["ba"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					ColorPickerMain["ba"].Text = [[]];
					ColorPickerMain["ba"].BackgroundTransparency = 1;


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.TextBox.UIPadding
					ColorPickerMain["bb"] = Instance.new("UIPadding", ColorPickerMain["ba"]);
					ColorPickerMain["bb"].PaddingRight = UDim.new(0, 5);


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.Color
					ColorPickerMain["bc"] = Instance.new("Frame", ColorPickerMain["b5"]);
					ColorPickerMain["bc"].Active = true;
					ColorPickerMain["bc"].BorderSizePixel = 0;
					ColorPickerMain["bc"].BackgroundColor3 = Color3.fromRGB(255, 0, 5);
					ColorPickerMain["bc"].AnchorPoint = Vector2.new(0, 0.5);
					ColorPickerMain["bc"].Size = UDim2.new(0, 35, 0, 28);
					ColorPickerMain["bc"].Position = UDim2.new(0.72579, 1, 0.489, 0);
					ColorPickerMain["bc"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					ColorPickerMain["bc"].Name = [[Color]];


					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.Color.UICorner
					ColorPickerMain["bd"] = Instance.new("UICorner", ColorPickerMain["bc"]);
					ColorPickerMain["bd"].CornerRadius = UDim.new(0, 4);

					do
						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder
						ColorPickerMain["b51"] = Instance.new("Frame", ColorPickerMain["a6"]);
						ColorPickerMain["b51"]["BorderSizePixel"] = 0;
						ColorPickerMain["b51"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						ColorPickerMain["b51"]["AnchorPoint"] = Vector2.new(0, 1);
						ColorPickerMain["b51"]["Size"] = UDim2.new(0, 152, 0, 40);
						ColorPickerMain["b51"]["Position"] = UDim2.new(0, 10, 1, -125);
						ColorPickerMain["b51"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						ColorPickerMain["b51"]["Name"] = [[CurrentColorHolder]];
						ColorPickerMain["b51"]["BackgroundTransparency"] = 1;


						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.UIStroke
						ColorPickerMain["b61"] = Instance.new("UIStroke", ColorPickerMain["b51"]);
						ColorPickerMain["b61"]["Thickness"] = 2;
						ColorPickerMain["b61"]["Color"] = Color3.fromRGB(90, 90, 90);


						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.UICorner
						ColorPickerMain["b71"] = Instance.new("UICorner", ColorPickerMain["b51"]);



						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID
						ColorPickerMain["b81"] = Instance.new("ImageButton", ColorPickerMain["b51"]);
						ColorPickerMain["b81"]["BorderSizePixel"] = 0;
						ColorPickerMain["b81"]["BackgroundColor3"] = Color3.fromRGB(88, 88, 88);
						ColorPickerMain["b81"]["Size"] = UDim2.new(1,0,1,0);
						ColorPickerMain["b81"]["Position"] = UDim2.new(0,0,0,0);
						ColorPickerMain["b81"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						ColorPickerMain["b81"]["Name"] = [[ID]];
						ColorPickerMain["b81"].AutoButtonColor = false
						ColorPickerMain["b81"]["BackgroundTransparency"] = 0.55;


						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.UICorner
						ColorPickerMain["b91"] = Instance.new("UICorner", ColorPickerMain["b81"]);
						ColorPickerMain["b91"]["CornerRadius"] = UDim.new(0, 4);


						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.TextBox
						ColorPickerMain["ba1"] = Instance.new("TextLabel", ColorPickerMain["b81"]);
						ColorPickerMain["ba1"]["BorderSizePixel"] = 0;
						ColorPickerMain["ba1"]["TextSize"] = 15;
						ColorPickerMain["ba1"]["TextColor3"] = Color3.fromRGB(210, 210, 210);
						ColorPickerMain["ba1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
						ColorPickerMain["ba1"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
						ColorPickerMain["ba1"]["Size"] = UDim2.new(1, 0, 1, 0);
						ColorPickerMain["ba1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
						ColorPickerMain["ba1"]["Text"] = [[Set Color]];
						ColorPickerMain["ba1"]["BackgroundTransparency"] = 1;


						-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.CurrentColorHolder.ID.TextBox.UIPadding
						ColorPickerMain["bb1"] = Instance.new("UIPadding", ColorPickerMain["ba1"]);
						ColorPickerMain["bb1"]["PaddingRight"] = UDim.new(0, 5);

					end

					-- StarterGui.Gui.Window.ColorPickerPopup.ColorPicker_Big.UIStroke
					ColorPickerMain["be"] = Instance.new("UIStroke", ColorPickerMain["a6"]);
					ColorPickerMain["be"].Transparency = 0.5;
					ColorPickerMain["be"].Thickness = 2;
					ColorPickerMain["be"].Color = Color3.fromRGB(45, 45, 45);
					
					ColorPickerMain["eee"] = Instance.new("ImageButton", ColorPickerMain["a3"]);
					ColorPickerMain["eee"].BorderSizePixel = 0;
					ColorPickerMain["eee"].AutoButtonColor = false;
					ColorPickerMain["eee"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					ColorPickerMain["eee"].ImageColor3 = Color3.fromRGB(201, 201, 201);
					ColorPickerMain["eee"].AnchorPoint = Vector2.new(1, 0);
					ColorPickerMain["eee"].Image = [[rbxassetid://10747384394]];
					ColorPickerMain["eee"].Size = UDim2.new(0, 30, 0, 30);
					
					ColorPickerMain["eee"].BackgroundTransparency = 1;
					ColorPickerMain["eee"].BorderColor3 = Color3.fromRGB(0, 0, 0);
					ColorPickerMain["eee"].Position = UDim2.new(1, -10, 0, 10);

				end
				
				--// UI Colorpicker THING	
				do
					local hue, sat, val = 0, 1, 1

					local tempcolor = ColorPickerSmall.Value

					local function updatePreview()
						local color = Color3.fromHSV(hue, sat, val)
						ColorPickerMain["bc"].BackgroundColor3 = color

						local r,g,b = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)

						local rgb = Color3.fromRGB(r,g,b)

						tempcolor = rgb
					end
					
					ColorPickerMain["b81"].MouseButton1Click:Connect(function()
						opt.Callback(tempcolor)
						ColorPickerSmall["73"].BackgroundColor3 = tempcolor
						ColorPickerSmall.Value = tempcolor
					end)

					local function RGBTOHSV(color)
						local r, g, b = color.R, color.G, color.B
						local max = math.max(r, g, b)
						local min = math.min(r, g, b)
						local delta = max - min
						local h, s, v = 0, 0, max

						if delta == 0 then
							h = 0
						elseif max == r then
							h = ((g - b) / delta) % 6
						elseif max == g then
							h = ((b - r) / delta) + 2
						else
							h = ((r - g) / delta) + 4
						end

						h = h / 6

						if max == 0 then
							s = 0
						else
							s = delta / max
						end

						return h, s, v
					end
					
					local function parseRGB(text)
						local r, g, b = text:match("(%d+),%s*(%d+),%s*(%d+)")
						r, g, b = tonumber(r), tonumber(g), tonumber(b)
						if r and g and b and r <= 255 and g <= 255 and b <= 255 then
							return Color3.fromRGB(r, g, b)
						end
						return winT:CreateNotification({
							Title = "Warning",
							Description = "Please set a valid RGB Color",
							Image = "rbxassetid://115091969838952",
							Time = 5,
						})
					end

					
					function ColorPickerMain:setColor(color)
						hue, sat, val = RGBTOHSV(color)
						-- Update selector position in color area
						local b0 = ColorPickerMain["b0"]
						local x = hue * b0.AbsoluteSize.X
						local y = (1 - sat) * b0.AbsoluteSize.Y
						ColorPickerMain["b4"].Position = UDim2.new(0, x, 0, y)
						-- Update val slider position
						local ad = ColorPickerMain["ad"]
						local valY = (1 - val) * ad.AbsoluteSize.Y
						ColorPickerMain["af"].Position = UDim2.new(0.5, 0, 0, valY)
						-- Update preview background color
						updatePreview()
					end

					
					ColorPickerMain["ba"].FocusLost:Connect(function(enterpressed)
						if enterpressed then
							local input = ColorPickerMain["ba"].Text
							local color = parseRGB(input)
							if color then
								ColorPickerMain:setColor(color)
							end

						end
					end)
					
					ColorPickerMain["b0"].InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							local moveConn
							moveConn = RunService.RenderStepped:Connect(function()
								local pos = Vector2.new(
									math.clamp(Mouse.X - ColorPickerMain["b0"].AbsolutePosition.X, 0, ColorPickerMain["b0"].AbsoluteSize.X),
									math.clamp(Mouse.Y - ColorPickerMain["b0"].AbsolutePosition.Y, 0, ColorPickerMain["b0"].AbsoluteSize.Y)
								)
								hue = pos.X / ColorPickerMain["b0"].AbsoluteSize.X
								sat = 1 - (pos.Y / ColorPickerMain["b0"].AbsoluteSize.Y)
								ColorPickerMain["b4"].Position = UDim2.new(0, pos.X, 0, pos.Y)
								updatePreview()
							end)
							input.Changed:Connect(function()
								if input.UserInputState == Enum.UserInputState.End then
									moveConn:Disconnect()
								end
							end)
						end
					end)

					ColorPickerMain["ad"].InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							local moveConn
							moveConn = RunService.RenderStepped:Connect(function()
								local y = math.clamp(Mouse.Y - ColorPickerMain["ad"].AbsolutePosition.Y, 0, ColorPickerMain["ad"].AbsoluteSize.Y)
								val = 1 - (y / ColorPickerMain["ad"].AbsoluteSize.Y)
								ColorPickerMain["af"].Position = UDim2.new(0.5, 0, 0, y)
								updatePreview()
							end)
							input.Changed:Connect(function()
								if input.UserInputState == Enum.UserInputState.End then
									moveConn:Disconnect()
								end
							end)
						end
					end)
				end
				
				--// Functionality \\--
				do
					local transparencyTable = {}
					local parent = ColorPickerMain["a3"]

					-- Collect original transparencies
					for _, obj in ipairs(parent:GetDescendants()) do
						local data = {}

						if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
							data.TextTransparency = obj.TextTransparency
							data.BackgroundTransparency = obj.BackgroundTransparency
						elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
							data.ImageTransparency = obj.ImageTransparency
							data.BackgroundTransparency = obj.BackgroundTransparency
						elseif obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
							data.BackgroundTransparency = obj.BackgroundTransparency
							data.Transparency = obj.Transparency
						end

						local stroke = obj:FindFirstChildOfClass("UIStroke")
						if stroke then
							data.UIStrokeTransparency = stroke.Transparency
						end

						if next(data) ~= nil then
							transparencyTable[obj] = data
						end
					end

					-- Fade out using tween
					function ColorPickerMain:FadeOutAll()
						parent.Transparency = 1
						for obj, data in pairs(transparencyTable) do
							if data.TextTransparency then
								obj.TextTransparency = 1
							end
							if data.ImageTransparency then
								obj.ImageTransparency = 1
							end
							if data.BackgroundTransparency then
								obj.BackgroundTransparency = 1
							end
							if data.Transparency then
								obj.Transparency = 1
							end

							local stroke = obj:FindFirstChildOfClass("UIStroke")
							if stroke and data.UIStrokeTransparency then
								stroke.Transparency = 1
							end
						end
					end

					function ColorPickerMain:FadeOutAllTween(callback)
						Library:tween(parent, {Transparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
						for obj, data in pairs(transparencyTable) do
							if data.TextTransparency then
								Library:tween(obj, {TextTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end
							if data.ImageTransparency then
								Library:tween(obj, {ImageTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end
							if data.BackgroundTransparency then
								Library:tween(obj, {BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end

							local stroke = obj:FindFirstChildOfClass("UIStroke")
							if stroke and data.UIStrokeTransparency then
								Library:tween(stroke, {Transparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out,function()
									callback()
								end)
							end
						end
					end
				
					-- Reset to original using tween
					function ColorPickerMain:ResetAll()
						Library:tween(parent, {Transparency = 0}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
						for obj, data in pairs(transparencyTable) do
							if data.TextTransparency then
								Library:tween(obj, {TextTransparency = data.TextTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end
							if data.ImageTransparency then
								Library:tween(obj, {ImageTransparency = data.ImageTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end
							if data.BackgroundTransparency then
								Library:tween(obj, {BackgroundTransparency = data.BackgroundTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end

							local stroke = obj:FindFirstChildOfClass("UIStroke")
							if stroke and data.UIStrokeTransparency then
								Library:tween(stroke, {Transparency = data.UIStrokeTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
							end
						end
					end
					ColorPickerMain:FadeOutAll()
					task.wait(.1)
					ColorPickerMain:ResetAll()
					
					ColorPickerMain["eee"].MouseButton1Click:Connect(function()
						ColorPickerMain:FadeOutAllTween(function()
							ColorPickerMain["a3"]:Destroy()
							ColorPickerSmall.isOpened = false
						end)
					end)	
				end
				
				return ColorPickerMain
			end

			
			--// Create UI \\--
			do
				ColorPickerSmall["72"] = Instance.new("Frame", Tab["38"]);
				ColorPickerSmall["72"].Active = false;
				ColorPickerSmall["72"].Size = UDim2.new(1, -12, 0, 50);
				ColorPickerSmall["72"].BackgroundTransparency = 0.9;
				ColorPickerSmall["72"].Name = [[ColorPicker]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.ColorPicker.Iq844
				ColorPickerSmall["73"] = Instance.new("ImageButton", ColorPickerSmall["72"]);
				ColorPickerSmall["73"].BorderSizePixel = 0;
				ColorPickerSmall["73"].BackgroundColor3 = ColorPickerSmall.Value;
				ColorPickerSmall["73"].AnchorPoint = Vector2.new(1, 0);
				ColorPickerSmall["73"].Size = UDim2.new(0, 45, 0, 25);
				ColorPickerSmall["73"].Position = UDim2.new(1.024, -20, 0, 12);
				ColorPickerSmall["73"].Name = [[Iq844]];
				ColorPickerSmall["73"].AutoButtonColor = false


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.ColorPicker.Iq844.UICorner
				ColorPickerSmall["74"] = Instance.new("UICorner", ColorPickerSmall["73"]);
				ColorPickerSmall["74"].CornerRadius = UDim.new(0, 10);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.ColorPicker.UICorner
				ColorPickerSmall["75"] = Instance.new("UICorner", ColorPickerSmall["72"]);
				ColorPickerSmall["75"].CornerRadius = UDim.new(0, 14);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.ColorPicker.Title
				ColorPickerSmall["76"] = Instance.new("TextLabel", ColorPickerSmall["72"]);
				ColorPickerSmall["76"].TextSize = 18;
				ColorPickerSmall["76"].TextXAlignment = Enum.TextXAlignment.Left;
				ColorPickerSmall["76"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				ColorPickerSmall["76"].TextColor3 = Color3.fromRGB(201, 201, 201);
				ColorPickerSmall["76"].BackgroundTransparency = 1;
				ColorPickerSmall["76"].Size = UDim2.new(0, 0, 0.5, 0);
				ColorPickerSmall["76"].Text = [[Color Picker]];
				ColorPickerSmall["76"].AutomaticSize = Enum.AutomaticSize.X;
				ColorPickerSmall["76"].Name = [[Title]];
				ColorPickerSmall["76"].Position = UDim2.new(0, 10, 0, 12);
			end
			
			--// Functionaly \\--
			do
				ColorPickerSmall["73"].MouseButton1Click:Connect(function()
					if not ColorPickerSmall.isOpened then
						local colorpickerUi = ColorPickerSmall:OpenColorPicker()
						colorpickerUi:setColor(ColorPickerSmall.Value)
					end
				end)

			end
			
			return ColorPickerSmall
		end
		
		function Tab:CreateSection(text)
			local Section = {}
			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Section
			Section["6e"] = Instance.new("TextLabel", Tab["38"]);
			Section["6e"].TextWrapped = true;
			Section["6e"].BorderSizePixel = 0;
			Section["6e"].TextSize = 17;
			Section["6e"].TextXAlignment = Enum.TextXAlignment.Left;
			Section["6e"].TextYAlignment = Enum.TextYAlignment.Center
			Section["6e"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Section["6e"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
			Section["6e"].TextColor3 = Color3.fromRGB(255, 255, 255);
			Section["6e"].BackgroundTransparency = 1;
			Section["6e"].Size = UDim2.new(1, 0, 0, 0);
			Section["6e"].BorderColor3 = Color3.fromRGB(0, 0, 0);
			Section["6e"].Text = text;
			Section["6e"].AutomaticSize = Enum.AutomaticSize.Y
			Section["6e"].Name = [[Section]];


			-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Section.UIPadding
			Section["6f"] = Instance.new("UIPadding", Section["6e"]);
			Section["6f"].PaddingLeft = UDim.new(0, 10);
		end
		
		return Tab	
	end
	
	function winT:CreateSection(text)
		local Section = {}
		
		Section["15"] = Instance.new("TextLabel", winT["12"]);
		Section["15"].TextWrapped = true;
		Section["15"].BorderSizePixel = 0;
		Section["15"].TextSize = 17;
		Section["15"].TextXAlignment = Enum.TextXAlignment.Left;
		Section["15"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Section["15"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
		Section["15"].TextColor3 = Color3.fromRGB(255, 255, 255);
		Section["15"].BackgroundTransparency = 1;
		Section["15"].Size = UDim2.new(1, 0, 0, 25);
		Section["15"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Section["15"].Text = text;
		Section["15"].Name = [[Section]];


		-- StarterGui.Gui.Window.Main.Side-Bar.Iq844.Section.UIPadding
		Section["16"] = Instance.new("UIPadding", Section["15"]);
		Section["16"].PaddingLeft = UDim.new(0, 6);
	end
	
	function winT:CreatePopUp(opt)
		opt = Library:Validate({
			Title = "Popup",
			Description = "Description",
			OkbuttonCallback = function() end,
			CancelbuttonCallback = function() end,
		}, opt or {})
		
		local Popup = {}
		
		--// UI \\--
		do
			Popup["a0"] = Instance.new("ImageButton", winT["2"]);
			Popup["a0"].Visible = true;
			Popup["a0"].ZIndex = 2;
			Popup["a0"].AutoButtonColor = false
			Popup["a0"].BorderSizePixel = 0;
			Popup["a0"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Popup["a0"].Size = UDim2.new(1, 0, 1, 0);
			Popup["a0"].BorderColor3 = Color3.fromRGB(0, 0, 0);
			Popup["a0"].Name = [[Popup]];
			Popup["a0"].Modal = true;


			-- StarterGui.Gui.Window.Popup.UICorner
			Popup["a1"] = Instance.new("UICorner", Popup["a0"]);
			Popup["a1"].CornerRadius = UDim.new(0, 16);


			-- StarterGui.Gui.Window.Popup.UIGradient
			Popup["a2"] = Instance.new("UIGradient", Popup["a0"]);
			Popup["a2"].Rotation = 90;
			Popup["a2"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0.15),NumberSequenceKeypoint.new(1, 0.15)};
			Popup["a2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 0, 0))};


			-- StarterGui.Gui.Window.Popup.PopUpMain
			Popup["a3"] = Instance.new("Frame", Popup["a0"]);
			Popup["a3"].BackgroundColor3 = Color3.fromRGB(36, 36, 37);
			Popup["a3"].AnchorPoint = Vector2.new(0.5, 0.5);
			Popup["a3"].ClipsDescendants = true;
			Popup["a3"].Size = UDim2.new(0, 405, 0, 250);
			Popup["a3"].Position = UDim2.new(0.5, 0, 0.5, 0);
			Popup["a3"].Name = [[PopUpMain]];
			Popup["a3"].BackgroundTransparency = 0.45;




			-- StarterGui.Gui.Window.Popup.PopUpMain.UICorner
			Popup["a4"] = Instance.new("UICorner", Popup["a3"]);
			Popup["a4"].CornerRadius = UDim.new(0, 14);


			-- StarterGui.Gui.Window.Popup.PopUpMain.Title
			Popup["a5"] = Instance.new("TextLabel", Popup["a3"]);
			Popup["a5"].TextSize = 22;
			Popup["a5"].TextXAlignment = Enum.TextXAlignment.Left;
			Popup["a5"].BackgroundColor3 = Color3.fromRGB(253, 251, 255);
			Popup["a5"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Popup["a5"].TextColor3 = Color3.fromRGB(236, 236, 236);
			Popup["a5"].BackgroundTransparency = 1;
			Popup["a5"].AnchorPoint = Vector2.new(0.5, 0);
			Popup["a5"].Size = UDim2.new(0, 0, 0, 25);
			Popup["a5"].Text = opt.Title;
			Popup["a5"].AutomaticSize = Enum.AutomaticSize.X;
			Popup["a5"].Name = [[Title]];
			Popup["a5"].Position = UDim2.new(0.5, 0, 0, 7);


			-- StarterGui.Gui.Window.Popup.PopUpMain.Text
			Popup["a6"] = Instance.new("TextLabel", Popup["a3"]);
			Popup["a6"].TextWrapped = true;
			Popup["a6"].TextSize = 20;
			Popup["a6"].TextXAlignment = Enum.TextXAlignment.Left;
			Popup["a6"].TextYAlignment = Enum.TextYAlignment.Top;
			Popup["a6"].BackgroundColor3 = Color3.fromRGB(253, 251, 255);
			Popup["a6"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Popup["a6"].TextColor3 = Color3.fromRGB(201, 201, 201);
			Popup["a6"].BackgroundTransparency = 1;
			Popup["a6"].AnchorPoint = Vector2.new(0.5, 0);
			Popup["a6"].Size = UDim2.new(0, 371, 0, 130);
			Popup["a6"].Text = opt.Description;
			Popup["a6"].AutomaticSize = Enum.AutomaticSize.X;
			Popup["a6"].Name = [[Text]];
			Popup["a6"].Position = UDim2.new(0.49, 0, 0.15, 7);

			
			-- StarterGui.Gui.Window.Popup.PopUpMain.Text.UIPadding
			Popup["a7"] = Instance.new("UIPadding", Popup["a6"]);
			Popup["a7"].PaddingTop = UDim.new(0, 5);
			Popup["a7"].PaddingRight = UDim.new(0, 5);
			Popup["a7"].PaddingLeft = UDim.new(0, 5);
			Popup["a7"].PaddingBottom = UDim.new(0, 5);


			-- StarterGui.Gui.Window.Popup.PopUpMain.TextButton
			Popup["a8"] = Instance.new("TextButton", Popup["a3"]);
			Popup["a8"].BorderSizePixel = 0;
			Popup["a8"].TextColor3 = Color3.fromRGB(255, 255, 255);
			Popup["a8"].TextSize = 14;
			Popup["a8"].BackgroundColor3 = Color3.fromRGB(59, 59, 59);
			Popup["a8"].FontFace = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Popup["a8"].Size = UDim2.new(0, 70, 0, 37);
			Popup["a8"].BackgroundTransparency = 0.5;
			Popup["a8"].BorderColor3 = Color3.fromRGB(255, 255, 255);
			Popup["a8"].Text = [[Cancel]];
			Popup["a8"].Position = UDim2.new(0.51364, 0, 0.816, 0);
			Popup["a8"].AutoButtonColor = false


			-- StarterGui.Gui.Window.Popup.PopUpMain.TextButton.UICorner
			Popup["a9"] = Instance.new("UICorner", Popup["a8"]);
			Popup["a9"].CornerRadius = UDim.new(0, 6);


			-- StarterGui.Gui.Window.Popup.PopUpMain.TextButton.UIStroke
			Popup["aa"] = Instance.new("UIStroke", Popup["a8"]);
			Popup["aa"].Transparency = 0.76;
			Popup["aa"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			Popup["aa"].Thickness = 2;
			Popup["aa"].Color = Color3.fromRGB(141, 141, 141);


			-- StarterGui.Gui.Window.Popup.ColorPicker_Big.TextButton
			Popup["ab"] = Instance.new("TextButton", Popup["a3"]);
			Popup["ab"].BorderSizePixel = 0;
			Popup["ab"].TextColor3 = Color3.fromRGB(255, 255, 255);
			Popup["ab"].TextSize = 14;
			Popup["ab"].BackgroundColor3 = Color3.fromRGB(59, 59, 59);
			Popup["ab"].FontFace = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
			Popup["ab"].Size = UDim2.new(0, 70, 0, 37);
			Popup["ab"].BackgroundTransparency = 0.5;
			Popup["ab"].BorderColor3 = Color3.fromRGB(255, 255, 255);
			Popup["ab"].Text = [[Ok]];
			Popup["ab"].Position = UDim2.new(0.31776, 0, 0.816, 0);
			Popup["ab"].AutoButtonColor = false


			-- StarterGui.Gui.Window.Popup.ColorPicker_Big.TextButton.UICorner
			Popup["ac"] = Instance.new("UICorner", Popup["ab"]);
			Popup["ac"].CornerRadius = UDim.new(0, 6);


			-- StarterGui.Gui.Window.Popup.ColorPicker_Big.TextButton.UIStroke
			Popup["ad"] = Instance.new("UIStroke", Popup["ab"]);
			Popup["ad"].Transparency = 0.76;
			Popup["ad"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			Popup["ad"].Thickness = 2;
			Popup["ad"].Color = Color3.fromRGB(141, 141, 141);


			-- StarterGui.Gui.Window.Popup.ColorPicker_Big.UIStroke
			Popup["ae"] = Instance.new("UIStroke", Popup["a3"]);
			Popup["ae"].Transparency = 0.76;
			Popup["ae"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			Popup["ae"].Thickness = 2;
			Popup["ae"].Color = Color3.fromRGB(141, 141, 141);
		end
		
		--// Func \\--
		do
			Popup["a0"].Transparency = 1
			for i,v in Popup["a0"]:GetDescendants() do
				if v:IsA("TextButton") or v:IsA("TextLabel") then
					v.TextTransparency = 1
				end
				if v:IsA("ImageButton") or v:IsA("ImageLabel") then
					v.ImageTransparency = 1
				end
				if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("ImageButton") or v:IsA("ImageLabel") or v:IsA("Frame") or v:IsA("UIStroke")  then
					v.Transparency = 1
				end
			end
			
			do
				Library:tween(Popup["a0"],{Transparency = 0},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["a3"],{BackgroundTransparency = 0.45},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["a5"],{TextTransparency = 0},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["a8"],{TextTransparency = 0},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["ab"],{BackgroundTransparency = 0.5},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["a8"],{BackgroundTransparency = 0.5},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["ab"],{TextTransparency = 0},0.6,Enum.EasingStyle.Exponential)
				Library:tween(Popup["a6"],{TextTransparency = 0},0.6,Enum.EasingStyle.Exponential)
				
				for i,v in Popup["a0"]:GetDescendants() do
					if v:IsA("UIStroke")  then
						Library:tween(v,{Transparency = 0.76},0.6,Enum.EasingStyle.Exponential)
					end
				end
			end
			
			Popup["a8"].MouseButton1Click:Connect(function()
				opt.CancelbuttonCallback()
				Library:tween(Popup["a0"],{Transparency = 1},0.6,Enum.EasingStyle.Exponential)
				for i,v in Popup["a0"]:GetDescendants() do
					if v:IsA("TextButton") or v:IsA("TextLabel") then
						Library:tween(v,{TextTransparency = 1},0.6,Enum.EasingStyle.Exponential)
					end
					if v:IsA("ImageButton") or v:IsA("ImageLabel") then
						Library:tween(v,{ImageTransparency = 1},0.6,Enum.EasingStyle.Exponential)	
					end
					if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("ImageButton") or v:IsA("ImageLabel") or v:IsA("Frame") or v:IsA("UIStroke")  then
						Library:tween(v,{Transparency = 1},0.6,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,function()
							task.spawn(function()
								Popup["a0"]:Destroy()
							end)
						end)	
					end
				end
			end)
			
			Popup["ab"].MouseButton1Click:Connect(function()
				opt.OkbuttonCallback()
				Library:tween(Popup["a0"],{Transparency = 1},0.6,Enum.EasingStyle.Exponential)
				for i,v in Popup["a0"]:GetDescendants() do
					if v:IsA("TextButton") or v:IsA("TextLabel") then
						Library:tween(v,{TextTransparency = 1},0.6,Enum.EasingStyle.Exponential)
					end
					if v:IsA("ImageButton") or v:IsA("ImageLabel") then
						Library:tween(v,{ImageTransparency = 1},0.6,Enum.EasingStyle.Exponential)	
					end
					if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("ImageButton") or v:IsA("ImageLabel") or v:IsA("Frame") or v:IsA("UIStroke")  then
						Library:tween(v,{Transparency = 1},0.6,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,function()
							task.spawn(function()
								task.wait(1)
								Popup["a8"]:Destroy()
							end)
						end)	
					end
				end
			end)
			
		end
		
		return Popup
	end
	
	local notificationStack = {}

	function winT:CreateNotification(opt)
		opt = Library:Validate({
			Title = "Notification",
			Description = "Description",
			Image = "rbxassetid://115091969838952",
			Time = 5,
		}, opt or {})

		local STX_Notification = Instance.new("Frame")
		local AmbientShadow = Instance.new("ImageLabel")
		local Window = Instance.new("Frame")
		local Outline_A = Instance.new("Frame")
		local WindowTitle = Instance.new("TextLabel")
		local WindowDescription = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local ImageButton = Instance.new("ImageLabel")

		STX_Notification.Transparency = 1
		STX_Notification.Parent = winT["1"]
		STX_Notification.Size = UDim2.new(1, 0, 1, 0)
		STX_Notification.BackgroundTransparency = 1

		AmbientShadow.Name = "AmbientShadow"
		AmbientShadow.Parent = STX_Notification
		AmbientShadow.AnchorPoint = Vector2.new(1, 0)
		AmbientShadow.BackgroundTransparency = 1.000
		AmbientShadow.BorderSizePixel = 0
		AmbientShadow.Position = UDim2.new(1, -8, 0, -88) -- start above screen
		AmbientShadow.Size = UDim2.new(0, 240, 0, 88)
		AmbientShadow.Image = "rbxassetid://1316045217"
		AmbientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		AmbientShadow.ImageTransparency = 0.400
		AmbientShadow.ScaleType = Enum.ScaleType.Slice
		AmbientShadow.SliceCenter = Rect.new(10, 10, 118, 118)
		AmbientShadow.ClipsDescendants = true

		Window.Name = "Window"
		Window.Parent = AmbientShadow
		Window.Active = true
		Window.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Window.BorderSizePixel = 0
		Window.Transparency = 0.1
		Window.Position = UDim2.new(0, 5, 0, 5)
		Window.Size = UDim2.new(0, 230, 0, 80)
		Window.ZIndex = 2

		Outline_A.Name = "Outline_A"
		Outline_A.Parent = Window
		Outline_A.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Outline_A.BorderSizePixel = 0
		Outline_A.Position = UDim2.new(0, 0, 0, 25)
		Outline_A.Size = UDim2.new(0, 230, 0, 2)
		Outline_A.ZIndex = 5

		WindowTitle.Name = "WindowTitle"
		WindowTitle.Parent = Window
		WindowTitle.BackgroundTransparency = 1
		WindowTitle.Position = UDim2.new(0, 25, 0, 4)
		WindowTitle.Size = UDim2.new(0, 195, 0, 18)
		WindowTitle.ZIndex = 4
		WindowTitle.Font = Enum.Font.GothamBold
		WindowTitle.Text = opt.Title
		WindowTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
		WindowTitle.TextSize = 12
		WindowTitle.TextWrapped = true
		WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

		WindowDescription.Name = "WindowDescription"
		WindowDescription.Parent = Window
		WindowDescription.BackgroundTransparency = 1
		WindowDescription.Position = UDim2.new(0, 8, 0, 34)
		WindowDescription.Size = UDim2.new(0, 216, 0, 40)
		WindowDescription.ZIndex = 4
		WindowDescription.Font = Enum.Font.GothamBold
		WindowDescription.Text = opt.Description
		WindowDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
		WindowDescription.TextSize = 12
		WindowDescription.TextWrapped = true
		WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
		WindowDescription.TextYAlignment = Enum.TextYAlignment.Top

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = Window

		ImageButton.Name = "ImageButton"
		ImageButton.Parent = Window
		ImageButton.BackgroundTransparency = 1
		ImageButton.Position = UDim2.new(0, 4, 0, 4)
		ImageButton.Size = UDim2.new(0, 18, 0, 18)
		ImageButton.ZIndex = 5
		ImageButton.Image = opt.Image
		ImageButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

		local offset = 0
		for i, v in notificationStack do
			offset += 88 + 8
		end

		local targetpos = UDim2.new(1, -8, 0, offset)

		table.insert(notificationStack, AmbientShadow)

		Library:tween(AmbientShadow, {Position = targetpos}, 0.5, Enum.EasingStyle.Exponential)
		Library:tween(Outline_A, {Size = UDim2.new(0, 0, 0, 2) }, opt.Time, Enum.EasingStyle.Linear)

		task.spawn(function()
			task.spawn(function()
			task.wait(opt.Time)
			local shadow = table.find(notificationStack,AmbientShadow)
			table.remove(notificationStack, shadow)
			Library:tween(AmbientShadow, {Position = UDim2.new(1, -8, 0, -88)}, 0.4, Enum.EasingStyle.Exponential)
			task.wait(0.4)
			if shadow then
				local isLast = (shadow == #notificationStack)
				
				if isLast == false then
					for i, notif in ipairs(notificationStack) do
						local y = (i - 1) * 96 + 8
						Library:tween(notif, {
							Position = UDim2.new(1, -8, 0, y)
						}, 0.3, Enum.EasingStyle.Exponential)
					end
				else
					if #notificationStack > 0 then
						Library:tween(notificationStack[#notificationStack], {Position = UDim2.new(1, -8, 0, -8)}, 0.3, Enum.EasingStyle.Exponential)
					end
				end
				AmbientShadow:Destroy()
			end

		end)


		end)


	end

	
	local Settings = {}
	--settings
	do
		-- StarterGui.Gui.Window.Settings
		winT["af"] = Instance.new("ImageButton", winT["2"]);
		winT["af"].Visible = false;
		winT["af"].ZIndex = 2;
		winT["af"].BorderSizePixel = 0;
		winT["af"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		winT["af"].Size = UDim2.new(1, 0, 1, 0);
		winT["af"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		winT["af"].Name = [[Settings]];
		winT["af"].AutoButtonColor = false
		winT["af"].Modal = false
		
		
		-- StarterGui.Gui.Window.Settings.UICorner
		winT["b0"] = Instance.new("UICorner", winT["af"]);
		winT["b0"].CornerRadius = UDim.new(0, 16);

		-- StarterGui.Gui.Window.Settings.UIGradient
		winT["b1"] = Instance.new("UIGradient", winT["af"]);
		winT["b1"].Rotation = 90;
		winT["b1"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0.15),NumberSequenceKeypoint.new(1.000, 0.15)};
		winT["b1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(11, 0, 0))};

		local b2size 
		if winT.isTouch then
			b2size = UDim2.new(0, 405/1.7, 0, 300/1.7)
		else
			b2size = UDim2.new(0, 405, 0, 300)
		end

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big
		winT["b2"] = Instance.new("Frame", winT["af"]);
		winT["b2"].BackgroundColor3 = Color3.fromRGB(36, 36, 37);
		winT["b2"].AnchorPoint = Vector2.new(0.5, 0.5);
		winT["b2"].ClipsDescendants = true;
		winT["b2"].Size = b2size;
		winT["b2"].Position = UDim2.new(0.5, 0, 0.5, 0);
		winT["b2"].Name = [[ColorPicker_Big]];
		winT["b2"].BackgroundTransparency = 0.45;

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.UICorner
		winT["b3"] = Instance.new("UICorner", winT["b2"]);
		winT["b3"].CornerRadius = UDim.new(0, 14);

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.Title
		winT["b4"] = Instance.new("TextLabel", winT["b2"]);
		winT["b4"].TextSize = 23;
		winT["b4"].TextXAlignment = Enum.TextXAlignment.Left;
		winT["b4"].BackgroundColor3 = Color3.fromRGB(253, 251, 255);
		winT["b4"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
		winT["b4"].TextColor3 = Color3.fromRGB(236, 236, 236);
		winT["b4"].BackgroundTransparency = 1;
		winT["b4"].AnchorPoint = Vector2.new(0.5, 0);
		winT["b4"].Size = UDim2.new(0, 0, 0, 25);
		winT["b4"].Text = [[Settings]];
		winT["b4"].AutomaticSize = Enum.AutomaticSize.X;
		winT["b4"].Name = [[Title]];
		winT["b4"].Position = UDim2.new(0.5, 0, 0, 7);

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.UIStroke
		winT["b5"] = Instance.new("UIStroke", winT["b2"]);
		winT["b5"].Transparency = 0.76;
		winT["b5"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		winT["b5"].Thickness = 2;
		winT["b5"].Color = Color3.fromRGB(141, 141, 141);

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.ScrollingFrame
		winT["b6"] = Instance.new("ScrollingFrame", winT["b2"]);
		winT["b6"].ScrollingDirection = Enum.ScrollingDirection.Y;
		winT["b6"].BorderSizePixel = 0;
		winT["b6"].CanvasSize = UDim2.new(0, 0, 0, 0);
		winT["b6"].ElasticBehavior = Enum.ElasticBehavior.Never;
		winT["b6"].TopImage = [[rbxassetid://0]];
		winT["b6"].MidImage = [[rbxassetid://0]];
		winT["b6"].ScrollBarImageTransparency = 0.3;
		winT["b6"].BottomImage = [[rbxassetid://0]];
		winT["b6"].AutomaticCanvasSize = Enum.AutomaticSize.Y;
		winT["b6"].Size = UDim2.new(1, 0, 1, -45);
		winT["b6"].ScrollBarImageColor3 = Color3.fromRGB(201, 201, 201);
		winT["b6"].Position = UDim2.new(0, 0, 0, 45);
		winT["b6"].ScrollBarThickness = 6;
		winT["b6"].BackgroundTransparency = 1;

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.ScrollingFrame.UIListLayout
		winT["b7"] = Instance.new("UIListLayout", winT["b6"]);
		winT["b7"].HorizontalAlignment = Enum.HorizontalAlignment.Center;
		winT["b7"].Padding = UDim.new(0, 10);
		winT["b7"].SortOrder = Enum.SortOrder.LayoutOrder;

		-- StarterGui.Gui.Window.Settings.ColorPicker_Big.ScrollingFrame.UIPadding
		winT["b8"] = Instance.new("UIPadding", winT["b6"]);
		winT["b8"].PaddingTop = UDim.new(0, 4);
		winT["b8"].PaddingRight = UDim.new(0, 10);
		winT["b8"].PaddingLeft = UDim.new(0, 10);
		winT["b8"].PaddingBottom = UDim.new(0, 20);

		-- StarterGui.Gui.Window.Settings.ImageButton
		winT["c0"] = Instance.new("ImageButton", winT["af"]);
		winT["c0"].BorderSizePixel = 0;
		winT["c0"].AutoButtonColor = false;
		winT["c0"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		winT["c0"].ImageColor3 = Color3.fromRGB(201, 201, 201);
		winT["c0"].AnchorPoint = Vector2.new(1, 0);
		winT["c0"].Image = [[rbxassetid://10747384394]];
		winT["c0"].Size = UDim2.new(0, 30, 0, 30);
		winT["c0"].BackgroundTransparency = 1;
		winT["c0"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		winT["c0"].Position = UDim2.new(1, -10, 0, 10);
		
		function Settings:CreateButton(opt)
			opt = Library:Validate({
				Name = "Button",
				Callback = function() end
			},opt or {})

			local Button = {}

			do
				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button
				Button["56"] = Instance.new("ImageButton", winT["b6"]);
				Button["56"]["Active"] = false;
				Button["56"]["AutoButtonColor"] = false;
				Button["56"]["Selectable"] = false;
				Button["56"]["Size"] = UDim2.new(1, -12, 0, 45);
				Button["56"]["BackgroundTransparency"] = 0.9;
				Button["56"]["Name"] = [[Button]];


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844
				Button["57"] = Instance.new("TextButton", Button["56"]);
				Button["57"]["BorderSizePixel"] = 0;
				Button["57"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
				Button["57"]["AutoButtonColor"] = false;
				Button["57"]["TextSize"] = 14;
				Button["57"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
				Button["57"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Button["57"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Button["57"]["Size"] = UDim2.new(0, 52, 0, 28);
				Button["57"]["BackgroundTransparency"] = 0.5;
				Button["57"]["Name"] = [[Iq844]];
				Button["57"]["Text"] = [[]];
				Button["57"]["Position"] = UDim2.new(1, -60, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.UICorner
				Button["58"] = Instance.new("UICorner", Button["57"]);
				Button["58"]["CornerRadius"] = UDim.new(0, 10);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.UIStroke
				Button["59"] = Instance.new("UIStroke", Button["57"]);
				Button["59"]["Transparency"] = 0.5;
				Button["59"]["Color"] = Color3.fromRGB(31, 31, 31);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Iq844.ImageLabel
				Button["5a"] = Instance.new("ImageLabel", Button["57"]);
				Button["5a"]["BorderSizePixel"] = 0;
				Button["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["5a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Button["5a"]["Image"] = [[rbxassetid://10734898194]];
				Button["5a"]["Size"] = UDim2.new(0, 20, 0, 20);
				Button["5a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Button["5a"]["BackgroundTransparency"] = 1;
				Button["5a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.UICorner
				Button["5b"] = Instance.new("UICorner", Button["56"]);
				Button["5b"]["CornerRadius"] = UDim.new(0, 14);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Button.Title
				Button["5c"] = Instance.new("TextLabel", Button["56"]);
				Button["5c"]["TextSize"] = 18;
				Button["5c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Button["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Button["5c"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
				Button["5c"]["BackgroundTransparency"] = 1;
				Button["5c"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Button["5c"]["Size"] = UDim2.new(0, 0, 0.5, 0);
				Button["5c"]["Text"] = opt.Name;
				Button["5c"]["AutomaticSize"] = Enum.AutomaticSize.X;
				Button["5c"]["Name"] = [[Title]];
				Button["5c"]["Position"] = UDim2.new(0, 10, 0.5, 0);
			end

			Button["56"].MouseEnter:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -10, 0, 47)},0.3,Enum.EasingStyle.Circular)	
			end)

			Button["56"].MouseLeave:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -12, 0, 45)},0.3,Enum.EasingStyle.Circular)	
			end)

			Button["56"].MouseButton1Down:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -12+5, 0, 47+5)},0.3,Enum.EasingStyle.Circular)	
				opt.Callback()
			end)

			Button["56"].MouseButton1Up:Connect(function()
				Library:tween(Button["56"], {Size = UDim2.new(1, -10, 0, 47)},0.3,Enum.EasingStyle.Circular)	
			end)

			function Button:SetName(name)
				Button["5c"]["Text"] = name;
			end


			return Button
		end
		
		function Settings:CreateKeybind(opt)
			opt = Library:Validate({
				Name = "Toggle",
				DefaultBind = Enum.KeyCode.G,
				Callback = function(v) end
			},opt or {})

			local Keybind = {
				ActiveKeybind = nil
			}
			Keybind.ActiveKeybind = opt.DefaultBind

			-- // Create UI \\ --
			do
				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind
				Keybind["5f"] = Instance.new("Frame", winT["b6"]);
				Keybind["5f"].Size = UDim2.new(1, -12, 0, 50);
				Keybind["5f"].Name = [[Keybind]];
				Keybind["5f"].BackgroundTransparency = 0.9;


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.Iq844
				Keybind["60"] = Instance.new("TextButton", Keybind["5f"]);
				Keybind["60"].BorderSizePixel = 0;
				Keybind["60"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Keybind["60"].TextSize = 15;
				Keybind["60"].BackgroundColor3 = Color3.fromRGB(41, 41, 41);
				Keybind["60"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Keybind["60"].AnchorPoint = Vector2.new(1, 0);
				Keybind["60"].AutomaticSize = Enum.AutomaticSize.X;
				Keybind["60"].Size = UDim2.new(0, 45, 0, 25);
				Keybind["60"].Name = [[Iq844]];
				Keybind["60"].Text = [[None]];
				Keybind["60"].Position = UDim2.new(1, -10, 0.5, -12);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.Iq844.UICorner
				Keybind["61"] = Instance.new("UICorner", Keybind["60"]);
				Keybind["61"].CornerRadius = UDim.new(0, 10);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.Iq844.UIPadding
				Keybind["62"] = Instance.new("UIPadding", Keybind["60"]);
				Keybind["62"].PaddingRight = UDim.new(0, 8);
				Keybind["62"].PaddingLeft = UDim.new(0, 8);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.Iq844.UIStroke
				Keybind["63"] = Instance.new("UIStroke", Keybind["60"]);
				Keybind["63"].Transparency = 0.8;
				Keybind["63"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Keybind["63"].Thickness = 1.5;
				Keybind["63"].Color = Color3.fromRGB(181, 181, 181);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.UICorner
				Keybind["64"] = Instance.new("UICorner", Keybind["5f"]);
				Keybind["64"].CornerRadius = UDim.new(0, 14);


				-- StarterGui.Gui.Window.Main.Main.ScrollingFrame.Keybind.Title
				Keybind["65"] = Instance.new("TextLabel", Keybind["5f"]);
				Keybind["65"].TextSize = 18;
				Keybind["65"].TextXAlignment = Enum.TextXAlignment.Left;
				Keybind["65"].FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
				Keybind["65"].TextColor3 = Color3.fromRGB(201, 201, 201);
				Keybind["65"].BackgroundTransparency = 1;
				Keybind["65"].AnchorPoint = Vector2.new(0, 0.5);
				Keybind["65"].Size = UDim2.new(0, 0, 0.5, 0);
				Keybind["65"].Text = [[Keybind]];
				Keybind["65"].AutomaticSize = Enum.AutomaticSize.X;
				Keybind["65"].Name = opt.Name;
				Keybind["65"].Position = UDim2.new(0, 10, 0.5, 0);
			end

			-- // Functions \\ --
			do
				Keybind["60"].Text = Keybind.ActiveKeybind.Name

				local isListening = false

				Keybind["60"].MouseButton1Click:Connect(function()
					isListening = true
					Keybind["60"].Text = "..."
					local connection
					connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
						if not isListening then return end
						local uiType = input.UserInputType
						if uiType == Enum.UserInputType.Keyboard or (tostring(uiType):match("^Gamepad%d+$")) then
							local keyName = input.KeyCode.Name
							Keybind["60"].Text = keyName
							Keybind.ActiveKeybind = input.KeyCode
							isListening = false
							connection:Disconnect()
						end
					end)
				end)

				UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if input.KeyCode == Keybind.ActiveKeybind and not gameProcessed then
						opt.Callback(Keybind.ActiveKeybind)
					end
				end)

				function Keybind:SetKeybind(t)
					Keybind["60"].Text = t.Name
					Keybind.ActiveKeybind = t
				end

				function Keybind:SetName(t)
					Keybind["65"].Name = t
				end
			end

			return Keybind	
		end
		
		if not winT.isTouch then
			Settings:CreateKeybind({
				Name = "Pick Window Bind",
				DefaultBind = winT.Keybind,
				Callback = function(t)  
					TempBind = t
				end
			})
			
			Settings:CreateButton({
				Name = "Set Keybind",
				Callback = function()
					if TempBind ~= nil then
						winT:SetToggleKey(TempBind)
					else
						winT:CreateNotification({
				Title = "Info",
				Description = "The key for toggling The ui is " .. winT.Keybind.Name,
			})
					end
						
				end
			})
		end

		local transparencyTable = {}
		local parent = winT["af"]

		-- Collect original transparencies
		for _, obj in ipairs(parent:GetDescendants()) do
			local data = {}

			if obj:IsA("TextLabel") or obj:IsA("TextButton") then
				data.TextTransparency = obj.TextTransparency
				data.BackgroundTransparency = obj.BackgroundTransparency
			elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				data.ImageTransparency = obj.ImageTransparency
				data.BackgroundTransparency = obj.BackgroundTransparency
			elseif obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
				data.BackgroundTransparency = obj.BackgroundTransparency
			end

			local stroke = obj:FindFirstChildOfClass("UIStroke")
			if stroke then
				data.UIStrokeTransparency = stroke.Transparency
			end

			if next(data) ~= nil then
				transparencyTable[obj] = data
			end
		end

		-- Fade out using tween
		function Settings:FadeOutAll()
			winT["af"].Modal = false
			Library:tween(parent, {Transparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			for obj, data in pairs(transparencyTable) do
				if data.TextTransparency then
					Library:tween(obj, {TextTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end
				if data.ImageTransparency then
					Library:tween(obj, {ImageTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end
				if data.BackgroundTransparency then
					Library:tween(obj, {BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end

				local stroke = obj:FindFirstChildOfClass("UIStroke")
				if stroke and data.UIStrokeTransparency then
					Library:tween(stroke, {Transparency = 1}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out,function()
						winT["af"].Visible = false
					end)
				end
			end
		end

		-- Reset to original using tween
		local function ResetAll()
			winT["af"].Visible = true
			winT["af"].Modal = true
			Library:tween(parent, {Transparency = 0}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			for obj, data in pairs(transparencyTable) do
				if data.TextTransparency then
					Library:tween(obj, {TextTransparency = data.TextTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end
				if data.ImageTransparency then
					Library:tween(obj, {ImageTransparency = data.ImageTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end
				if data.BackgroundTransparency then
					Library:tween(obj, {BackgroundTransparency = data.BackgroundTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end

				local stroke = obj:FindFirstChildOfClass("UIStroke")
				if stroke and data.UIStrokeTransparency then
					Library:tween(stroke, {Transparency = data.UIStrokeTransparency}, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end
			end
		end
		Settings:FadeOutAll()
		
		winT["c0"].MouseButton1Click:Connect(function()
			Settings:FadeOutAll()
			winT["2f"].ImageColor3 = Color3.fromRGB(181, 181, 181);
			winT["2d"].TextColor3 = Color3.fromRGB(181, 181, 181);
			winT.SettingsEnabled = false
		end)
		
		winT["2c"].MouseButton1Click:Connect(function()
			ResetAll()
			winT["2f"].ImageColor3 = Color3.fromRGB(220, 220, 220);
			winT["2d"].TextColor3 = Color3.fromRGB(220, 220, 220);
			winT.SettingsEnabled = true
		end)
	end

	if not winT.isTouch then
		winT:CreateNotification({
			Title = "Info",
			Description = "The key for toggling The ui is " .. winT.Keybind.Name,
		})
	else
		winT:CreateNotification({
			Title = "Info",
			Description = "Mobile is supported!",
		})
	end
	
	
	function winT:ToggleVisibility()
		if winT.SettingsEnabled then
			Settings:FadeOutAll()
		end
		if winT.isMinimised then
			Library:tween(winT["2"],{Size = winT.MainWindowSize},0.5,Enum.EasingStyle.Exponential)
			winT.isMinimised = false
		else
			Library:tween(winT["2"],{Size = UDim2.new(0,winT.MainWindowSize.X.Offset,0,0)},0.5,Enum.EasingStyle.Exponential)
			winT.isMinimised = true
		end
	end
	
	if winT.isTouch then
		local minControl = {}
		
		-- StarterGui.Gui.Toggle
		minControl["c2"] = Instance.new("ImageButton", winT["1"]);
		minControl["c2"].ImageTransparency = 1;
		minControl["c2"].BackgroundColor3 = Color3.fromRGB(54, 54, 55);
		minControl["c2"].AnchorPoint = Vector2.new(0.5, 0);
		minControl["c2"].Size = UDim2.new(0, 35, 0, 35);
		minControl["c2"].BackgroundTransparency = 0.4;
		minControl["c2"].Name = [[Toggle]];
		minControl["c2"].Position = UDim2.new(0.5, 0, 0, 10);
		minControl["c2"].AutoButtonColor = false

		minControl["c2"].MouseButton1Click:Connect(function()
			winT:ToggleVisibility()
		end)

		-- StarterGui.Gui.Toggle.Toggle
		minControl["c3"] = Instance.new("ImageLabel", minControl["c2"]);
		minControl["c3"].AnchorPoint = Vector2.new(0.5, 0.5);
		minControl["c3"].Image = [[rbxassetid://104199013389637]];
		minControl["c3"].Size = UDim2.new(0.8, 0, 0.8, 0);
		minControl["c3"].BackgroundTransparency = 1;
		minControl["c3"].Name = [[Toggle]];
		minControl["c3"].Position = UDim2.new(0.5, 0, 0.5, 0);


		-- StarterGui.Gui.Toggle.UICorner
		minControl["c4"] = Instance.new("UICorner", minControl["c2"]);
		minControl["c4"].CornerRadius = UDim.new(0, 10);
	end
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.KeyCode == winT.Keybind and not gameProcessed then
			winT:ToggleVisibility()
		end
	end)
	
	--buttons
	do
		--close button
		winT["9"].MouseEnter:Connect(function()
			Library:tween(winT["9"],{Transparency = 0.6},0.2,Enum.EasingStyle.Exponential)
		end)
		
		winT["9"].MouseLeave:Connect(function()
			Library:tween(winT["9"],{Transparency = 1},0.2,Enum.EasingStyle.Exponential)
		end)
		
		winT["9"].MouseButton1Click:Connect(function()
			winT:CreatePopUp({
				Title = "Warning",
				Description = "Are you sure you want to close and destroy the Ui?",
				OkbuttonCallback = function() 
					for i,v in winT["1"].Parent:GetDescendants() do
						if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
							Library:tween(v,{TextTransparency = 1},0.35,Enum.EasingStyle.Exponential)
							if v:IsA("TextBox") then
								Library:tween(v,{TextTransparency = 1},0.35,Enum.EasingStyle.Exponential)
							end
						end
						if v:IsA("ImageButton") or v:IsA("ImageLabel") then
							Library:tween(v,{ImageTransparency = 1},0.35,Enum.EasingStyle.Exponential)	
						end
						if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("ImageButton") or v:IsA("TextBox") or v:IsA("ImageLabel") or v:IsA("Frame") or v:IsA("UIStroke")   or v:IsA("ScrollingFrame") then
							Library:tween(v,{Transparency = 1},0.35,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,function()
								task.spawn(function()
									task.wait(2)
									winT["1"]:Destroy()
								end)
							end)	
						end
					end
				end,
				CancelbuttonCallback = function() end,
			})
		end)
		--minimise button
		winT["c"].MouseEnter:Connect(function()
			Library:tween(winT["c"],{Transparency = 0.6},0.2,Enum.EasingStyle.Exponential)
		end)

		winT["c"].MouseLeave:Connect(function()
			Library:tween(winT["c"],{Transparency = 1},0.2,Enum.EasingStyle.Exponential)
		end)
		winT["c"].MouseButton1Click:Connect(function()
			winT:ToggleVisibility()
		end)
	end
	
	Library:tween(winT["2"],{Size = winT.MainWindowSize}, 0.4,Enum.EasingStyle.Cubic, Enum.EasingDirection.Out,function()
		for i,v in ObjectToVisible do
			v.Visible = true
		end
	end)
	
	-- Opening UI
	if Agreement == false then Library:tween(winT["2"],{Size = winT.MainWindowSize}, 0.4,Enum.EasingStyle.Cubic, Enum.EasingDirection.Out) end
	
	return winT
end
