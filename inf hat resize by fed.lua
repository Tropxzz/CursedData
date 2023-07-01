--[[
Infinite Hat Resizer V2 (Literally)
Need 2 people (Can use alts)
And need to be R15!
(THIS CAN MAKE LAG OR ETC)
(THIS CAN SCALE UP INTO THE MAP)

Receiver is the bald person (Pure Avatar not through deleting the hats with exploits)

Giver is the one who wears rthro hats

You Can Use Alts To Do It

Made By Fedoratum

()((Update Log))()
Planet Size Hat (V1)
Added AnnoyingSpin (V1)
(((((Newest Update))))))
Infinite Hat Resizer Name Change (V2)
Added a fix to hats deleted by void (V2)
Added a fix you cannot reset when on AnnoyingSpin mode (V2)
Added a fix where people can wear your hats (V2)
Added a drophat option if you want to drop it to someone (V2)
Added a name shortener to not be complicated to put names (V2)
Fixed hat resizing being slow into fast (V2)
]]--

-- Type the giver and receiver

local giver = "person with rthro hat"
local receiver = "bald person"
-- Can be shortened
-- Need to be R15 and not wearing any hats
-- other than 1 hat that is rthro hat.

--[[
Example :
local giver = "ROBLOX"
local receiver = "Builderman"

Same name placement for both person to execute script
]]--

-- Option For Receiver
AnnoyingSpin = true
-- (true) is on and (false) is off
-- Makes you spin when the hat big as map
DropHat = false
-- makes you drop hats in the map
-- either someone bald will wear it

function mOut(txt, type)
if type == 1 then
spawn(function()
local m = Instance.new("Message", game.CoreGui)
m.Text = txt
task.wait(3)
m:Destroy()
end)
elseif type == 2 then
spawn(function()
local h = Instance.new("Hint", game.CoreGui)
h.Text = txt
task.wait(3)
h:Destroy()
end)
end
end

local Plr = game:GetService"Players"
local Player = Plr.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Torso = Character and Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
local RootPart = Humanoid and Humanoid.RootPart

function GP(shortcut)
local player = nil
local g = Plr:GetPlayers()
for i = 1, #g do
if string.lower(string.sub(g[i].Name,1,string.len(shortcut))) == string.lower(shortcut) then
if g[i] ~= nil then
player = g[i]
break
end
end
end
return player
end

-- // Check 1 (Checking if both person exist)

if GP(receiver) and GP(giver) then
mOut("Receiver and Giver Exists", 1)
else
mOut("Both or one people not exist", 1)
return
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

-- // Check 2 Wait If Both Is Ready

local Started = false

local m = Instance.new("Message", game.CoreGui)
m.Text = "Waiting For Respond"

if Player  == GP(giver) then

ChatCon = GP(receiver).Chatted:Connect(function(msg)
if msg == "instance start" then
Plr:Chat("instance start")
Started = true
elseif msg == "Script done from receiver" then
mOut("All Done Now Hats Size Of Map", 1)
print("Process Ended")
cht:Disconnect()
end
end)

elseif Player == GP(receiver) then
ChatCon = GP(giver).Chatted:Connect(function(msg)
if msg == "instance start" then
Plr:Chat("instance start")
Started = true
end
end)

end

while true do
wait(1)
if Started ~= true then
Plr:Chat("instance start")
else
break
end
end

-- // If both is ready then script starts

m:Destroy()
mOut("Wait Please, Process Started", 1)

print("Process Started")

-- // Part Anchor

local part = Instance.new("Part", Workspace)
part.Anchored = true
part.CanCollide = false
part.Transparency = 0.8
part.CFrame = RootPart.CFrame

local part2 = Instance.new("Part", Workspace)
part2.Anchored = true
part2.CanCollide = true
part2.Transparency = 0.8
part2.Size = Vector3.new(100,0,100)
part2.CFrame = RootPart.CFrame * CFrame.new(9999,9999,0)

if Player == GP(giver) then
game:GetService("Workspace").FallenPartsDestroyHeight = tonumber("nan")
RootPart.CFrame = part2.CFrame * CFrame.new(5,10,5)

Humanoid.WalkSpeed = 0

for i, v in pairs(Humanoid:GetChildren()) do
if v:IsA("NumberValue") then
for i, v1 in pairs(Character:GetChildren()) do
if v1:FindFirstChild("AvatarPartScaleType", true) then
                    repeat
                        wait()
                    until v1:FindFirstChild("OriginalSize", true)
                    v1:FindFirstChild("OriginalSize", true):Destroy()
                    v:Destroy()
                end
            end
        end
    end

RootPart.CFrame = GP(receiver).Character.HumanoidRootPart.CFrame

task.wait(0.5)

Plr:Chat("First Step Done")

Humanoid:Destroy()
part:Destroy()
part2:Destroy()
game:GetService("Workspace").FallenPartsDestroyHeight = nil
elseif Player == GP(receiver) then
RootPart.CFrame = part2.CFrame * CFrame.new(5,10,5)
game:GetService("Workspace").FallenPartsDestroyHeight = tonumber("nan")
Humanoid.WalkSpeed = 0
local ChatC
ChatC = GP(giver).Chatted:Connect(function(msg)
if msg == "First Step Done" then
task.wait(1.5)
for i, v in pairs(Humanoid:GetChildren()) do
if v:IsA("NumberValue") then
for i, v1 in pairs(Character:GetChildren()) do
                if v1:FindFirstChild("AvatarPartScaleType", true) then
                    repeat
                        wait()
                    until v1:FindFirstChild("OriginalSize", true)
                    v1:FindFirstChild("OriginalSize", true):Destroy()
                    v:Destroy()
                end
            end
        end
    end

if AnnoyingSpin then
local ems = Enum.HumanoidStateType:GetEnumItems()
table.remove(ems, table.find(ems, Enum.HumanoidStateType.None))
for _, x in pairs(ems) do
Humanoid:SetStateEnabled(x, false)
end
Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "InfHandler"
Spin.Parent = Torso
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,30,0)
end

ChatC:Disconnect()

Humanoid.WalkSpeed = 16

mOut("All Done Now Hats Size Of Map", 1)
Plr:Chat("Script done from receiver")
print("Process Ended")
RootPart.CFrame = part.CFrame
part2:Destroy()
part:Destroy()

ChatCon:Disconnect()

local rbind = Instance.new("BindableEvent")
    local rcon
    rcon =
        rbind.Event:Connect(
        function()
rcon:Disconnect()
game:GetService("Workspace").FallenPartsDestroyHeight = nil
if DropHat == false then
RootPart.CFrame = CFrame.new(9e9,9e9,9e9)
end
task.wait(0.5)
Humanoid:Destroy()
rbind:Destroy()
game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = "Information",
                    Text = "Wait for " .. Plr.RespawnTime .. " seconds to respawn."
                }
            )
        end
    )
game:GetService("StarterGui"):SetCore("ResetButtonCallback", rbind)

end
end)

end
