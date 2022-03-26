ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('prx_tablet:getPlayerInfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)
        local info = {}
		for i=1, #result, 1 do
            info = {job = xPlayer.getJob(), name = xPlayer.getName(), 
            phone =result[i].phone_number, sex =result[i].sex,
            estatura =result[i].height,fecha=result[i].dateofbirth, foto = result[i].foto}
		end
        
    cb(info)
	end)
end)

ESX.RegisterServerCallback('prx_tablet:getItem', function(source, cb)cb(ESX.GetPlayerFromId(source).getInventoryItem('tablet').count)end)

ESX.RegisterServerCallback('prx_tablet:getOwnedVehicles', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
  ['@owner'] = xPlayer.identifier,
}, function(result)
      cb(result)
end)
end)

ESX.RegisterServerCallback('prx_tablet:searchOwnedVehicles', function(source, cb, plate)
  MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate LIKE @plate', {
    ['@plate'] = plate..'%',
}, function(result)
      cb(result)
end)
end)

ESX.RegisterServerCallback('prx_tablet:getOwnedHouses', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.fetchAll('SELECT * FROM loaf_keys WHERE identifier = @owner', {
  ['@owner'] = xPlayer.identifier,
}, function(result)
      cb(result)
end)
end)

ESX.RegisterServerCallback('search_pers', function(source, cb, words)
  if words[2] == nil and words[1]~=nil then

    MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname LIKE @name', {
          ['@name'] = '%'..words[1]..'%',
      }, function(result)
          
      cb(result)
      end)
  elseif words[2] ~=nil and words[1]~= nil then
    MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname LIKE @name AND lastname LIKE @lastname', {
          ['@name'] = '%'..words[1]..'%', ['@lastname'] = '%'..words[2]..'%',
      }, function(result)
          
      cb(result)
      end)
  end
end)

ESX.RegisterServerCallback('prx_tablet:getOtherPlayerInfo', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromIdentifier(id)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = id,
	}, function(result)
        local info = {}
        local job = {}
		for i=1, #result, 1 do
            MySQL.Async.fetchAll('SELECT * FROM jobs WHERE name = @name', {
              ['@name'] = result[i].job,
            }, function(result2)
              for i=1, #result2, 1 do    
                MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @name AND grade = @grade', {
                  ['@name'] = result[i].job, ['@grade'] = result[i].job_grade,
                }, function(result3)
                  for i=1, #result3, 1 do    
                    job = {label = result2[i].label, grade_label = result3[i].label, name = result[i].job, grade = result[i].job_grade}
                  end
                end)
              end
            end)
            local billMoney = 0
            MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @id', {
              ['@id'] = id,
            }, function(result2)
              for i=1, #result2, 1 do    
               billMoney = billMoney + result2[i].amount
              end
            end)

            Citizen.Wait(200)
            info = {job = job, name = result[i].firstname..' '..result[i].lastname, 
            phone =result[i].phone_number, sex =result[i].sex,
            estatura =result[i].height,fecha=result[i].dateofbirth, identifier = id, foto = result[i].foto, sinPagar = billMoney}
		end
        
    cb(info)
	end)
end)

RegisterServerEvent('prx_tablet:actFoto')
AddEventHandler('prx_tablet:actFoto', function(foto, id)
  local xTarget = ESX.GetPlayerFromIdentifier(id)
  MySQL.Async.execute('UPDATE users SET foto = @foto WHERE identifier = @identifier', {
    ['@identifier'] = xTarget.identifier,
    ['@foto'] = foto
}, function(rowsChanged)
   -- cb()
  end)
end)

RegisterServerEvent('prx_tablet:addDelito')
AddEventHandler('prx_tablet:addDelito', function(identifier, label, price, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    MySQL.Async.execute('INSERT INTO prx_tab_lspd_hist (identifier, content, fine, time, officer) VALUES (@identifier, @content, @fine, @time, @officer)', {
      ['@identifier'] = identifier,
      ['@content'] = label,
      ['@fine'] = tostring(price),
      ['@time'] = tostring(time),
      ['@officer'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
  }, function(rowsChanged)
  end)

    MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
      ['@identifier'] = identifier,
      ['@sender'] = xPlayer.getIdentifier(),
      ['@target_type'] = 'society',
      ['@target'] = 'society_police',
      ['@label'] = label,
      ['@amount'] = price,
  }, function(rowsChanged)
      if xTarget ~= nil then  
        xTarget.showNotification('Has sido multado por ~r~'..label)
      end
  end)

  TriggerClientEvent('prx_tablet:updateDelitos', source, identifier)
end)

