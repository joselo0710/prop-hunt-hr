--!Type(ClientAndServer)

------------------------------------------------
-- PropBehaviour.lua
-- Lets a Prop be “tagged out” by a Hunter
------------------------------------------------

local isTagged = false     -- server-side flag

-- This is called remotely by HunterTagger.lua
function self:TagOut(hunterId)
    if isTagged then return end          -- already tagged
    isTagged = true

    -- Sync a bool so every client knows this prop is gone
    self:SetSharedVariable("tagged", true)

    print("[Prop] tagged by hunter", hunterId)
end

------------------------------------------------
-- Client-side visual logic
------------------------------------------------
function self:ClientUpdate()
    -- Check the shared variable each frame
    if self:GetSharedVariable("tagged") then
        -- Hide the mesh (simple prototype)
        self.gameObject:SetActive(false)
    end
end
