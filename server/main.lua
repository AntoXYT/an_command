ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("bank", function(source, args, raw)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	balance = sourceXPlayer.getAccount('bank').money
	sourceXPlayer.showNotification('I tuoi soldi attuali in banca sono:   '..balance)
  end)

  RegisterCommand("sporchi", function(source, args, raw)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	sporchi = sourceXPlayer.getAccount('black_money').money
	sourceXPlayer.showNotification('I tuoi soldi sporchi : '..sporchi)
  end)
  
  ESX.RegisterServerCallback('esx_commands:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)