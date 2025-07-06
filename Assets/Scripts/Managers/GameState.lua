--!Type(ClientAndServer)

-- Shared variables
local current = "Lobby"
local timer   = 0
local DURATION = { Hide = 5, Hunt = 10, RoundEnd = 5 }

-- 🔹 CLIENT side
function self:ClientStart()
    print("✅ GameState running on Client")
end

function self:ClientUpdate()
    timer = timer + Time.deltaTime

    if current == "Lobby"    and timer > 5               then switch("Hide")     end
    if current == "Hide"     and timer > DURATION.Hide   then switch("Hunt")     end
    if current == "Hunt"     and timer > DURATION.Hunt   then switch("RoundEnd") end
    if current == "RoundEnd" and timer > DURATION.RoundEnd then switch("Lobby")  end
end

-- 🔹 SERVER side (add this to avoid silent fail)
function self:ServerStart()
    print("✅ GameState running on Server")
end

-- 🔹 Shared logic
function switch(next)
    current, timer = next, 0
    print("PHASE → " .. next)
end
