--> varibles
local config = {
	-- AdvancedStuff = true; -- Advanced Features + loading
	webhoollogging = true; -- Logs ur shit
	webhookURL = "enter discord url"; -- enter rn if logging also there will be it in config dw
}

local Services = {
	Players = game:GetService("Players");
	UserInputService = game:GetService("UserInputService");
	TweenService = game:GetService("TweenService");
	RunService = game:GetService("RunService");
	StarterGui = game:GetService("StarterGui");
	SoundService = game:GetService("SoundService");
	Lighting = game:GetService("Lighting");
    Players = game:GetService("Players");
    MarketplaceService = game:GetService("MarketplaceService");
    CharacterAppearance = game:GetService("CharacterAppearance");

}

local Players = Services.Players -- this saves me hella time
local plr = Services.Players.LocalPlayer
local LocalPlayer = Services.Players.LocalPlayer
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name -- I love you Devforum <3 Tropxz
local FLYING = false
local QEfly = true
local flyspeed = 1
local char = plr.Character
local Mouse = plr:GetMouse()
local CONTROL = {}
local vehicleflyspeed = 1
local speed = 1
local radius = 5
local orbitspeed = speed
local orbitradius = radius
local eclipse = 1
local character = plr.Character
local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local HttpService = game.HttpService

local function sendWebhookMessage(content)
    local payload = {
        content = content
    }

    local encodedPayload = HttpService:JSONEncode(payload)

    local response = HTTPRequest({
        Url = config.webhookURL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = encodedPayload
    })

    if response and response.StatusCode == 200 then
        print("Webhook message sent successfully.")
    else
        warn("Failed to send webhook message.")
    end
end

local imageids = {
	home = 7733960981;
	settings = 7734053495;
	misc = 7733701545;
	general = 7733749837;
	g2ame = 7733799795
}


ScriptStuff = {
	D = false;
}

local HUF = {"Hasen't answered", "Sad", "Annoyed", "Tired", "Suicidal", "Meh", "Happy", "MAD"}

--> Functions

function chat(message)
	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, 'All'); -- FireServer (<string> Message, <string> Channel) 
end

local function sendSystemMessageToLocalPlayer(message)
	local messageInstance = Instance.new("Message")
	messageInstance.Text = message
	messageInstance.Parent = plr.PlayerGui

	wait(1)

	messageInstance:Destroy() 
end


function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until Mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or flyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or flyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or flyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or flyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function printTable(tbl)
	for key, value in pairs(tbl) do
		if type(value) == "table" then
			printTable(value)
		else
			print(key, value)
		end
	end
end


--> Main shif
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "CursedDATA, Game: "..GameName,
	LoadingTitle = "CursedDATA",
	LoadingSubtitle = "Pov: this script has a license and u skidded :skull:",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "CursedDATA", -- Create a custom folder for your hub/game
		FileName = "CursedDATAConfig"
	},
	Discord = {
		Enabled = true,
		Invite = "uJrWwXBgwM", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = false -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Key",
		Subtitle = "Key System",
		Note = "IDK",
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
})



local H = Window:CreateTab("Home", imageids.home) 
local GAT = Window:CreateTab("General / trolling", imageids.general) 
local OS = Window:CreateTab("Not my scripts", imageids.general) 
local OH = Window:CreateTab("Other ScriptHubs i have made.", imageids.general) 
local C = Window:CreateTab("Config", imageids.settings) 
-- Home
H:CreateLabel("Hello, "..plr.Name)
H:CreateLabel("This stupid shit suck my dick big tits script is made by tropxz.")
H:CreateLabel("Join and support me: .gg/uJrWwXBgwM")
H:CreateDropdown({
	Name = "How do you feel",
	Options = HUF,
	CurrentOption = {"Hasen't answered"},
	MultipleOptions = false,
	Flag = "How do you feel",
	Callback = function(selectedOption)
		printTable(selectedOption)
	end,
})

H:CreateButton({
   Name = "Rejoin",
   Callback = function()
          game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
   end,
})

-- General / Trolling

GAT:CreateSection("General")

GAT:CreateButton({
	Name = "Fly",
	Callback = function()
		NOFLY()
		wait()
		sFLY()
	end,
})


GAT:CreateButton({
	Name = "Unfly",
	Callback = function()
		NOFLY()
	end,
})

