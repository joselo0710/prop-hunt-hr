--!Type(Module)
------------------------------------------------
-- RoleManager.lua
-- First player = Hunter, everyone else = Prop
------------------------------------------------
local RoleMgr = {}

local roles = {}            -- playerID ➜ "Hunter"/"Prop"

-- helper: give role text to the player object
local function setRole(player, role)
    roles[player.id] = role
    -- sync to clients so they can read it later
    player:SetSharedValue("role", role)
end

------------------------------------------------
-- PUBLIC: call this whenever you enter the Lobby
------------------------------------------------
function RoleMgr.AssignRoles()
    local players = World.GetPlayers()
    if #players == 0 then return end

    for i, p in ipairs(players) do
        if i == 1 then
            setRole(p, "Hunter")
        else
            setRole(p, "Prop")
        end
    end
    print("[RoleMgr] Roles assigned")
end