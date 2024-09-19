local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false
local AuthorizedNames = {"xF_ayy", "masterfreddyfox", "voidzrex"} 
local player = game.Players.LocalPlayer 
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart") 

--Make part For the safe-spot
local part = Instance.new("Part")
part.Name = "SkyPlatform"
part.Size = Vector3.new(10, 1, 10) 
part.Position = Vector3.new(0, 1000000, 0) 
part.Anchored = true
part.Parent = workspace


rootPart.CFrame = part.CFrame + Vector3.new(0, 5, 0)


local function IsAuthorized(player)
    for _, name in ipairs(AuthorizedNames) do
        if player.Name == name then
            return true
        end
    end
    return false
end

local function GetPlayer(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers, Player) then table.remove(GetPlayers, table.find(GetPlayers, Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    else
        for _, x in ipairs(Players:GetPlayers()) do
            if x ~= Player then
                if x.Name:lower():match("^" .. Name) or x.DisplayName:lower():match("^" .. Name) then
                    return x
                end
            end
        end
    end
    return nil
end

local function Message(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local function 2Highz(TargetPlayer)
    if not IsAuthorized(Player) then
        return Message("Unauthorized", "You are not authorized to use this script.", 5)
    end

    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart

    if Character and Humanoid and RootPart and THumanoid and TRootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end

        if THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Targeting is sitting", 5)
        end

        local function FPos(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local function SFBasePart(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0 / 0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart then
            SFBasePart(TRootPart)
        else
            Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            for _, x in ipairs(Character:GetChildren()) do
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        Message("Error Occurred", "Random error", 5)
    end
end

local function onChatted(message, speaker)
    if not IsAuthorized(speaker) then
        return
    end

    local args = string.split(message, " ")
    if args[1]:lower() == "!flip" and args[2] then
        local targetName = args[2]
        if targetName:lower() == "all" then
            AllBool = true
            for _, x in ipairs(Players:GetPlayers()) do
                2Highz(x)
            end
        else
            local targetPlayer = GetPlayer(targetName)
            if targetPlayer and targetPlayer ~= Player then
                2Highz(targetPlayer)
            else
                Message("Error Occurred", "Username Invalid", 5)
            end
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message) onChatted(message, player) end)
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message) onChatted(message, player) end)


end)

Message("Script by 2Highz", "Fling Em All!", 5)
