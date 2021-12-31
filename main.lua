local undetectable = Instance.new("Folder",game:GetService("CoreGui"))
local players = game:GetService("Players")

function chamPart(part,color3,transparency,char) -- my cham function
	local pFolder = undetectable:FindFirstChild(char.Name)

    if not pFolder then
        pFolder = Instance.new("Folder",undetectable)
        pFolder.Name = char.Name
    end

    local cham = Instance.new("BoxHandleAdornment",pFolder)
    cham.Name = "NotChams"
    cham.Adornee = part
    cham.Color3 = color3
    cham.Transparency = transparency
    cham.AlwaysOnTop = true
    cham.ZIndex = 1
    cham.Size = part.Size
    cham.Visible = true
end

function chamChar(char)
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            chamPart(v,Color3.fromRGB(255,255,255),0.7,char)
        end
    end
end

function init(plr)
    if plr.Character then
        plr.Character:WaitForChild("Humanoid")
        chamChar(plr.Character)
    end

    plr.CharacterAdded:Connect(function(char)
        local pFolder = undetectable:FindFirstChild(char.Name)

        if pFolder then
            pFolder:Destroy()
        end

        char:WaitForChild("Humanoid")
        chamChar(char)
    end)
end

--

players.PlayerAdded:Connect(function(plr)
    init(plr)
end)

players.PlayerRemoving:Connect(function(plr)
    local pFolder = undetectable:FindFirstChild(plr.Name)

    if pFolder then
        pFolder:Destroy()
    end
end)

--

for _,v in pairs(players:GetPlayers()) do
    init(v)
end
