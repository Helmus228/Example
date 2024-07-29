local killer = nil 
local victim = nil

-- Здесь необходимо определить sequenceNumber
local sequenceNumber = 0

local function playKillAnim(ply)
    -- Убедитесь, что переменные sequenceNumber и GESTURE_SLOT_VCD определены
    ply:SetSequence(sequenceNumber)
    ply:ResetSequenceInfo()
    ply:SetCycle(0)
    ply:SetPlaybackRate(1)
    ply:AnimRestartGesture(GESTURE_SLOT_VCD, sequenceNumber, false)
end

hook.Add("PlayerDeath", "AnimKill", function(victim, inflictor, attacker)
     if IsValid(attacker) and attacker:IsPlayer() then
     killer = attacker
     playKillAnim(killer)
     end
end)

local function cancelAnim(ply)
    if input.IsKeyDown(KEY_W) and ply == killer then
        StopPlayerAnimation(ply)
    end
end
