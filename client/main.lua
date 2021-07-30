ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)
RegisterCommand("id", function(source, args, raw)
  ESX.ShowNotification('Il tuo id è ' .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
  TriggerServerEvent('3dme:shareDisplay', "Controllando il portafoglio")
end)

RegisterCommand("lavoro", function(source, args, raw)
  ESX.ShowNotification('Il tuo lavoro attuale:   ' ..ESX.PlayerData.job.label.. '   grado:   '..ESX.PlayerData.job.grade_label)
  TriggerServerEvent('3dme:shareDisplay', "Controllando il portafoglio")
end)


RegisterCommand("documenti",function(source, args)
  ESX.TriggerServerCallback('esx_commands:getItemAmount', function(qtty)
    if qtty  > 0 then
    documentimenu()
    else 
      ESX.ShowNotification("Non hai i documenti")
    end	
  end, 'Documenti')
    end
  )

  
  RegisterCommand("documenti:dai",function(source, args)
    ESX.TriggerServerCallback('esx_commands:getItemAmount', function(qtty)
      if qtty  > 0 then
      documentidai()
      else 
        ESX.ShowNotification("Non hai i documenti")
      end	
    end, 'Documenti')
      end
    )


  function documentimenu(documenti)
    TriggerServerEvent('3dme:shareDisplay', "Controllando i Documenti")
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
  end

  function documentidai(documenti)
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('3dme:shareDisplay', "Ha dato i documenti")
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
    else
      ESX.ShowNotification('Non ci sono player vicini')
    end
  end