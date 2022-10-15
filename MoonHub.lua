local Players = game:GetService("Players")
local Character = Players.LocalPlayer.Character
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tylers31/MoonHub/main/base.lua"))() -- UI Libraries
local Window = Library.CreateLib("MoonHub", currentOption) -- Theme function (LightTheme, DarkTheme, GrapeTheme, BloodTheme, Ocean, Midnight, Sentinel, Synapse)

--------------------------------------------------------------------------------
-- Combat Section
--------------------------------------------------------------------------------
local Combat = Window:NewTab("Combat")
local CombatSection = Combat:NewSection("Combat")

-- Killaura Logic (BROKEN)
local function getClosest()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    local closest_distance = math.huge
    local closestperson

    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local plr_pos = v.Character.HumanoidRootPart.Position
            local plr_distance = (hrp - plr_pos).Magnitude

            if plr_distance < closest_distance then
                closest_distance = plr_distance
                closestperson = v
            end
        end
    end

    return closestperson
end

-- Killaura Toggle (BROKEN)
CombatSection:NewToggle("Killaura (BUGGED)", "Automatically hit players near you", function(state)
    if state and Character:FindFirstChild("HumanoidRootPart") then
        print("Killaura Toggled")
        local closest = getClosest()
        local hrp = Character.HumanoidRootPart.Position

        -- Im guessing the distance honestly
        if (hrp - closest.Character.HumanoidRootPart.Position).Magnitude <= 10 then
            ReplicatedStorage.Events.SwingTool:FireServer(ReplicatedStorage.RelativeTime.Value, {
                [1] = closest.Character.HumanoidRootPart
            })
        end
    else
        print("Killaura Toggled Off")
    end
end)

-- HBE Button

CombatSection:NewButton("Hitbox Extender", "Extends players hitboxes", function()

end)

--------------------------------------------------------------------------------
-- Visuals Section --
--------------------------------------------------------------------------------
local Visuals = Window:NewTab("Visuals")
local VisualsSection = Visuals:NewSection("Visuals")

VisualsSection:NewSlider("FOV", "Slide up & down to change fov", 300, 70, function(Value) -- 500 (MaxValue) | 68 (MinValue)
    game.Workspace.CurrentCamera.FieldOfView = Value
end)


--------------------------------------------------------------------------------
-- Menu Settings
--------------------------------------------------------------------------------
local Settings = Window:NewTab("Settings")
local SettingsSection = Settings:NewSection("Settings")

-- Hide Menu
SettingsSection:NewKeybind("Toggle Menu", "Press your keybind to hide the menu", Enum.KeyCode.F, function()
    Library:ToggleUI()
end)

-- Set Theme
SettingsSection:NewButton("Destroy Menu", "Closes the entire Menu", function()
    Library:DestroyUI()
end)
