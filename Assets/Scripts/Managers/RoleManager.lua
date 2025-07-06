--!Type(Server)

-- no need for "local server = server"

function AssignRoles()
    local players = server.players.getPlayers()
    print("[RoleManager] Found " .. tostring(#players) .. " players")

    if #players < 2 then
        print("[RoleManager] ❌ Not enough players to assign roles")
        return
    end

    local hunterIndex = math.random(1, #players)
    for i, player in ipairs(players) do
        local role = (i == hunterIndex) and "Hunter" or "Prop"
        player:SetSharedValue("role", role)
        print("[RoleManager] 🎲 " .. player.name .. " → " .. role)
    end
end

function self:ServerUpdate()
    -- READ the phase value using the global scene:
    local phase = scene:GetValue("phase")
    print("[RoleManager] Current phase:", phase)

    if phase == "Lobby" and not self.rolesAssigned then
        AssignRoles()
        self.rolesAssigned = true
    elseif phase ~= "Lobby" then
        self.rolesAssigned = false
    end
end
