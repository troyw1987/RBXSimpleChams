local players = game:GetService("Players")
local cGui = game:GetService("CoreGui")
local undetectable = Instance.new("Folder",cGui)


function chamPart(part,color3,transparency,plr) -- my cham function
	local pFolder = undetectable:WaitForChild(plr.Name)

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

function chamCharacter(plr,char)
	for _,ins in pairs(char:GetChildren()) do
		if ins:IsA("BasePart") then
			chamPart(ins,Color3.fromRGB(255,255,255),0.7,plr)
		end
	end
end

function chamPlayer(plr)
	if not undetectable:FindFirstChild(plr.Name) then
		local char = plr.Character or plr.CharacterAdded:Wait()

		local folder = Instance.new("Folder",undetectable)
		folder.Name = plr.Name

		chamCharacter(plr,char)
	end

	plr.CharacterAppearanceLoaded:Connect(function()
		local char = plr.Character or plr.CharacterAdded:Wait()
		undetectable:FindFirstChild(plr.Name):Destroy()

		local folder = Instance.new("Folder",undetectable)
		folder.Name = plr.Name

		chamCharacter(plr,char)
	end)
end


for _,plr in pairs(players:GetPlayers()) do
	chamPlayer(plr)
end

players.PlayerAdded:Connect(function(plr)
	chamPlayer(plr)
end)
-- Minus 30 lines, way better
