
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
Notification.new("success", "Executing Successfully!", "Enjoy To Use Scripts😁😎",5,5)

local id = game.PlaceId
if id == 537413528 then else game:Kick("รันให้ถูกแมพนะครับไอควาย") task.wait(1) game:Shutdown() end;

repeat task.wait() until game:IsLoaded() task.wait()
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
    local Args = {...}
    if getnamecallmethod()=="FireServer" and self.Name == "Received" or self.Name == "Sent" then
            return nil
    end
    return OldNameCall(self,...)
end)

local function toTarget(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 1000 then
		Speed = 350
	elseif Distance >= 1000 then
		Speed = 325
	end

	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		tween:Cancel()
	end 

	function tweenfunc:Wait()
		tween.Completed:Wait()
	end 

	return tweenfunc
end

task.spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
              if getgenv().AutoFarm1 then
                 if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000,100000,100000)
                    Noclip.Velocity = Vector3.new(0,0,0)
                 end
              else	
                 if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
                 end
              end
        end)
    end)
end)
 
task.spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if getgenv().AutoFarm1 then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false    
                    end
                end
            end
        end)
    end)
end)

function MethodTween()
    game.workspace.Gravity = 0
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-51.1823959, 80.6168747, -536.437805)
    toTarget(CFrame.new(-60.5737877, 53.9498825, 8666.35059))
    task.wait(29)
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-55.5486526, -360.063782, 9489.0498)
    game.workspace.Gravity = 196.2
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

date = os.date("%A %d %B %Y")
local Window = Fluent:CreateWindow({
    Title = "Only Perry Store / BABFT |",
    SubTitle = date,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = getgenv().Settings.Acrylic,
    Theme = getgenv().Settings.Theme,
    MinimizeKey = getgenv().Settings.Keybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

Tabs.Main:AddParagraph({Title = "Money",Content = ""})

Tabs.Main:AddToggle("", {Title = "Auto Farm Money", Default = getgenv().Settings.Start }):OnChanged(function(va)
    getgenv().AutoFarm1 = va
    game:GetService("RunService").Stepped:connect(function()
        if getgenv().AutoFarm1 then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end)
    if getgenv().AutoFarm1 then
        MethodTween()
    end
    if not getgenv().AutoFarm1 then
        game.Players.LocalPlayer.Character.Head:Destroy()
    end
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        repeat task.wait()
        until game.Players.LocalPlayer.Character
        task.wait(3)
        if getgenv().AutoFarm1 then
            MethodTween()
        end
    end)
end)

Tabs.Main:AddParagraph({Title = "Random Chest",Content = ""})

Tabs.Main:AddToggle("", {Title = "Common Chests", Default = false }):OnChanged(function(va)
    getgenv().CC = va
    game:GetService('RunService').Stepped:connect(function()
        if getgenv().CC then
            workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("Common Chest",1)            
        end 
    end)
end)

Tabs.Main:AddToggle("", {Title = "Uncommon Chests", Default = false }):OnChanged(function(va)
    getgenv().UCC = va
    game:GetService('RunService').Stepped:connect(function()
    if getgenv().UCC then
    workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("Uncommon Chest",1)    
    end
    end)
end)

Tabs.Main:AddToggle("", {Title = "Rare Chest", Default = false }):OnChanged(function(va)
    getgenv().RC = va
    game:GetService('RunService').Stepped:connect(function()
    if getgenv().RC then
    workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("Rare Chest",1)    
    end
    end)
end)

Tabs.Main:AddToggle("", {Title = "Epic Chests", Default = false }):OnChanged(function(va)
    getgenv().EC = va
    game:GetService('RunService').Stepped:connect(function()
    if getgenv().EC then
        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("Epic Chest",1)    
    end
    end)
end)

Tabs.Main:AddToggle("", {Title = "Legendary Chests", Default = false }):OnChanged(function(va)
    getgenv().LC = va
    game:GetService('RunService').Stepped:connect(function()
    if getgenv().LC then
        workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("Legendary Chest",1)    
    end 
    end)
end)

Tabs.Main:AddParagraph({Title = "Servers",Content = ""})

Tabs.Main:AddToggle("", {Title = "Auto Rejoin (When You Got Kick The Server)", Default = getgenv().Settings.Start }):OnChanged(function(va)
    repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
 
    local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
     
    po.ChildAdded:connect(function(a)
        if a.Name == 'ErrorPrompt' then
            repeat
                ts:Teleport(game.PlaceId)
                wait(2)
            until false
        end
    end)
end)

Tabs.Main:AddButton({
    Title = "Rejoin",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Are You Sure?",
            Content = "Click Below To Confirm!",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()

                    end
                }
            }
        })
    end
})

Tabs.Main:AddButton({
    Title = "Server Hop",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Are You Sure?",
            Content = "Click Below To Confirm!",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local PlaceID = game.PlaceId
                        local AllIDs = {}
                        local foundAnything = ""
                        local actualHour = os.date("!*t").hour
                        local Deleted = false
                        local File = pcall(function()
                            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
                        end)
                        if not File then
                            table.insert(AllIDs, actualHour)
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        end
                        function TPReturner()
                            local Site;
                            if foundAnything == "" then
                                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                            else
                                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                            end
                            local ID = ""
                            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                                foundAnything = Site.nextPageCursor
                            end
                            local num = 0;
                            for i,v in pairs(Site.data) do
                                local Possible = true
                                ID = tostring(v.id)
                                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                                    for _,Existing in pairs(AllIDs) do
                                        if num ~= 0 then
                                            if ID == tostring(Existing) then
                                                Possible = false
                                            end
                                        else
                                            if tonumber(actualHour) ~= tonumber(Existing) then
                                                local delFile = pcall(function()
                                                    delfile("NotSameServers.json")
                                                    AllIDs = {}
                                                    table.insert(AllIDs, actualHour)
                                                end)
                                            end
                                        end
                                        num = num + 1
                                    end
                                    if Possible == true then
                                        table.insert(AllIDs, ID)
                                        wait()
                                        pcall(function()
                                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                                            wait()
                                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                                        end)
                                        wait(4)
                                    end
                                end
                            end
                        end
                        
                        function Teleport()
                            while wait() do
                                pcall(function()
                                    TPReturner()
                                    if foundAnything ~= "" then
                                        TPReturner()
                                    end
                                end)
                            end
                        end
                        
                        -- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
                        Teleport()
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()

                    end
                }
            }
        })
    end
})

Tabs.Main:AddButton({
    Title = "Server Hop Less Player",
    Description = "",
    Callback = function()
        Window:Dialog({
            Title = "Are You Sure?",
            Content = "Click Below To Confirm!",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
until Server

TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()

                    end
                }
            }
        })
    end
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
