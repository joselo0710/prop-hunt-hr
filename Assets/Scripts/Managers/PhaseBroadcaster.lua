--!Type(Server)

function self:ServerStart()
    print("🛰️ PhaseBroadcaster active on server")
end

function self:ServerUpdate()
    if self.Client and self.Client.GetPhase then
        local phase = self.Client:GetPhase()
        local shared = self:GetSharedValue("phase")

        if phase and phase ~= shared then
            self:SetSharedValue("phase", phase)
            print("🔁 Synced phase → " .. phase)
        end
    end
end
