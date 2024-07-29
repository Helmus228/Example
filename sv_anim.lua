util.AddNetworkString('CustomAnimationPlay')
util.AddNetworkString('CustomAnimationStop')
local function checkDistance(ply)


    if IsValid(ply) and ply:Team() == TEAM_MEDIC then
        local targetPlayer = nil
        local minDist = 1e18

        for _, v in pairs(player.GetAll()) do
            if IsValid(v) and (v:Team() == TEAM_MAYOR or v:Team() == TEAM_MEDIC) then
                local dist = v:GetPos():Distance(ply:GetPos())
                if dist < minDist then
                    minDist = dist
                    targetPlayer = v
                end
            end
        end

        if targetPlayer and minDist < 500 then
            local sequence = "ACT_IDLE" -- Замените на нужное имя вашей анимации
            local sequenceIndex = ply:GetSequence()

            print(sequenceIndex)

            --if sequenceIndex ~= -1 then
                ply:SetSequence(sequenceIndex)

                -- Отправляем сообщение на сервер о начале анимации
                net.Start("CustomAnimationPlay")
                net.WriteString(sequence)
                net.Broadcast()
           -- else
               -- print("Animation not found!")
            --end
        end
    end
end
local function handleSpace(ply)
    if IsValid(ply) and ply:Team() == TEAM_MAYOR then
        ply:ResetSequence(1)

        -- Отправляем сообщение на сервер о остановке анимации
        net.Start("CustomAnimationStop")
        net.WriteEntity(ply)
        net.Broadcast() 
    end
end
hook.Add("PlayerButtonDown", "HandleSpace", function(ply, key)
    if IsValid(ply)and key == KEY_SPACE then
        handleSpace(ply)
    end
end)

hook.Add("Think", "CheckDistance", function()
    for _, ply in pairs(player.GetAll()) do
        if IsValid(ply) then
            checkDistance(ply)
        end
    end
end)














