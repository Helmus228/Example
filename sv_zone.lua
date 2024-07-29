util.AddNetworkString('START_ANIM')
util.AddNetworkString('STOP_ANIM')


local function GetZoneTarget()
    local targets = ents.FindInBox(zone.pos1, zone.pos2)

    local ply_in_zone = {}

    for _, ent in pairs(targets) do
        if IsValid(ent) and ent:IsPlayer() then
            table.insert(ply_in_zone, ent)
        end
    end

    return ply_in_zone
end

hook.Add('Think', 'zone_check', function()

    
    local playersInZone = GetZoneTarget()

    local boss = false

    for _, player in pairs(playersInZone) do
        if team.GetName(player:Team()) == zone.boss then
            boss = true
            break
        end
    end

    if boss then
        print("Босс находится в зоне!")

        for _, player in pairs(playersInZone) do
            if team.GetName(player:Team()) ~= zone.boss then
             print("Сообщение для игрока: " .. player:Nick())
             if table.HasValue(zone.targets, team.GetName(player:Team())) then
                print('Player in zone')
              net.Start('START_ANIM')
              net.WriteEntity(player)
              net.Broadcast()
             end
            end
        end
    end
end)






hook.Add("PlayerButtonDown", "StopAnimationKey", function(ply, button)
    if button == KEY_SPACE then 
        net.Start("STOP_ANIM")
        net.WriteEntity(ply)
        net.Broadcast()
    end
end)


print('<-------ZONE LOADED------->')