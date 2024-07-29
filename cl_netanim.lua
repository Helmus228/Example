function PlayCustomAnimation(ply, sequenceName)
    if !sequenceName and !string.len(sequenceName) > 1 then return end

    local sequence = ply:LookupSequence(sequenceName)
    if sequence ~= -1 then
        local actName = ply:GetSequenceActivityName(sequence)
        if actName == "" then
            actName = "CustomAnimation"
        end
        ply:SetCycle(0)
        
        ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, sequence, true, true, 1)
        ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, sequence, 0, true)
        ply:SetCycle(0)
    else
        print("Анимация с именем " .. sequenceName .. " не найдена.")
    end
end

net.Receive("CustomAnimationPlay", function()
    local ply = net.ReadEntity()
    local sequenceName = net.ReadString()
    
    PlayCustomAnimation(ply, sequenceName)
end)

net.Receive("CustomAnimationStop", function()
    local ply = net.ReadEntity()
    -- local sequenceName = net.ReadString()
    -- local seqID = net.ReadInt()

    ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
    -- ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, )
end)