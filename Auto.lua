--I made this script too quickly
local StarterGui = game:GetService("StarterGui")
	StarterGui:SetCore("SendNotification", {
		Title = "Notification From Wes";
		Text = "Script made quickly not fully auto just too help u and only execute on event map"

	})
--Execute This After choosing ur level Mode
local StarterGui = game:GetService("StarterGui")
	StarterGui:SetCore("SendNotification", {
		Title = "Notification From Wes";
		Text = "I hope u executed after selecting ur level mode or the cam system will break";
        Duration = 10
    })
local StarterGui = game:GetService("StarterGui")
	StarterGui:SetCore("SendNotification", {
		Title = "Instruction";
		Text = "U need 200 coins + buy mystery key go to doors 5 open the secrets doors and then u will have an portal to be teleported on the event map";
        Duration = 20
    })
--When Mob is spawning and is close to u 
--U are TP to an Locker just press E to get it
--U can also Use Fly and NoClip to prevent falling out of the map

--Dont go too far cause u will miss door 250
local MaxDoor = 1500 --Not accurate
-- but to reach Door 250 in hard more put between 500-2500


local CurrentDoor = 0
local LastTween = 0
local Can = true
local NeedToHide = false
local TweenService = game:GetService("TweenService")

--Basic Stuff
task.spawn(function()

local Player = game.Players.LocalPlayer
Player.CameraMinZoomDistance = 7
while true do
task.wait()
game.Lighting.Ambient = Color3.new(1,1,1)
game.Lighting.FogEnd = 1000
game.Lighting.Brightness = 4
Player.CameraMode = Enum.CameraMode.Classic
for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
        v.HoldDuration = 0
    end
end
end

end)

--Auto
while wait() and Can do 
    for i,v in pairs(workspace.GeneratedRooms:GetChildren()) do
        if tonumber(v.Name) == nil and v.Name ~= "RoomPlayersAreIn"
        and v.Name ~= "CurrentRoom" then
            task.spawn(function()
            warn(v.Name.." Detected")
            wait(0.5)
            local character = game.Players.LocalPlayer.Character
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local Mob = v
            local distance = (Mob.Position - humanoidRootPart.Position).Magnitude
            if distance <= 50 then
                NeedToHide = true
                for _,x in pairs(v:GetDescendants()) do
                    if x:IsA("TouchTransmitter") then
                        x:Destroy()
                    end
                end
            end
            end)
        end
        if CurrentDoor >= MaxDoor then
            Can = false
            break
        end
        if v:FindFirstChild("Important") and v.Important:FindFirstChild("Door") 
        and v.Important:FindFirstChild("Door"):FindFirstChild("DoorHitbox")
        and tonumber(v.Name) >= workspace.GeneratedRooms.CurrentRoom.Value -1 then
            
            if v.Important:FindFirstChild("Lever") then
                local character = game.Players.LocalPlayer.Character
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                local targetPosition = v.Important:FindFirstChild("Lever"):WaitForChild("InteractPart").Position
                
                
                local speed = 300 
                local distance = (targetPosition - humanoidRootPart.Position).Magnitude
                local duration = distance / speed

                local tweenInfo = TweenInfo.new(
                    duration,  
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                )

                local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
                tween:Play()
                tween.Completed:Wait() 
                task.wait()
                fireproximityprompt(v.Important:FindFirstChild("Lever").InteractPart.ProximityToEnter)
                task.wait()
                
            end
            if workspace.GeneratedRooms.CurrentRoom.Value -2 >= LastTween and tonumber(v.Name) > LastTween then
                LastTween = tonumber(v.Name)
                local character = game.Players.LocalPlayer.Character
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                local targetPosition = v.Important.Door:WaitForChild("DoorHitbox").Position
                
                
                local speed = 300  
                local distance = (targetPosition - humanoidRootPart.Position).Magnitude
                local duration = distance / speed

                local tweenInfo = TweenInfo.new(
                    duration,  
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                )

                local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
                tween:Play()
                tween.Completed:Wait()
            end
            firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart,
            v.Important.Door.DoorHitbox, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart,
            v.Important.Door.DoorHitbox, 1)
            CurrentDoor = CurrentDoor + 1
            print(CurrentDoor)
            if NeedToHide and v:FindFirstChild("Hiding") and v.Hiding:FindFirstChild("MetalLocker")
            and v.Hiding.MetalLocker.PrimaryPart ~= nil then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame =
                v:FindFirstChild("Hiding"):FindFirstChild("MetalLocker").PrimaryPart.CFrame
                task.wait()
                fireproximityprompt(v.Hiding.MetalLocker.InteractPart.ProximityToEnter)
                Can = false
                break
            end
            task.wait()
        end
    end
end
