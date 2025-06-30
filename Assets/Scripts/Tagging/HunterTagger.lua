--!Type(Client)

------------------------------------------------
-- HunterTagger.lua
-- Lets a Hunter left-click to tag a Prop
------------------------------------------------

local RANGE = 100
local me    = nil          -- cache the local player after it appears

function self:ClientUpdate()
    ----------------------------------------------------------------
    -- 1. Wait until the local player object exists
    ----------------------------------------------------------------
    me = me or World.GetLocalPlayer()
    if not me then return end

    ----------------------------------------------------------------
    -- 2. Only Hunters can tag
    ----------------------------------------------------------------
    if me:GetSharedValue("role") ~= "Hunter" then return end

    ----------------------------------------------------------------
    -- 3. Detect a left-click (or screen tap) and ray-cast forward
    ----------------------------------------------------------------
    if Input.GetMouseButtonDown(0) then
        local ray  = Camera.main:ScreenPointToRay(Input.mousePosition)
        local hit  = Physics.RaycastFirst(ray, RANGE, Physics.All)

        if hit and hit.gameObject then
            -- Check if the hit object has a PropBehaviour
            local prop = hit.gameObject:GetComponent("LuaBehaviour", "PropBehaviour")
            if prop then
                -- Ask the server to tag that prop out
                prop:ServerCall("TagOut", me.id)
            end
        end
    end
end