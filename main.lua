local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")
local lplr = players.LocalPlayer

local rootFolder = Instance.new("Folder",coreGui)
rootFolder.Name = "RF"


local settings = { -- edit if you want
    color = Color3.fromRGB(255,255,255),
    transgender = 0.8
}

function ornamatePart(char,part)
    local plrFolder = rootFolder[char.Name] 
    local bho = Instance.new("BoxHandleAdornment",plrFolder)
    bho.Name = part.Name
    bho.ZIndex = 1
    bho.AlwaysOnTop = true
    bho.Color3 = settings.color
    bho.Transparency = settings.transgender
    bho.Size = part.Size
    bho.Adornee = part
end

function instate(plr)
    local folder = Instance.new("Folder",rootFolder)
    folder.Name = plr.Name

    local char = plr.Character or plr.CharacterAdded:Wait()

    for _,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            ornamatePart(char,v)
        end
    end 



    plr.CharacterAdded:Connect(function(char)
        repeat wait() until char.Parent == workspace

        for _,v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                ornamatePart(char,v)
            end
        end
    end)

    plr.CharacterRemoving:Connect(function(char)
        local plrFolder = rootFolder[char.Name]
        for _,v in pairs(plrFolder:GetChildren()) do
            v:Destroy()
        end
    end)
    
end


for _,plr in pairs(players:GetPlayers()) do
    if plr ~= lplr then
        instate(plr)
    end
end

players.PlayerAdded:Connect(function(plr)
    if plr ~= lplr then
        instate(plr)
    end
end)

players.PlayerRemoving:Connect(function(plr)
    local folder = rootFolder:FindFirstChild(plr.Name)
    folder:Destroy()
end)
-- simple, undetectable