GAT:CreateInput({
	Name = "Go to",
    PlaceholderText = "Player name.",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local playerName = Text:lower()
        for i, v in next, game:GetService("Players"):GetPlayers() do
            if v.Name:lower() == playerName then
                game:GetService("Players").LocalPlayer.Character:MoveTo(v.Character.PrimaryPart.Position)
                return
            end
        end
      end,
})

GAT:CreateButton({
	Name = "Swim",
	Callback = function()
    workspace.Gravity = 0
    plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false) plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end,
})

GAT:CreateButton({
	Name = "UnSwim",
	Callback = function()
    workspace.Gravity = 196.1999969482422
    plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true) plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true) plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end,
})


GAT:CreateButton({
	Name = "No clothes (i think only for you)",
	Callback = function()
    if plr.Character:FindFirstChild("Shirt") then
   plr.Character.Shirt:Remove()
end
if plr.Character:FindFirstChild("Pants") then
   plr.Character.Pants:Remove()
end
if plr.Character:FindFirstChild("Shirt Graphic") then
   plr.Character["Shirt Graphic"].Graphic = ""
end
	end,
})

GAT:CreateSection("Trolling")

GAT:CreateInput({
	Name = "Orbit",
    PlaceholderText = "Player name.",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
 local player = game.Players:FindFirstChild(Text)
        if not player or not player.Character then
            return
        end


        if not orbitspeed or not orbitradius then -- check if variables are defined
            return
        end


        local rotation = CFrame.Angles(0, 0, 0)

        local sin, cos = math.sin, math.cos
        local rotspeed = math.pi * 2 / speed
        eclipse = eclipse * radius
        local runservice = game:GetService('RunService')

        local rot = 0

        ORBIT = runservice.Stepped:Connect(function(t, dt)
            if player.Character then
                rot = rot + dt * rotspeed
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = rotation * CFrame.new(sin(rot) * eclipse, 0, cos(rot) * radius) + player.Character.HumanoidRootPart.Position
            else
                ORBIT:Disconnect()
            end
        end)
      end,
})

GAT:CreateButton({
	Name = "UnOrbit",
	Callback = function()
		        ORBIT:Disconnect()
	end,
})

GAT:CreateButton({
	Name = "Sanic",
	Callback = function()
			loadstring(game:HttpGetAsync("https://bit.ly/3Cmw7BP"))()
	end,
})

-- configuration

C:CreateInput({
	Name = "Fly speed",
	PlaceholderText = "Enter here -- number only",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		flyspeed = Text
	end,
})

C:CreateInput({
	Name = "Orbit Radius",
	PlaceholderText = "Enter here -- number only",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		radius = Text
	end,
})

C:CreateInput({
	Name = "Orbit speed",
	PlaceholderText = "Enter here -- number only",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		speed = Text
	end,
})

C:CreateInput({
	Name = "Fps (Only valyse working i think)",
	PlaceholderText = "Enter here -- number only",
	RemoveTextAfterFocusLost = false,
	Callback = function(Number)
		setfpsmax(tonumber(Number))
	end,
})

C:CreateToggle({
   Name = "Webhook logging",
   CurrentValue = false,
   Flag = "WL", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
     if Value == true then
       config.webhoollogging = true
else
config.webhoollogging = false
     end
   end,
})

C:CreateInput({
   Name = "Enter webhook",
   PlaceholderText = "Enter meanie",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   webhookURL = Text
   sendWebhookMessage(tostring(plr.Name).." Has updated the url to "..Text)
   end,
})

C:CreateButton({
   Name = "Press for free COOKIES!!!!!!!",
   Callback = function()
   while wait() do
   for i = 1,15 do
        print("Fucked up dickhead")
		local newPart = Instance.new("Part")
		newPart.Parent = workspace
		chat("I GOT FREE COOKIES FROM CURSEDDATA!!!!!!!!!!!!")
		newPart.CFrame = CFrame.new(-43.3326912, 12.998023, 4.05767918, -0.113876089, 0, 0.993494987, 0, 1, 0, -0.993494987, 0, -0.113876089)
     end
     setfpsmax(1000)
     end
   end,
})

C:CreateButton({
   Name = "Destroy UI",
   Callback = function()
   Rayfield:Destroy()
   end,
})


local function checkAllPlayers(targetUserId)
    while true do
        -- Get all players in the game
        local allPlayers = Services.Players:GetPlayers()

        -- Check if the target player is in the game
        local isTargetPlayerPresent = false
        for _, player in ipairs(allPlayers) do
            if player.UserId == targetUserId then
                isTargetPlayerPresent = true
                break
            end
        end

        if isTargetPlayerPresent then
             sendSystemMessageToLocalPlayer("Tropxz is in your game (Owner of CursedDATA).")
             break
        end

        -- Delay before checking again
        wait(1) -- Adjust the delay time as needed
    end
