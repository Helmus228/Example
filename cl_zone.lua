net.Receive('START_ANIM', function() 

    local ply = net.ReadEntity()
        ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_BOW, true)


    hook.Add("HUDPaint", "HUDPaint_DrawEffects", function()
        -- Чёрный экран
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        
        -- Красный эффект
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    end)

    timer.Create('ResetEffect', 1, 1, function()
        hook.Remove("HUDPaint", "HUDPaint_DrawEffects")
    end)
end)


net.Receive("STOP_ANIM", function()
    local ply = net.ReadEntity()
    if IsValid(ply) and ply:IsPlayer() then
        ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
    end
end)


print('<-------ZONE CLIENT LOADED------->')