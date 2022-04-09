local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-clothing:saveSkin")
AddEventHandler('qb-clothing:saveSkin', function(model, skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if model ~= nil and skin ~= nil then
        exports.oxmysql:execute('DELETE FROM playerskins WHERE citizenid=@citizenid', {['@citizenid'] = Player.PlayerData.citizenid}, function()
            exports.oxmysql:execute('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (@citizenid, @model, @skin, @active)', {
                ['@citizenid'] = Player.PlayerData.citizenid,
                ['@model'] = model,
                ['@skin'] = skin,
                ['@active'] = 1
            })
        end)
    end
end)






RegisterServerEvent("qb-clothes:loadPlayerSkin")
AddEventHandler('qb-clothes:loadPlayerSkin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT * FROM playerskins WHERE citizenid=@citizenid AND active=@active', {['@citizenid'] = Player.PlayerData.citizenid, ['@active'] = 1})
    if result[1] ~= nil then
        TriggerClientEvent("qb-clothes:loadSkin", src, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("qb-clothes:loadSkin", src, true)
    end
end)

RegisterServerEvent("qb-clothes:saveOutfit")
AddEventHandler("qb-clothes:saveOutfit", function(outfitName, model, skinData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        exports.oxmysql:execute('INSERT INTO player_outfits (citizenid, outfitname, model, skin, outfitId) VALUES (@citizenid, @outfitname, @model, @skin, @outfitId)', {
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@outfitname'] = outfitName,
            ['@model'] = model,
            ['@skin'] = json.encode(skinData),
            ['@outfitId'] = outfitId
        }, function()
            local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid=@citizenid', {['@citizenid'] = Player.PlayerData.citizenid})
            if result[1] ~= nil then
                TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
            else
                TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
            end
        end)
    end
end)

RegisterServerEvent("qb-clothing:server:removeOutfit")
AddEventHandler("qb-clothing:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('DELETE FROM player_outfits WHERE citizenid=@citizenid AND outfitname=@outfitname AND outfitId=@outfitId', {
        ['@citizenid'] = Player.PlayerData.citizenid,
        ['@outfitname'] = outfitName,
        ['@outfitId'] = outfitId
    }, function()
        local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid=@citizenid', {['@citizenid'] = Player.PlayerData.citizenid})
        if result[1] ~= nil then
            TriggerClientEvent('qb-clothing:client:reloadOutfits', src, result)
        else
            TriggerClientEvent('qb-clothing:client:reloadOutfits', src, nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('qb-clothing:server:getOutfits', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local anusVal = {}

    local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid=@citizenid', {['@citizenid'] = Player.PlayerData.citizenid})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            result[k].skin = json.decode(result[k].skin)
            anusVal[k] = v
        end
        cb(anusVal)
    end
    cb(anusVal)
end)




function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end



RegisterServerEvent('lucid:giveMetadataClothes')
AddEventHandler('lucid:giveMetadataClothes', function(selectedClothes, selectedTextures, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', tonumber(price), 'Buy outfit') then
        for k,v in pairs(selectedClothes) do
            if selectedClothes[k].selected then

                local textureVal = selectedTextures[k].value
                local item_name = 'clothes_'..k
                local info = {
                    type = k,
                    value = selectedClothes[k].value,
                    texture = textureVal,
                    label = v.label or "No Label",
                }

                Player.Functions.AddItem(item_name, 1, nil, info)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src,"You don't have enough money", 'error')
    end
end)


RegisterServerEvent('lucid:giveOutfitBag')
AddEventHandler('lucid:giveOutfitBag', function(selectedClothes, selectedTextures, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local tut = Player.PlayerData.metadata["missions"]["tut"]
    local infos = {};

    if Player.Functions.RemoveMoney('cash', tonumber(price), 'Buy outfit') then

        for k,v in pairs(selectedClothes) do
            if selectedClothes[k].selected then

                local textureVal = selectedTextures[k].value
                local item_name = 'clothes_'..k
                local info = {
                    type = k,
                    value = selectedClothes[k].value,
                    texture = textureVal,
                    label = 'Outfit Bag',
                }

                table.insert(infos, info)

            end
        end

        infos.label = 'Outfit Bag'
        if(next(infos) ~=nil) then
            Player.Functions.AddItem('outfit_bag', 1, nil, infos)
            if tut == 1 then
              TriggerEvent("qbcront-missions:SetProgress", src, 2)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src,"You don't have enough money", 'error')

    end
end)


QBCore.Functions.CreateUseableItem('outfit_bag' , function(source, item )
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.metadata["missions"]["tut"] == 2 then
      TriggerEvent("qbcront-missions:SetProgress", src, 3)
    end

    for k,v in pairs(item.info) do
        TriggerClientEvent('lucid:wearPlayerClothes', source, v)
        Citizen.Wait(1000)
    end

   -- Player.Functions.RemoveItem(item.name, 1)

end)


local avaliableClothes = {
    "t-shirt", "torso2", "vest", "accessory", "bag",
     "pants", "shoes", "hat", "glass", "ear", "watch", "bracelet", "mask"
}


for k, v in pairs(avaliableClothes) do
    QBCore.Functions.CreateUseableItem('clothes_'..v , function(source, item )
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        TriggerClientEvent('lucid:wearPlayerClothes', source, item.info)
     --   Player.Functions.RemoveItem(item.name, 1)
    end)
end
