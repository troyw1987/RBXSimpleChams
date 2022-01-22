local settings = {
    Enabled = false,
    TeamColor = false,
    Color = Color3.new(255,255,255),
    Trans = 0.7,
}

--[ script ]--
local undetectable = Instance.new("Folder",game:GetService("CoreGui"))
local players = game:GetService("Players")

--functions
function updateCham(cham,part)
    cham.Visible = settings.Enabled
    cham.Color3 = settings.Color
    cham.Transparency = settings.Trans
    cham.Name = "NotChams"
    cham.Adornee = part
    cham.Size = part.Size
    cham.AlwaysOnTop = true
    cham.ZIndex = 1

    local char = part:FindFirstAncestorOfClass("Model")

    if char then
        local plr = players:GetPlayerFromCharacter(char)

        if plr then
            if settings.TeamColor then
                cham.Color3 = plr.TeamColor.Color
            end
        end
    end
end

function chamPart(part,char) -- my cham function
	local pFolder = undetectable:FindFirstChild(char.Name)

    if not pFolder then
        pFolder = Instance.new("Folder",undetectable)
        pFolder.Name = char.Name
    end

    local cham = Instance.new("BoxHandleAdornment",pFolder)
    updateCham(cham,part)
end

function updateChams()
    for _,v in pairs(undetectable:GetDescendants()) do
        if v:IsA("BoxHandleAdornment") then
            if v.Adornee then
                updateCham(v,v.Adornee)
            end
        end
    end
end

function chamChar(char)
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            chamPart(v,char)
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

--events
players.PlayerAdded:Connect(function(plr)
    init(plr)
end)

players.PlayerRemoving:Connect(function(plr)
    local pFolder = undetectable:FindFirstChild(plr.Name)

    if pFolder then
        pFolder:Destroy()
    end
end)

--init
for _,v in pairs(players:GetPlayers()) do
    init(v)
end

--[ ui lib ]--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Chams")
local MainOptions = Window:NewSection("Options")

MainOptions:CreateToggle("Enabled", function(value)
    settings.Enabled = value
    updateChams()
end)

MainOptions:CreateColorPicker("Picker", Color3.new(255, 255, 255), function(value)
    settings.Color = value
    updateChams()
end)

MainOptions:CreateToggle("Use Team Color", function(value)
    settings.TeamColor = value
    updateChams()
end)

MainOptions:CreateSlider("Trans", 0, 1, 1, true, function(value)
    settings.Trans = value
    updateChams()
end)
