ESX = nil
local abierto = false
local PlayerProps = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local lastIdentifier = ''

RegisterKeyMapping(
	'tablet', 
	'Abrir la Tablet', 
	'keyboard', 
	'HOME'
)

RegisterCommand('tablet', function()
    ESX.TriggerServerCallback('prx_tablet:getPlayerInfo', function(playerInfo) 
        if abierto == false then
            if Config.UseItem == true then
                ESX.TriggerServerCallback('prx_tablet:getItem', function(item) 
                    if item >= 1 then
                        --ExecuteCommand('e tablet2')
                        startAnim('amb@code_human_in_bus_passenger_idles@female@tablet@idle_a', 'idle_a')
                        Citizen.Wait(1000)
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            playerInfo = playerInfo,
                            vip = Config.VIPinPerfil,
                            abrir = true
                        })
                        abierto = true
                    else
                        ESX.ShowNotification('No tienes una tablet encima')
                    end
                end)
            else
                --ExecuteCommand('e tablet2')
                startAnim('amb@code_human_in_bus_passenger_idles@female@tablet@idle_a', 'idle_a')
                Citizen.Wait(1000)
                SetNuiFocus(true, true)
                SendNUIMessage({
                    playerInfo = playerInfo,
                    vip = Config.VIPinPerfil,
                    abrir = true
                })
                abierto = true
            end
        elseif abierto == true then
            SetNuiFocus(false, false)
            SendNUIMessage({
                abrir = false
                
            })
            abierto = false
            Citizen.Wait(1000)
            EmoteCancel()
            --ExecuteCommand('cancelaranimacion')
            
        end

    end, nil)
end, false)
RegisterNUICallback('cerrar_tablet', function()
    SetNuiFocus(false, false)
            SendNUIMessage({
                abrir = false
                
            })
            abierto = false
            Citizen.Wait(1000)
            --ExecuteCommand('cancelaranimacion')
            EmoteCancel()
end)

RegisterNUICallback('get_owned_vehicles', function()
    ESX.TriggerServerCallback('prx_tablet:getOwnedVehicles', function(vehicles) 
        local coches = {}
        for i=1, #vehicles, 1 do
            local properties = json.decode(vehicles[i].vehicle)
            local modelo = GetDisplayNameFromVehicleModel(properties.model)
            
            table.insert(coches,{modelo=modelo, plate=vehicles[i].plate, garage=vehicles[i].garage})
        end

        SendNUIMessage({
            vehicles = coches
        })
    end, nil)
end)

RegisterNUICallback('get_owned_houses', function()
    ESX.TriggerServerCallback('prx_tablet:getOwnedHouses', function(houses) 
        local propiedades = {}
        for i=1, #houses, 1 do
            local properties = json.decode(houses[i].key_data)
            local label = string.gsub(properties.name, "Llaves de Casa ", "")
            
            table.insert(propiedades,{label=label})
        end
        SendNUIMessage({
            houseLabel = propiedades
        })
    end, nil)
end)

RegisterNUICallback('lspd_search_person', function(nom)
    local words = {}
    for word in nom:gmatch("%w+") do table.insert(words, word) end
    ESX.TriggerServerCallback('search_pers', function(info) 
            SendNUIMessage({
                foundPlayers = info
            })
    end, words)
end)

RegisterNUICallback('lspd_search_car', function(nom)
    ESX.TriggerServerCallback('prx_tablet:searchOwnedVehicles', function(info) 
        local coches = {}
        for i=1, #info, 1 do
            local properties = json.decode(info[i].vehicle)
            local modelo = GetDisplayNameFromVehicleModel(properties.model)
            
            table.insert(coches,{modelo=modelo, plate=info[i].plate, garage=info[i].garage, identifier = info[i].owner})
        end
        SendNUIMessage({
            foundVehicles = coches
        })

            
    end, nom)
end)

RegisterNUICallback('get_other_person_info', function(nom)
    ESX.TriggerServerCallback('prx_tablet:getOtherPlayerInfo', function(plInfo) 
        lastIdentifier = ''
        SendNUIMessage({
            otherLInfo = plInfo
        })
        lastIdentifier = plInfo.identifier
    end, nom)
end)

