--!Type(Client)

----------------------------------------------------------------
-- RoleUI.lua  – shows “ROLE: Hunter / Prop” on screen
----------------------------------------------------------------
local canvas  = nil
local label   = nil
local me      = nil   -- local player cache

function self:ClientStart()
    -- full-screen canvas
    canvas = UGUI.CreateScreenCanvas()

    -- TextMeshPro-UGUI label
    label = UGUI.CreateText(canvas)
    label.fontSize = 28
    label.alignment = TextAnchor.UpperLeft
    label.color = Color.white
    label.rectTransform.anchoredPosition = Vector2.new(20, -20)
end

function self:ClientUpdate()
    me = me or World.GetLocalPlayer()
    if not me then return end

    local role = me:GetSharedValue("role") or "?"
    label.text = "ROLE: " .. role
end
