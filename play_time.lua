local PLAY_TIME_KEY = "PlayTime"
local START_TIME_KEY = "StartTime"
local LAST_RESET_TIME_KEY = "LastResetTime"
local RESET_HOUR = 4

local function UpdatePlayerTime(ply)
 local currentTime = CurTime()
 local lastResetTime = ply:GetPData(LAST_RESET_TIME_KEY, currentTime)


 local serverTime = os.date("*t")

 if serverTime.hour >= RESET_HOUR and os.date("%H:%M", lastResetTime) ~= os.date("%H:%M", currentTime) then
  ResetPlayerTimes()
  ply:SetPData(LAST_RESET_TIME_KEY, currentTime)
 end

 local playTime = ply:GetPData(PLAY_TIME_KEY, 0)
 local playTimeInMinutes = playTime / 60
 ply:SetPData(PLAY_TIME_KEY, playTimeInMinutes + (currentTime - lastResetTime) / 60)
 ply:SetNWInt(PLAY_TIME_KEY, ply:GetPData(PLAY_TIME_KEY, 0))
end


hook.Add("PlayerInitialSpawn", "StartTimeRecording", function(ply)
 UpdatePlayerTime(ply)
 ply.StartTime = CurTime()
 ply:SetNWInt(START_TIME_KEY, ply.StartTime)
 ply:SetPData(START_TIME_KEY, ply.StartTime)
end)

hook.Add("PlayerDisconnected", "UpdatePlayerTimeOnDisconnect", function(ply)
 UpdatePlayerTime(ply)
 local startTime = ply:GetPData(START_TIME_KEY, 0)
 local endTime = CurTime()
 local elapsedTime = endTime - startTime
 ply:SetPData(PLAY_TIME_KEY, ply:GetPData(PLAY_TIME_KEY, 0) + elapsedTime)
 ply:SetNWInt("PlayedTime", ply:GetPData(PLAY_TIME_KEY, 0) + elapsedTime)
end)


hook.Add("PlayerPostThink", "ResetData", function(ply)
 local serverTime = os.date( "%H", CurTime() )
 if serverTime == "04" then
    ply:RemovePData(START_TIME_KEY)
    ply:RemovePData(PLAY_TIME_KEY)
 end
end)