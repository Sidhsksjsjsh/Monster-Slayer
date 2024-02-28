--[[
game:GetService("ReplicatedStorage")["Events"]["Player"]["SetReady"]:FireServer()
game:GetService("ReplicatedStorage")["Events"]["Combat"]["Projectiles"]["TryShootProjectile"]:FireServer(31)
game:GetService("ReplicatedStorage")["Events"]["Experience"]["CollectOrb"]:InvokeServer(37)
game:GetService("ReplicatedStorage")["Events"]["Cards"]["CardSelected"]:InvokeServer("Electrified Projectiles")
]]

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - BETA RELEASE")
local T1 = wndw:Tab("Main")
local workspace = game:GetService("Workspace")
local user = game.Players.LocalPlayer

local combat = {
      dataProjectile = 0,
      dataOrbs = 0
}

local function bypassSpeed()
local hum = user.Character and user.Character:FindFirstChildWhichIsA("Humanoid")
      
task.spawn(function()
while wait() and user.Character and hum and hum.Parent do
if hum.MoveDirection.Magnitude > 0 then
      user.Character:TranslateBy(hum.MoveDirection)
end
end
end)
 
--user.Character.Animate.Disabled = true
local AnimControl = user.Character:FindFirstChildOfClass("Humanoid") or user.Character:FindFirstChildOfClass("AnimationController")
for i,v in next,AnimControl:GetPlayingAnimationTracks() do
      v:AdjustSpeed(0)
end
end

local function getMonster(func)
  for i,v in pairs(workspace["Entities"]:GetChildren()) do
    func(v)
  end
end

T1:Toggle("Auto throw projectiles",false,function(value)
    _G.combat = value
    while wait() do
      if _G.combat == false then break end
      combat.dataProjectile = combat.dataProjectile + 1
      game:GetService("ReplicatedStorage")["Events"]["Combat"]["Projectiles"]["TryShootProjectile"]:FireServer(combat.dataProjectile)
    end
end)

T1:Toggle("Auto bring orbs",false,function(value)
    _G.orb = value
    while wait() do
      if _G.orb == false then break end
      combat.dataOrbs = combat.dataOrbs + 1
      game:GetService("ReplicatedStorage")["Events"]["Experience"]["CollectOrb"]:InvokeServer(combat.dataOrbs)
    end
end)

T1:Toggle("Auto tp behind monster",false,function(value)
    _G.behmons = value
    while wait() do
      if _G.behmons == false then break end
      getMonster(function(v)
          user.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,1.5)
      end)
    end
end)

T1:Button("Speedboost",function()
      bypassSpeed()
end)