RegisterNUICallback('lspd_act_foto', function(foto)
    TriggerServerEvent('prx_tablet:actFoto', foto, lastIdentifier)
        
end)

RegisterNUICallback('lspd_get_pc', function()
    SendNUIMessage({
        codPenal = Config.PenalCode
    })
end)

RegisterNUICallback('lspd_get_list_multas', function()
    SendNUIMessage({
        multasList = Config.PenalCode
    })
end)

RegisterNUICallback('search_cp', function(search)
    local result = {}
    for i=1, #Config.PenalCode, 1 do
        if string.find(string.lower(Config.PenalCode[i].label), string.lower(search)) then
            table.insert(result,{title = Config.PenalCode[i].title, label = Config.PenalCode[i].label, time = Config.PenalCode[i].time,price= Config.PenalCode[i].price})
        end
    end
    if result ~= {} then
        SendNUIMessage({
            codPenal = result
        })
    else
        SendNUIMessage({
            codPenal = Config.PenalCode
        })
    end
end)

RegisterNUICallback('search_delitos', function(search)
    local result = {}
    for i=1, #Config.PenalCode, 1 do
        if string.find(string.lower(Config.PenalCode[i].label), string.lower(search)) then
            table.insert(result,{title = Config.PenalCode[i].title, label = Config.PenalCode[i].label, time = Config.PenalCode[i].time,price= Config.PenalCode[i].price})
        end
    end
    if result ~= {} then
        SendNUIMessage({
            multasList = result
        })
    else
        SendNUIMessage({
            multasList = Config.PenalCode
        })
    end
end)

RegisterNUICallback('add_delito', function(info)
    local price = tonumber(info.price)
    TriggerServerEvent('prx_tablet:addDelito', lastIdentifier, info.label, price, info.time)
end)

