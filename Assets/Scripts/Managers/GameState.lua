--!Type(ClientAndServer)
----------------------------------------------------------------
-- GameState.lua – drives Lobby → Hide → Hunt → RoundEnd loop
----------------------------------------------------------------
local current = "Lobby"
local timer   = 0
local DURATION = { Hide = 30, Hunt = 30, RoundEnd = 8 }

local function switch(next)
    current, timer = next, 0
    print("PHASE → " .. next)
end

-- called automatically **once** when the object spawns
function self:ClientStart()
    switch("Lobby")
end

-- called every frame on the client
function self:ClientUpdate()
    timer = timer + Time.deltaTime

    if current == "Lobby"    and timer > 5               then switch("Hide")     end
    if current == "Hide"     and timer > DURATION.Hide   then switch("Hunt")     end
    if current == "Hunt"     and timer > DURATION.Hunt   then switch("RoundEnd") end
    if current == "RoundEnd" and timer > DURATION.RoundEnd then switch("Lobby")  end
end