ESX.RegisterServerCallback('prx_tablet:getDelitos', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_lspd_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

ESX.RegisterServerCallback('prx_tablet:getDelitosPerf', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local id = xPlayer.getIdentifier()
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_lspd_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_delito')
AddEventHandler('prx_tablet:eliminar_delito', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_lspd_hist WHERE identifier = @id AND officer = @officer AND content = @label", {
    ['@id'] = id,
    ['@officer'] = info.officer,
    ['@label'] = info.label,
  },
    function (result)
      MySQL.Async.execute("DELETE FROM billing WHERE identifier = @id AND label = @label", {
        ['@id'] = id,
        ['@label'] = info.label,
      },
        function (result2)
          
        end)
    end)
  TriggerClientEvent('prx_tablet:updateDelitos', source, id)
end)

RegisterServerEvent('prx_tablet:añadirNota')
AddEventHandler('prx_tablet:añadirNota', function(nota, id)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.execute('INSERT INTO prx_tab_lspd_notes (identifier, officer, note) VALUES (@identifier, @sender, @note)', {
    ['@identifier'] = id,
    ['@sender'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
    ['@note'] = nota,
}, function(rowsChanged)
  end)
  TriggerClientEvent('prx_tablet:updateNotas', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getNotas', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_lspd_notes WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_nota')
AddEventHandler('prx_tablet:eliminar_nota', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_lspd_notes WHERE identifier = @id AND officer = @officer AND note = @label", {
    ['@id'] = id,
    ['@officer'] = info.officer,
    ['@label'] = info.label,
  },
    function (result)
    end)
  TriggerClientEvent('prx_tablet:updateNotas', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getOtherHouses', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM loaf_keys WHERE identifier = @owner', {
  ['@owner'] = id,
}, function(result)
      cb(result)
end)
end)

ESX.RegisterServerCallback('prx_tablet:getOtherVehicles', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
  ['@owner'] = id,
}, function(result)
      cb(result)
end)
end)