RegisterNetEvent('prx_tablet:updateDelitos')
AddEventHandler('prx_tablet:updateDelitos', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getDelitos', function(info) 
        SendNUIMessage({
            delitosPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('get_delitos', function()
    ESX.TriggerServerCallback('prx_tablet:getDelitos', function(info)
        SendNUIMessage({
            delitosPersona = info
        })    
    end, lastIdentifier)
end)

RegisterNUICallback('get_delitos_perf', function()
    ESX.TriggerServerCallback('prx_tablet:getDelitosPerf', function(info)
        SendNUIMessage({
            delitosPerfil = info
        })    
    end)
end)

RegisterNUICallback('del_delito', function(info)
    TriggerServerEvent('prx_tablet:eliminar_delito', info, lastIdentifier)
end)

RegisterNUICallback('add_nota', function(label)
    TriggerServerEvent('prx_tablet:añadirNota', label, lastIdentifier)
end)

RegisterNetEvent('prx_tablet:updateNotas')
AddEventHandler('prx_tablet:updateNotas', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getNotas', function(info) 
        SendNUIMessage({
            notasPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('get_notas', function()
    TriggerEvent('prx_tablet:updateNotas', lastIdentifier)
end)

RegisterNUICallback('del_nota', function(info)
    TriggerServerEvent('prx_tablet:eliminar_nota', info, lastIdentifier)
end)

RegisterNUICallback('lspd_get_veh', function()
    ESX.TriggerServerCallback('prx_tablet:getOtherVehicles', function(vehicles) 
        local coches = {}
        for i=1, #vehicles, 1 do
            local properties = json.decode(vehicles[i].vehicle)
            local modelo = GetDisplayNameFromVehicleModel(properties.model)
            table.insert(coches,{modelo=modelo, plate=vehicles[i].plate, garage=vehicles[i].garage})
        end

        SendNUIMessage({
            otherVehicles = coches
        })
    end, lastIdentifier)
end)

RegisterNUICallback('lspd_get_prop', function()
    ESX.TriggerServerCallback('prx_tablet:getOtherHouses', function(houses) 
        local propiedades = {}
        for i=1, #houses, 1 do
            local properties = json.decode(houses[i].key_data)
            local label = string.gsub(properties.name, "Llaves de Casa ", "")
            table.insert(propiedades,{label=label})
        end
        SendNUIMessage({
            otherHouseLabel = propiedades
        })
    end, lastIdentifier)
end)

RegisterNUICallback('add_busqueda', function(nota)
    TriggerServerEvent('prx_tablet:añadir_busqueda',nota, lastIdentifier)
end)

RegisterNetEvent('prx_tablet:updateSearch')
AddEventHandler('prx_tablet:updateSearch', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getSearch', function(info) 
        for i = 1, #info, 1 do
            SendNUIMessage({
                busquedaPersona = json.decode(info[i].search)
            })    
        end
    end, identifier)
end)

RegisterNUICallback('get_busqueda_list', function(id)
    TriggerEvent('prx_tablet:updateSearch', id)
end)

RegisterNUICallback('get_busqueda', function()
    TriggerEvent('prx_tablet:updateSearch', lastIdentifier)
end)

RegisterNUICallback('delete_busqueda', function()
    TriggerServerEvent('prx_tablet:delete_busqueda',lastIdentifier)
end)

RegisterNUICallback('add_danger', function(nota)
    TriggerServerEvent('prx_tablet:añadir_danger',nota, lastIdentifier)
end)

RegisterNetEvent('prx_tablet:updateDanger')
AddEventHandler('prx_tablet:updateDanger', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getDanger', function(info) 
        for i = 1, #info, 1 do
            SendNUIMessage({
                personaDanger = json.decode(info[i].dangerous)
            })    
        end
    end, identifier)
end)

RegisterNUICallback('get_danger_list', function(id)
    TriggerEvent('prx_tablet:updateDanger', id)
end)

RegisterNUICallback('get_danger', function()
    TriggerEvent('prx_tablet:updateDanger', lastIdentifier)
end)

RegisterNUICallback('delete_danger', function()
    TriggerServerEvent('prx_tablet:delete_danger',lastIdentifier)
end)

RegisterNUICallback('get_all_byq', function()
    local totalBusquedas = {}
    ESX.TriggerServerCallback('prx_tablet:getAllSearch', function(info) 
        for i = 1, #info, 1 do
            local usuarios = json.decode(info[i].search)
            if usuarios.inSearch == true then
                table.insert(totalBusquedas, {image = info[i].foto, id = info[i].identifier, name = info[i].firstname..' '..info[i].lastname})
            end
        end
    end)
    Citizen.Wait(1000)
    SendNUIMessage({
        allBusquedas = totalBusquedas
    })
end)

RegisterNUICallback('ems_get_trt', function()
    SendNUIMessage({
        tratamientos = Config.Treatments
    })
end)

RegisterNUICallback('search_trt', function(search)
    local result = {}
    for i=1, #Config.Treatments, 1 do
        if string.find(string.lower(Config.Treatments[i].label), string.lower(search)) then
            table.insert(result,{title = Config.Treatments[i].title, label = Config.Treatments[i].label, price= Config.Treatments[i].price})
        end
    end
    if result ~= {} then
        SendNUIMessage({
            tratamientos = result
        })
    else
        SendNUIMessage({
            tratamientos = Config.Treatments
        })
    end
end)

RegisterNUICallback('ems_search_person', function(nom)
    local words = {}
    for word in nom:gmatch("%w+") do table.insert(words, word) end
    ESX.TriggerServerCallback('search_pers', function(info) 
            SendNUIMessage({
                foundEMSPlayers = info
            })
    end, words)
end)

RegisterNUICallback('ems_get_other_person_info', function(nom)
    ESX.TriggerServerCallback('prx_tablet:getOtherPlayerInfo', function(plInfo) 
        lastIdentifier = ''
        SendNUIMessage({
            otherEMSLInfo = plInfo
        })
        lastIdentifier = plInfo.identifier
    end, nom)
end)

RegisterNUICallback('ems_get_list_trats', function()
    SendNUIMessage({
        tratsList = Config.Treatments
    })
end)

RegisterNUICallback('search_trats',function(search)
    local result = {}
        for i=1, #Config.Treatments, 1 do
            if string.find(string.lower(Config.Treatments[i].label), string.lower(search)) then
                table.insert(result,{title = Config.Treatments[i].title, label = Config.Treatments[i].label, time = Config.Treatments[i].time,price= Config.Treatments[i].price})
            end
        end
        if result ~= {} then
            SendNUIMessage({
                tratsList = result
            })
        else
            SendNUIMessage({
                tratsList = Config.Treatments
            })
        end
end)

RegisterNUICallback('add_trat', function(info)
    local price = tonumber(info.price)
    TriggerServerEvent('prx_tablet:addTrat', lastIdentifier, info.label, price, info.time)
end)

RegisterNetEvent('prx_tablet:updateHistEMS')
AddEventHandler('prx_tablet:updateHistEMS', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getHistEMS', function(info) 
        SendNUIMessage({
            histmedicoPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('del_hist_ems', function(info)
    TriggerServerEvent('prx_tablet:eliminar_hist_ems', info, lastIdentifier)
end)

RegisterNUICallback('get_hist_ems', function(id)
    ESX.TriggerServerCallback('prx_tablet:getHistEMS', function(info)
        SendNUIMessage({
            histmedicoPersona = info
        })    
    end, id)
end)

RegisterNUICallback('get_hist_ems_perf', function()
    ESX.TriggerServerCallback('prx_tablet:getHistEmsPerf', function(info)
        SendNUIMessage({
            medicoPerfil = info
        })    
    end)
end)

RegisterNUICallback('add_nota_ems', function(label)
    TriggerServerEvent('prx_tablet:añadirNotaEms', label, lastIdentifier)
end)

RegisterNetEvent('prx_tablet:updateNotasEms')
AddEventHandler('prx_tablet:updateNotasEms', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getNotasEms', function(info) 
        SendNUIMessage({
            notasEMSPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('get_notas_ems', function()
    TriggerEvent('prx_tablet:updateNotasEms', lastIdentifier)
end)

RegisterNUICallback('del_nota_ems', function(info)
    TriggerServerEvent('prx_tablet:eliminar_nota_ems', info, lastIdentifier)
end)

RegisterNUICallback('cambiar_size', function(label)
        local scale = tonumber(label)
        SendNUIMessage({
            scale = scale /100
        })
end)

RegisterNUICallback('get_info_empresa', function()
    ESX.TriggerServerCallback('prx_tablet:getEmpresaInfo', function(info) 
        SendNUIMessage({trabajadores = info})
    end)
    ESX.TriggerServerCallback('prx_tablet:getStockItems', function(items)
        SendNUIMessage({stockItems = items})
    end)
end)

RegisterNetEvent('prx_tablet:updateEmpresa')
AddEventHandler('prx_tablet:updateEmpresa', function()
    ESX.TriggerServerCallback('prx_tablet:getEmpresaInfo', function(info) 
        SendNUIMessage({trabajadores = info})
    end)
    ESX.TriggerServerCallback('prx_tablet:getStockItems', function(items)
		SendNUIMessage({stockItems = items})
	end)
end)

RegisterNUICallback('degradar', function(info)
    TriggerServerEvent('prx_tablet:degradarPlayer', info)
end)

RegisterNUICallback('ascender', function(info)
    TriggerServerEvent('prx_tablet:ascenderPlayer', info)
end)

RegisterNUICallback('despedir', function(info)
    TriggerServerEvent('prx_tablet:despedirPlayer', info)
end)


RegisterNUICallback('meca_get_trt', function()
    SendNUIMessage({
        preciosMeca = Config.MecaPrices
    })
end)

RegisterNUICallback('search_mecaPrice', function(search)
    local result = {}
    for i=1, #Config.MecaPrices, 1 do
        if string.find(string.lower(Config.MecaPrices[i].label), string.lower(search)) then
            table.insert(result,{title = Config.MecaPrices[i].title, label = Config.MecaPrices[i].label, price= Config.MecaPrices[i].price})
        end
    end
    if result ~= {} then
        SendNUIMessage({
            preciosMeca = result
        })
    else
        SendNUIMessage({
            preciosMeca = Config.MecaPrices
        })
    end
end)

RegisterNUICallback('meca_search_person', function(nom)
    local words = {}
    for word in nom:gmatch("%w+") do table.insert(words, word) end
    ESX.TriggerServerCallback('search_pers', function(info) 
            SendNUIMessage({
                foundmecaPlayers = info
            })
    end, words)
end)

RegisterNUICallback('meca_get_other_person_info', function(nom)
    ESX.TriggerServerCallback('prx_tablet:getOtherPlayerInfo', function(plInfo) 
        lastIdentifier = ''
        SendNUIMessage({
            othermecaLInfo = plInfo
        })
        lastIdentifier = plInfo.identifier
    end, nom)
end)

RegisterNUICallback('meca_get_list_trats', function()
    SendNUIMessage({
        preciosMecaList = Config.MecaPrices
    })
end)

RegisterNUICallback('search_mecaPriceList',function(search)
    local result = {}
    for i=1, #Config.MecaPrices, 1 do
        if string.find(string.lower(Config.MecaPrices[i].label), string.lower(search)) then
            table.insert(result,{title = Config.MecaPrices[i].title, label = Config.MecaPrices[i].label, price= Config.MecaPrices[i].price})
        end
    end
    if result ~= {} then
        SendNUIMessage({
            preciosMecaList = result
        })
    else
        SendNUIMessage({
            preciosMecaList = Config.MecaPrices
        })
    end
end)

RegisterNUICallback('add_fine', function(info)
    local price = tonumber(info.price)
    TriggerServerEvent('prx_tablet:addFine', lastIdentifier, info.label, price, info.time)
end)

RegisterNetEvent('prx_tablet:updateHistmeca')
AddEventHandler('prx_tablet:updateHistmeca', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getHistmeca', function(info) 
        SendNUIMessage({
            histmecanicoPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('del_hist_meca', function(info)
    TriggerServerEvent('prx_tablet:eliminar_hist_meca', info, lastIdentifier)
end)

RegisterNUICallback('get_hist_meca', function(id)
    ESX.TriggerServerCallback('prx_tablet:getHistmeca', function(info)
        SendNUIMessage({
            histmecanicoPersona = info
        })    
    end, id)
end)

RegisterNUICallback('get_hist_meca_perf', function()
    ESX.TriggerServerCallback('prx_tablet:getHistmecaPerf', function(info)
        SendNUIMessage({
            mecanicoPerfil = info
        })    
    end)
end)

RegisterNUICallback('add_nota_meca', function(label)
    TriggerServerEvent('prx_tablet:añadirNotameca', label, lastIdentifier)
end)

RegisterNetEvent('prx_tablet:updateNotasmeca')
AddEventHandler('prx_tablet:updateNotasmeca', function(identifier)
    ESX.TriggerServerCallback('prx_tablet:getNotasmeca', function(info) 
        SendNUIMessage({
            notasmecaPersona = info
        })    
    end, identifier)
end)

RegisterNUICallback('get_notas_meca', function()
    TriggerEvent('prx_tablet:updateNotasmeca', lastIdentifier)
end)

RegisterNUICallback('del_nota_meca', function(info)
    TriggerServerEvent('prx_tablet:eliminar_nota_meca', info, lastIdentifier)
end)


function startAnim(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 2.0, 2.0, -1, 51, 0.0, false, false, false)
        AddPropToPlayer("prop_cs_tablet", 28422, -0.05, 0.0, 0.0, 0.0, 0.0, 0.0)
    end)
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
      LoadPropDict(prop1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function EmoteCancel()
    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        ClearPedTasks(PlayerPedId())
        ClearPedTasksImmediately(PlayerPedId())
    end
    DestroyAllProps()
end

function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
      DeleteEntity(v)
    end

end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
      RequestModel(GetHashKey(model))
      Wait(10)
    end
 end
  