end

-- Other hubs i have made, sorry for not doing it in order :sob:

OH:CreateButton({
   Name = "Grape hub",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/Scripts/main/grape%20hub", true))()
   end,
})

OH:CreateButton({
   Name = "Useful UI",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/Scripts/main/Useful%20Gui", true))()
   end,
})

OH:CreateButton({
   Name = "Sweatdestroyer",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/SweatDestroyer/main/MainOperator.lua", true))()
   end,
})


OH:CreateButton({
   Name = "OmniAdmin",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/Scripts/main/OmniAdmin.lua", true))()
   end,
})

-- scripts Not made by me

OS:CreateButton({
   Name = "RGB chat by rouxhaver",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-2/main/RGB%20Bubble%20chat.Lua", true))()
   end,
})

OS:CreateButton({
   Name = "FE Android Quality by rouxhaver",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-2/main/Extreme%20low%20quality.lua", true))()
   end,
})

OS:CreateButton({
   Name = "Character Creator By rouxhaver",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/FE%20character%20creator.lua", true))()
   end,
})

OS:CreateButton({
   Name = "FE Player lifter by rouxhaver",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/player%20lifter.lua", true))()
   end,
})

OS:CreateButton({
   Name = "Soul absorber by rouxhaver",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/soul%20absorber.lua", true))()
   end,
})

OS:CreateButton({
   Name = "Rejoin button for kick msg by rouxhaver",
   Callback = function()
   gui = game.CoreGui.RobloxPromptGui.promptOverlay:WaitForChild("ErrorPrompt")

gui.Size = UDim2.new(0, 400, 0, 230)

leave = gui.MessageArea.ErrorFrame.ButtonArea.LeaveButton

gui.MessageArea.MessageAreaPadding.PaddingTop = UDim.new(0,-20)
gui.MessageArea.ErrorFrame.ErrorFrameLayout.Padding = UDim.new(0, 5)

gui.MessageArea.ErrorFrame.ButtonArea.ButtonLayout.CellPadding = UDim2.new(0, 0, 0, 5)

rejoin = leave:Clone()
rejoin.Parent = leave.Parent
rejoin.ButtonText.Text = "Rejoin"

Players = game:GetService("Players")
TeleportService = game:GetService("TeleportService")

rejoin.MouseButton1Up:Connect(function()
	if #Players:GetPlayers() <= 1 then
		TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
	end
end)
   end,
})

OS:CreateButton({
   Name = "Lagger by fedoratum",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/CursedData/main/1k%2B%20server%20lagger", true))()
   end,
})

OS:CreateButton({
   Name = "Auto excuse :( by flamespill (Configed)",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Tropxzz/CursedData/main/Flamespill%20autoexcuse%20config", true))()
   end,
})

OS:CreateButton({ -- doesnt work lol omfg
   Name = "Character.AI (Has my Api key) by ELamlover",
   Callback = function()

getfenv().YourToken = 'c4f2baf1331a4180de9ac80a18321565f54cd575';
getfenv().WaitAnswer = true;

loadstring(game:HttpGet('https://raw.githubusercontent.com/ElWapoteDev/CharacterAI-Luau/main/Examples/CharHub.lua', true))();
   end,
})

OS:CreateButton({ -- doesnt work lol omfg
   Name = "Custom roblox by JayZ",
   Callback = function()
    loadstring(game:HttpGet("https://eternityhub.xyz/BetterRoblox/Loader"))()
   end,
})

OS:CreateButton({ 
   Name = "FE Hat train by rouxhaver (R6)",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/FE%20hat%20train.lua"))()
   end,
})

OS:CreateButton({ 
   Name = "FE Heart attack",
   Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/yeerma/1/main/my-back'))()
   end,
})

OS:CreateButton({ 
   Name = "Inf yield By EdgeIY",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

OS:CreateButton({ 
   Name = "Dark dex by moon",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()   
    end,
})


 if game.Players.LocalPlayer.UserId == 3686372594 then
   sendSystemMessageToLocalPlayer("Welcome Trops.")
 else
 sendSystemMessageToLocalPlayer("Welcome to CursedDATA.")
 end

checkAllPlayers(3686372594)