RegisterServerEvent('prx_tablet:añadir_busqueda')
AddEventHandler('prx_tablet:añadir_busqueda', function(nota, id)
  MySQL.Async.execute('UPDATE users SET search = @search WHERE identifier = @identifier', {
    ['@identifier'] = id,
    ['@search'] = '{"inSearch":true,"motivo":"'..nota..'"}',
}, function(rowsChanged)
   -- cb()
  end)
  TriggerClientEvent('prx_tablet:updateSearch', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getSearch', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:delete_busqueda')
AddEventHandler('prx_tablet:delete_busqueda', function(id)
  MySQL.Async.execute('UPDATE users SET search = @search WHERE identifier = @identifier', {
    ['@identifier'] = id,
    ['@search'] = '{"inSearch":false,"motivo":""}',
}, function(rowsChanged)
   -- cb()
  end)
  TriggerClientEvent('prx_tablet:updateSearch', source, id)
end)

RegisterServerEvent('prx_tablet:añadir_danger')
AddEventHandler('prx_tablet:añadir_danger', function(nota, id)
  MySQL.Async.execute('UPDATE users SET dangerous = @danger WHERE identifier = @identifier', {
    ['@identifier'] = id,
    ['@danger'] = '{"danger":true,"motivo":"'..nota..'"}',
}, function(rowsChanged)
   -- cb()
  end)
  TriggerClientEvent('prx_tablet:updateDanger', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getDanger', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:delete_danger')
AddEventHandler('prx_tablet:delete_danger', function(id)
  MySQL.Async.execute('UPDATE users SET dangerous = @danger WHERE identifier = @identifier', {
    ['@identifier'] = id,
    ['@danger'] = '{"danger":false,"motivo":""}',
}, function(rowsChanged)
   -- cb()
  end)
  TriggerClientEvent('prx_tablet:updateDanger', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getAllSearch', function(source, cb)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE search != @search', {
    ['@search'] = '{"inSearch":false,"motivo":""}',
}, function(result)
    
cb(result)
end)
end)

RegisterServerEvent('prx_tablet:addTrat')
AddEventHandler('prx_tablet:addTrat', function(identifier, label, price, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    MySQL.Async.execute('INSERT INTO prx_tab_ems_hist (identifier, doctor, label, price) VALUES (@identifier, @doctor, @label, @price)', {
      ['@identifier'] = identifier,
      ['@doctor'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
      ['@label'] = label,
      ['@price'] = tostring(price)..' $',
  }, function(rowsChanged)
  end)

    MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
      ['@identifier'] = identifier,
      ['@sender'] = xPlayer.getIdentifier(),
      ['@target_type'] = 'society',
      ['@target'] = 'society_ambulance',
      ['@label'] = label,
      ['@amount'] = price,
  }, function(rowsChanged)
      if xTarget ~= nil then  
        xTarget.showNotification('Te ha llegado una factura médica: ~r~'..label)
      end
  end)

  TriggerClientEvent('prx_tablet:updateHistEMS', source, identifier)
end)

ESX.RegisterServerCallback('prx_tablet:getHistEMS', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_ems_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_hist_ems')
AddEventHandler('prx_tablet:eliminar_hist_ems', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_ems_hist WHERE identifier = @id AND doctor = @doctor AND label = @label", {
    ['@id'] = id,
    ['@doctor'] = info.officer,
    ['@label'] = info.label,
  },
    function (result)
      MySQL.Async.execute("DELETE FROM billing WHERE identifier = @id AND label = @label", {
        ['@id'] = id,
        ['@label'] = info.label,
      },
        function (result2)
          
        end)
    end)
    TriggerClientEvent('prx_tablet:updateHistEMS', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getHistEmsPerf', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local id = xPlayer.getIdentifier()
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_ems_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:añadirNotaEms')
AddEventHandler('prx_tablet:añadirNotaEms', function(nota, id)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.execute('INSERT INTO prx_tab_ems_notes (identifier, sender, label) VALUES (@identifier, @sender, @note)', {
    ['@identifier'] = id,
    ['@sender'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
    ['@note'] = nota,
}, function(rowsChanged)
  end)
  TriggerClientEvent('prx_tablet:updateNotasEms', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getNotasEms', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_ems_notes WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_nota_ems')
AddEventHandler('prx_tablet:eliminar_nota_ems', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_ems_notes WHERE identifier = @id AND sender = @officer AND label = @label", {
    ['@id'] = id,
    ['@officer'] = info.sender,
    ['@label'] = info.label,
  },
    function (result)
    end)
  TriggerClientEvent('prx_tablet:updateNotasEms', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getEmpresaInfo', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getJob().grade_name == 'boss' then
    MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job', {
      ['@job'] = xPlayer.getJob().name,
    }, function(result)
        local info = {}
        for i=1, #result, 1 do
          MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE grade = @grade AND job_name = @job_name', {
            ['@grade'] = result[i].job_grade,
            ['@job_name'] = result[i].job,
          }, function(result2)
            table.insert(info, {user = result[i], job = result2[1]})
              
          end)
        end
        Citizen.Wait(500)
        cb(info)
    end)
  end
end)

ESX.RegisterServerCallback('prx_tablet:getStockItems', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local job = xPlayer.getJob().name
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
    if Config.UseJobCreator == true then
      MySQL.Async.fetchAll('SELECT * FROM jobs_data WHERE job_name = @job AND type = @type', {
        ['@type'] = 'stash',
        ['@job'] = job,
      }, function(result)
            local info = inventory.items
            local decript = json.decode(result[1].data)
            for k in pairs(decript) do
              table.insert(info, {name = k, label = ESX.GetItemLabel(k), count = decript[k]})
            end
            Citizen.Wait(100)
            cb(info)
      end)
    else
      cb(inventory.items)
    end
	end)
end)

RegisterServerEvent('prx_tablet:degradarPlayer')
AddEventHandler('prx_tablet:degradarPlayer', function(info)
  local xPlayer = ESX.GetPlayerFromIdentifier(info.user.identifier)
  if xPlayer ~= nil then
    xPlayer.setJob(info.user.job, tonumber(info.user.job_grade) - 1)
  else
    local grade = 0

    if tonumber(info.user.job_grade) ~= 0 then
      grade = tonumber(info.user.job_grade) - 1

    end
    MySQL.Async.execute('UPDATE users SET job_grade = @jobgrade WHERE identifier = @identifier', {
      ['@identifier'] = info.user.identifier,
      ['@jobgrade'] = grade,
    },function(rowsChanged)

      end)
  end
  TriggerClientEvent('prx_tablet:updateEmpresa', source)
end)

RegisterServerEvent('prx_tablet:ascenderPlayer')
AddEventHandler('prx_tablet:ascenderPlayer', function(info)
  local xPlayer = ESX.GetPlayerFromIdentifier(info.user.identifier)
  if xPlayer ~= nil then
    xPlayer.setJob(info.user.job, tonumber(info.user.job_grade) + 1)
  else
    local grade = 0
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name AND name = @name', {
      ['@job_name'] = info.user.job,
      ['@name'] = 'boss',
    }, function(result)
        for i=1, #result, 1 do
        if result[i].grade > tonumber(info.user.job_grade) + 1 then
          grade = tonumber(info.user.job_grade) + 1
        else 
          grade = result[i].grade
        end
        end
    end)
    Citizen.Wait(500)
    MySQL.Async.execute('UPDATE users SET job_grade = @jobgrade WHERE identifier = @identifier', {
      ['@identifier'] = info.user.identifier,
      ['@jobgrade'] = grade,
    },function(rowsChanged)

      end)
  end
  TriggerClientEvent('prx_tablet:updateEmpresa', source)
end)

RegisterServerEvent('prx_tablet:despedirPlayer')
AddEventHandler('prx_tablet:despedirPlayer', function(info)
  local xPlayer = ESX.GetPlayerFromIdentifier(info.user.identifier)
  if xPlayer ~= nil then
    xPlayer.setJob('unemployed', 0)
  else
    MySQL.Async.execute('UPDATE users SET job_grade = @jobgrade, job = @job WHERE identifier = @identifier', {
      ['@identifier'] = info.user.identifier,
      ['@jobgrade'] = 0,
      ['@job'] = 'unemployed',
    },function(rowsChanged)

      end)
  end
  TriggerClientEvent('prx_tablet:updateEmpresa', source)
end)


RegisterServerEvent('prx_tablet:addFine')
AddEventHandler('prx_tablet:addFine', function(identifier, label, price, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    MySQL.Async.execute('INSERT INTO prx_tab_meca_hist (identifier, doctor, label, price) VALUES (@identifier, @doctor, @label, @price)', {
      ['@identifier'] = identifier,
      ['@doctor'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
      ['@label'] = label,
      ['@price'] = tostring(price)..' $',
  }, function(rowsChanged)
  end)

    MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
      ['@identifier'] = identifier,
      ['@sender'] = xPlayer.getIdentifier(),
      ['@target_type'] = 'society',
      ['@target'] = 'society_mechanic',
      ['@label'] = label,
      ['@amount'] = price,
  }, function(rowsChanged)
      if xTarget ~= nil then  
        xTarget.showNotification('Te ha llegado una factura: ~r~'..label)
      end
  end)

  TriggerClientEvent('prx_tablet:updateHistmeca', source, identifier)
end)

ESX.RegisterServerCallback('prx_tablet:getHistmeca', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_meca_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_hist_meca')
AddEventHandler('prx_tablet:eliminar_hist_meca', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_meca_hist WHERE identifier = @id AND doctor = @doctor AND label = @label", {
    ['@id'] = id,
    ['@doctor'] = info.officer,
    ['@label'] = info.label,
  },
    function (result)
      MySQL.Async.execute("DELETE FROM billing WHERE identifier = @id AND label = @label", {
        ['@id'] = id,
        ['@label'] = info.label,
      },
        function (result2)
          
        end)
    end)
    TriggerClientEvent('prx_tablet:updateHistmeca', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getHistmecaPerf', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local id = xPlayer.getIdentifier()
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_meca_hist WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:añadirNotameca')
AddEventHandler('prx_tablet:añadirNotameca', function(nota, id)
  local xPlayer = ESX.GetPlayerFromId(source)
  MySQL.Async.execute('INSERT INTO prx_tab_meca_notes (identifier, sender, label) VALUES (@identifier, @sender, @note)', {
    ['@identifier'] = id,
    ['@sender'] = xPlayer.getJob().grade_label..' '..xPlayer.getName(),
    ['@note'] = nota,
}, function(rowsChanged)
  end)
  TriggerClientEvent('prx_tablet:updateNotasmeca', source, id)
end)

ESX.RegisterServerCallback('prx_tablet:getNotasmeca', function(source, cb, id)
  MySQL.Async.fetchAll('SELECT * FROM prx_tab_meca_notes WHERE identifier LIKE @identifier', {
		['@identifier'] = id,
	}, function(result)
      
    cb(result)
	end)
end)

RegisterServerEvent('prx_tablet:eliminar_nota_meca')
AddEventHandler('prx_tablet:eliminar_nota_meca', function(info, id)
  MySQL.Async.execute("DELETE FROM prx_tab_meca_notes WHERE identifier = @id AND sender = @officer AND label = @label", {
    ['@id'] = id,
    ['@officer'] = info.sender,
    ['@label'] = info.label,
  },
    function (result)
    end)
  TriggerClientEvent('prx_tablet:updateNotasmeca', source, id)
end)