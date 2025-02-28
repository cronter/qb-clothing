local QBCore = exports['qb-core']:GetCoreObject()
local creatingCharacter = false
local cam = -1
local heading = 332.219879
local zoom = "character"

local customCamLocation = nil

local isLoggedIn = false

local PlayerData = {}
local single_arm_open = false


local skinData = {
	["face"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["face2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,
    },
    ["facemix"] = {
        skinMix = 0,
        shapeMix = 0,
        defaultSkinMix = 0.0,
        defaultShapeMix = 0.0,
    },
    ["pants"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["hair"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["eyebrows"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
    ['eyebrows_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["beard"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
    ['beard_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
	["chest"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
    ['chest_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["blush"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['blush_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
	["sun"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['sun_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
	["blemishes"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['blemishes_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
	["complexion"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['complexion_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["lipstick"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['lipstick_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["makeup"] = {
        item = -1,
        texture = 1,
        defaultItem = -1,
        defaultTexture = 1,        
    },
	['makeup_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["ageing"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,        
    },
	['ageing_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["arms"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["t-shirt"] = {
        item = 1,
        texture = 0,
        defaultItem = 1,
        defaultTexture = 0,        
    },
    ["torso2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["vest"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["bag"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["shoes"] = {
        item = 0,
        texture = 0,
        defaultItem = 1,
        defaultTexture = 0,        
    },
    ["mask"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,        
    },
    ["hat"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0, 
    },
    ["glass"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["ear"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["watch"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["bracelet"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,
    },
    ["accessory"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["decals"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["eye_color"] = {
        item = -1,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,      
    },
    ["moles"] = {
        item = 0,
        texture = 0,
        defaultItem = -1,
        defaultTexture = 0,      
    },
	['moles_opacity'] = {
        item = 100,
        texture = 0,
        defaultItem = 100,
        defaultTexture = 0,   
    },
    ["nose_0"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["nose_1"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["nose_2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["nose_3"] = {
        item = 0,
        texture = 0,
        defaultItem =0,
        defaultTexture = 0,      
    },

    ["nose_4"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["nose_5"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["cheek_1"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["cheek_2"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["cheek_3"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["eye_opening"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["lips_thickness"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["jaw_bone_width"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["eyebrown_high"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["eyebrown_forward"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["jaw_bone_back_lenght"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["chimp_bone_lowering"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["chimp_bone_lenght"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["chimp_bone_width"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["chimp_hole"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
    ["neck_thikness"] = {
        item = 0,
        texture = 0,
        defaultItem = 0,
        defaultTexture = 0,      
    },
} 

local previousSkinData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("qb-clothes:loadPlayerSkin")
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
end)

RegisterCommand('loadskin', function()
    TriggerServerEvent("qb-clothes:loadPlayerSkin")
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
end)


RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)



function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    for k, v in pairs (Config.Stores) do
        if Config.Stores[k].shopType == "clothing" then
            local clothingShop = AddBlipForCoord(Config.Stores[k].coords)
            SetBlipSprite(clothingShop, 366)
            SetBlipColour(clothingShop, 47)
            SetBlipScale  (clothingShop, 0.7)
            SetBlipAsShortRange(clothingShop, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing store")
            EndTextCommandSetBlipName(clothingShop)
        end
        
        if Config.Stores[k].shopType == "barber" then
            local barberShop = AddBlipForCoord(Config.Stores[k].coords)
            SetBlipSprite(barberShop, 71)
            SetBlipColour(barberShop, 0)
            SetBlipScale  (barberShop, 0.7)
            SetBlipAsShortRange(barberShop, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Barber")
            EndTextCommandSetBlipName(barberShop)
        end

        if Config.Stores[k].shopType == "surgeon" then
            local surgeonShop = AddBlipForCoord(Config.Stores[k].coords)
            SetBlipSprite(surgeonShop, 71)
            SetBlipColour(surgeonShop, 0)
            SetBlipScale  (surgeonShop, 0.7)
            SetBlipAsShortRange(surgeonShop, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Surgeon")
            EndTextCommandSetBlipName(surgeonShop)
        end
    end
end)
Citizen.CreateThread(function()
    while true do

        if isLoggedIn then

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            
            local inRange = false

            for k, v in pairs(Config.Stores) do
		local dist = #(pos - Config.Stores[k].coords)


                if dist < 30 then
                    if not creatingCharacter then
                        DrawMarker(2, Config.Stores[k].coords.x,Config.Stores[k].coords.y,Config.Stores[k].coords.z + 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                        if dist < 5 then
                            if Config.Stores[k].shopType == "clothing" then
                                 DrawText3Ds(Config.Stores[k].coords.x, Config.Stores[k].coords.y, Config.Stores[k].coords.z + 1.25, '~g~E~w~ - To Shop For Clothes')
                            elseif Config.Stores[k].shopType == "barber" then
                                DrawText3Ds(Config.Stores[k].coords.x, Config.Stores[k].coords.y, Config.Stores[k].coords.z + 1.25, '~g~E~w~ - To Get A Haircut')
                            elseif Config.Stores[k].shopType == "surgeon" then
                                DrawText3Ds(Config.Stores[k].coords.x, Config.Stores[k].coords.y, Config.Stores[k].coords.z + 1.25, '~g~E~w~ - To Get Plastic Surgery')
                            end
                            if IsControlJustPressed(0, 38) then -- E
                                if Config.Stores[k].shopType == "clothing" then
                                    customCamLocation = nil
                                    openMenu({
                                        {menu = "character", label = "Clothing", selected = true},
                                        {menu = "accessoires", label = "Accessories", selected = false}
                                    })
                                elseif Config.Stores[k].shopType == "barber" then
                                    customCamLocation = nil
                                    openMenu({
                                        {menu = "clothing", label = "Hair", selected = true},
                                    })
                                elseif Config.Stores[k].shopType == "surgeon" then
                                    customCamLocation = nil
                                    openMenu({
                                        {menu = "clothing", label = "Character", selected = true},
                                    })
                                end
                            end
                        end
                    end
                    inRange = true
                end
            end

            if not inRange then
                Citizen.Wait(2000)
            end

        end

        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do

        if isLoggedIn then

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            local inRange = false

            for k, v in pairs(Config.ClothingRooms) do
                local dist = #(pos - Config.ClothingRooms[k].coords)

                if dist < 15 then
                    if not creatingCharacter then
                        DrawMarker(2, Config.ClothingRooms[k].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                        if dist < 2 then
                            if PlayerData.job.name == Config.ClothingRooms[k].requiredJob then
                                DrawText3Ds(Config.ClothingRooms[k].coords.x, Config.ClothingRooms[k].coords.y, Config.ClothingRooms[k].coords.z + 0.3, '~g~E~w~ - View Clothing')
                                if IsControlJustPressed(0, 38) then -- E
                                    customCamLocation = Config.ClothingRooms[k].cameraLocation
                                    gender = "male"
                                    if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then gender = "female" end
                                    QBCore.Functions.TriggerCallback('qb-clothing:server:getOutfits', function(result)
                                        openMenu({
                                            {menu = "roomOutfits", label = "Presets", selected = true, outfits = Config.Outfits[PlayerData.job.name][gender]},
                                            {menu = "myOutfits", label = "My Outfits", selected = false, outfits = result},
                                            {menu = "character", label = "Clothing", selected = false},
                                            {menu = "accessoires", label = "Accessories", selected = false}
                                        })
                                        
                                    end)
                                end
                            end
                        end
                        inRange = true
                    end
                end
            end

            if not inRange then
                Citizen.Wait(2000)
            end

        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('qb-clothing:client:openOutfitMenu')
AddEventHandler('qb-clothing:client:openOutfitMenu', function()
    QBCore.Functions.TriggerCallback('qb-clothing:server:getOutfits', function(result)
        openMenu({
            {menu = "myOutfits", label = "My Outfits", selected = true, outfits = result},
        })
    end)
end)

RegisterNUICallback('selectOutfit', function(data)

    TriggerEvent('qb-clothing:client:loadOutfit', data)
end)

RegisterNUICallback('rotateRight', function()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)

    SetEntityHeading(ped, heading + 30)
end)

RegisterNUICallback('rotateLeft', function()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)

    SetEntityHeading(ped, heading - 30)
end)

firstChar = false

local clothingCategorys = {
    ["arms"]        = {type = "variation",  id = 3},
    ["t-shirt"]     = {type = "variation",  id = 8},
    ["torso2"]      = {type = "variation",  id = 11},
    ["pants"]       = {type = "variation",  id = 4},
    ["vest"]        = {type = "variation",  id = 9},
    ["shoes"]       = {type = "variation",  id = 6},
    ["bag"]         = {type = "variation",  id = 5},
    ["hair"]        = {type = "hair",       id = 2},
    ["eyebrows"]    = {type = "overlay",    id = 2},
	["eyebrows_opacity"]       = {type = "overlay",    id = 1},
	["face"]        = {type = "face",       id = 2},
    ["face2"]       = {type = "face",       id = 2},
    ["facemix"]     = {type = "face",       id = 2},
    ["beard"]       = {type = "overlay",    id = 1},
    ["beard_opacity"]       = {type = "overlay",    id = 1},
	["chest"]       = {type = "overlay",    id = 10},
    ["chest_opacity"]       = {type = "overlay",    id = 10},
	["sun"]       = {type = "overlay",    id = 7},
    ["sun_opacity"]       = {type = "overlay",    id = 7},
	["blemishes"]       = {type = "overlay",    id = 0},
    ["blemishes_opacity"]       = {type = "overlay",    id = 0},
	["complexion"]       = {type = "overlay",    id = 6},
    ["complexion_opacity"]       = {type = "overlay",    id = 6},
    ["blush"]       = {type = "overlay",    id = 5},
    ["blush_opacity"]       = {type = "overlay",    id = 5},
    ["lipstick"]    = {type = "overlay",    id = 8},
    ["lipstick_opacity"]       = {type = "overlay",    id = 8},
    ["makeup"]      = {type = "overlay",    id = 4},
    ["makeup_opacity"]       = {type = "overlay",    id = 4},
    ["ageing"]      = {type = "ageing",     id = 3},
	["ageing_opacity"]       = {type = "overlay",    id = 3},
    ["mask"]        = {type = "mask",       id = 1},
    ["hat"]         = {type = "prop",       id = 0},
    ["glass"]       = {type = "prop",       id = 1},
    ["ear"]         = {type = "prop",       id = 2},
    ["watch"]       = {type = "prop",       id = 6},
    ["bracelet"]    = {type = "prop",       id = 7},
    ["accessory"]   = {type = "variation",  id = 7},
    ["decals"]      = {type = "variation",  id = 10},
    ["eye_color"]   = {type = "eye_color",  id = 1},
    ["moles"]   = {type = "moles",  id = 1},
	["moles_opacity"]       = {type = "overlay",    id = 1},
    ["jaw_bone_width"]   = {type = "cheek",  id = 1},
    ["jaw_bone_back_lenght"]   = {type = "cheek",  id = 1},
    ["lips_thickness"]   = {type = "nose",  id = 1},
    ["nose_0"]   = {type = "nose",  id = 1},
    ["nose_1"]   = {type = "nose",  id = 1},
    ["nose_2"]   = {type = "nose",  id = 2},
    ["nose_3"]   = {type = "nose",  id = 3},
    ["nose_4"]   = {type = "nose",  id = 4},
    ["nose_5"]   = {type = "nose",  id = 5},
    ["cheek_1"]   = {type = "cheek",  id = 1},
    ["cheek_2"]   = {type = "cheek",  id = 2},
    ["cheek_3"]   = {type = "cheek",  id = 3},
    ["eyebrown_high"]   = {type = "nose",  id = 1},
    ["eyebrown_forward"]   = {type = "nose",  id = 2},
    ["eye_opening"]   = {type = "nose",  id = 1},
    ["chimp_bone_lowering"]   = {type = "chin",  id = 1},
    ["chimp_bone_lenght"]   = {type = "chin",  id = 2},
    ["chimp_bone_width"]   = {type = "cheek",  id = 3},
    ["chimp_hole"]   = {type = "cheek",  id = 4},
    ["neck_thikness"]   = {type = "cheek",  id = 5},
}

RegisterNetEvent('qb-clothing:client:openMenu')
AddEventHandler('qb-clothing:client:openMenu', function()
    customCamLocation = nil
    openMenu({
        {menu = "character", label = "Clothing", selected = true},
        {menu = "clothing", label = "Character", selected = false},
        {menu = "accessoires", label = "Accessories", selected = false}
    })
end)

function GetMaxValues()
    maxModelValues = {
        ["arms"]        = {type = "character", item = 0, texture = 0},
        ["eye_color"]   = {type = "hair", item = 0, texture = 0},
        ["t-shirt"]     = {type = "character", item = 0, texture = 0},
        ["torso2"]      = {type = "character", item = 0, texture = 0},
        ["pants"]       = {type = "character", item = 0, texture = 0},
        ["shoes"]       = {type = "character", item = 0, texture = 0},
		["face"]        = {type = "hair", item = 0, texture = 0},
        ["face2"]       = {type = "hair", item = 0, texture = 0},
        ["facemix"]     = {type = "hair", shapeMix = 0, skinMix = 0},
        ["vest"]        = {type = "character", item = 0, texture = 0},
        ["accessory"]   = {type = "character", item = 0, texture = 0},
        ["decals"]      = {type = "character", item = 0, texture = 0},
        ["bag"]         = {type = "character", item = 0, texture = 0},
        ["moles"]       = {type = "hair", item = 0, texture = 0},
		["moles_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["hair"]        = {type = "hair", item = 0, texture = 0},
        ["eyebrows"]    = {type = "hair", item = 0, texture = 0},
		["eyebrows_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["beard"]       = {type = "hair", item = 0, texture = 0},
        ["beard_opacity"]       = {type = "hair", item = 100, texture = 0},
		["chest"]       = {type = "hair", item = 0, texture = 0},
        ["chest_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["eye_opening"]   = {type = "hair",  id = 1},
        ["jaw_bone_width"]       = {type = "hair", item = 0, texture = 0},
        ["jaw_bone_back_lenght"]       = {type = "hair", item = 0, texture = 0},
        ["lips_thickness"]       = {type = "hair", item = 0, texture = 0},
        ["cheek_1"]       = {type = "hair", item = 0, texture = 0},
        ["cheek_2"]       = {type = "hair", item = 0, texture = 0},
        ["cheek_3"]       = {type = "hair", item = 0, texture = 0},
        ["eyebrown_high"]       = {type = "hair", item = 0, texture = 0},
        ["eyebrown_forward"]       = {type = "hair", item = 0, texture = 0},
        ["nose_0"]       = {type = "hair", item = 0, texture = 0},
        ["nose_1"]       = {type = "hair", item = 0, texture = 0},
        ["nose_2"]       = {type = "hair", item = 0, texture = 0},
        ["nose_3"]       = {type = "hair", item = 0, texture = 0},
        ["nose_4"]       = {type = "hair", item = 0, texture = 0},
        ["nose_5"]       = {type = "hair", item = 0, texture = 0},
        ["chimp_bone_lowering"]       = {type = "hair", item = 0, texture = 0},
        ["chimp_bone_lenght"]       = {type = "hair", item = 0, texture = 0},
        ["chimp_bone_width"]       = {type = "hair", item = 0, texture = 0},
        ["chimp_hole"]       = {type = "hair", item = 0, texture = 0},
        ["neck_thikness"]       = {type = "hair", item = 0, texture = 0},
		["sun"]       = {type = "hair", item = 0, texture = 0},
		["sun_opacity"]       = {type = "hair", item = 100, texture = 0},
		["blemishes"]       = {type = "hair", item = 0, texture = 0},
		["blemishes_opacity"]       = {type = "hair", item = 100, texture = 0},
		["complexion"]       = {type = "hair", item = 0, texture = 0},
		["complexion_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["blush"]       = {type = "hair", item = 0, texture = 0},
		["blush_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["lipstick"]    = {type = "hair", item = 0, texture = 0},
		["lipstick_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["makeup"]      = {type = "hair", item = 0, texture = 0},
		["makeup_opacity"]       = {type = "hair", item = 100, texture = 0},
        ["ageing"]      = {type = "hair", item = 0, texture = 0},
		["ageing_opacity"]      = {type = "hair", item = 0, texture = 0},
        ["mask"]        = {type = "accessoires", item = 0, texture = 0},
        ["hat"]         = {type = "accessoires", item = 0, texture = 0},
        ["glass"]       = {type = "accessoires", item = 0, texture = 0},
        ["ear"]         = {type = "accessoires", item = 0, texture = 0},
        ["watch"]       = {type = "accessoires", item = 0, texture = 0},
        ["bracelet"]    = {type = "accessoires", item = 0, texture = 0},
 
    }

    if(single_arm_open) then
        if(maxModelValues['arms'].type == 'character') then
            maxModelValues['arms'].type = 'singleArm';
        end 
    end
    local ped = PlayerPedId()
    
    for key, v in pairs(clothingCategorys) do
        if v.type == "variation" then
            maxModelValues[key].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[key].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id)) -1
        end

        if v.type == "hair" then
   
            maxModelValues[key].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[key].texture = 45
        end

        if v.type == "mask" then
            maxModelValues[key].item = GetNumberOfPedDrawableVariations(ped, v.id)
            maxModelValues[key].texture = GetNumberOfPedTextureVariations(ped, v.id, GetPedDrawableVariation(ped, v.id))
        end

        if v.type == "face" then
            maxModelValues[key].item = 45
            maxModelValues[key].texture = 15
        end
		
		if v.type == "face2" then
            maxModelValues[key].item = 45
            maxModelValues[key].texture = 15
        end
		
        if v.type == "facemix" then
            maxModelValues[key].shapeMix = 10
            maxModelValues[key].skinMix = 10
        end

        if v.type == "ageing" then
            maxModelValues[key].item = GetNumHeadOverlayValues(v.id)
            maxModelValues[key].texture = 0
        end

        if v.type == "overlay" then
            maxModelValues[key].item = GetNumHeadOverlayValues(v.id)
            maxModelValues[key].texture = 45
        end

        if v.type == "prop" then
            maxModelValues[key].item = GetNumberOfPedPropDrawableVariations(ped, v.id)
            maxModelValues[key].texture = GetNumberOfPedPropTextureVariations(ped, v.id, GetPedPropIndex(ped, v.id))
        end

        if v.type == "eye_color" then
            maxModelValues[key].item = 31
            maxModelValues[key].texture = 0
        end

        if v.type == "moles" then
            maxModelValues[key].item = GetNumHeadOverlayValues(9) -1
            maxModelValues[key].texture = 10
        end

        if v.type == "nose" then
            maxModelValues[key].item = 30
            maxModelValues[key].texture = 0
        end

        if v.type == "cheek" then
            maxModelValues[key].item = 30
            maxModelValues[key].texture = 0
        end

        if v.type == "chin" then
            maxModelValues[key].item = 30
            maxModelValues[key].texture = 0
        end

    end

    SendNUIMessage({
        action = "updateMax",
        maxValues = maxModelValues
    })
end

function openMenu(allowedMenus)
    previousSkinData = json.encode(skinData)
    creatingCharacter = true

    local PlayerData = QBCore.Functions.GetPlayerData()
    local trackerMeta = PlayerData.metadata["tracker"]

    GetMaxValues()
    SendNUIMessage({
        action = "open",
        menus = allowedMenus,
        currentClothing = skinData,
        hasTracker = trackerMeta,
        defaultPrice = Config.DefaultPrice,
        clothesPrices = Config.Prices,

    })
    SetNuiFocus(true, true)
    SetCursorLocation(0.9, 0.25)

    FreezeEntityPosition(PlayerPedId(), true)

    enableCam()
end

RegisterNUICallback('TrackerError', function()
    QBCore.Functions.Notify("You can't remove your ankle bracelet ..", "error")
end)

RegisterNUICallback('saveOutfit', function(data, cb)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    TriggerServerEvent('qb-clothes:saveOutfit', data.outfitName, model, skinData)
end)

RegisterNetEvent('qb-clothing:client:reloadOutfits')
AddEventHandler('qb-clothing:client:reloadOutfits', function(myOutfits)
    SendNUIMessage({
        action = "reloadMyOutfits",
        outfits = myOutfits
    })
end)

function enableCam()
    -- Camera
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if(not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end
    
    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
    end
end

RegisterNUICallback('rotateCam', function(data)
    local rotType = data.type
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 2.0, 0)

    if rotType == "left" then
        SetEntityHeading(ped, GetEntityHeading(ped) - 10)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)
    else
        SetEntityHeading(ped, GetEntityHeading(ped) + 10)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(ped) + 180)
    end
end)

RegisterNUICallback('setupCam', function(data)
    local value = data.value

    if value == 1 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.75, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.65)
    elseif value == 2 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
    elseif value == 3 then
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + -0.5)
    else
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
    end
end)

function disableCam()
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)
end

function closeMenu()
    single_arm_open = false
    SendNUIMessage({
        action = "close",
    })
    disableCam()
end

RegisterNUICallback('resetOutfit', function()
    resetClothing(json.decode(previousSkinData))
    skinData = json.decode(previousSkinData)
    previousSkinData = {}
end)


function PlayToggleEmote(e)
	local Ped = PlayerPedId()
	while not HasAnimDictLoaded(e.Dict) do RequestAnimDict(e.Dict) Wait(100) end
	if IsPedInAnyVehicle(Ped) then e.Move = 51 end
	TaskPlayAnim(Ped, e.Dict, e.Anim, 3.0, 3.0, e.Dur, e.Move, 0, false, false, false)
	local Pause = e.Dur-500 if Pause < 500 then Pause = 500 end
end



function resetClothes(data)
    local ped = PlayerPedId()
	
    
        -- Pants
    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)
    
    -- T-Shirt
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)
    -- Vest
    SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)
    -- Torso 2
    SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
    SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)
    -- Shoes
    SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)
    -- Mask
    SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)
    -- Accessory
    SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
    -- Bag
    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)

    
    -- Hat
    if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
        SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
    else
        ClearPedProp(ped, 0)
    end
    -- Glass
    if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
        SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
    else
        ClearPedProp(ped, 1)
    end
    -- Ear
    if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
        SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
    else
        ClearPedProp(ped, 2)
    end
    -- Watch
    if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
        SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
    else
        ClearPedProp(ped, 6)
    end
    -- Bracelet
    if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
        SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
    else
        ClearPedProp(ped, 7)
    end

end

function resetClothing(data)
    local ped = PlayerPedId()

   -- Face
    SetPedHeadBlendData(ped, data["face"].item, data["face2"].item, 0, data["face"].texture, data["face2"].texture, 0, data["facemix"].shapeMix, data["facemix"].skinMix, 0, false)
	
    -- Pants
    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)

    -- Hair
    SetPedComponentVariation(ped, 2, data["hair"].item, 0, 0)
    SetPedHairColor(ped, data["hair"].texture, data["hair"].texture)

    -- Eyebrows
    SetPedHeadOverlay(ped, 2, data["eyebrows"].item, data["eyebrows_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows"].texture, 0)

    -- Beard
    SetPedHeadOverlay(ped, 1, data["beard"].item, data["beard_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 1, 1, data["beard"].texture, 0)

    -- Blush
    SetPedHeadOverlay(ped, 5, data["blush"].item, data["blush_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 5, 1, data["blush"].texture, 0)
	
	-- Blemishes
    SetPedHeadOverlay(ped, 0, data["blemishes"].item, data["blemishes_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 0, 1, data["blemishes"].texture, 0)

	-- Complexion
    SetPedHeadOverlay(ped, 6, data["complexion"].item, data["complexion_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 6, 1, data["complexion"].texture, 0)

	-- Sun Damage
    SetPedHeadOverlay(ped, 7, data["sun"].item, data["sun_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 7, 1, data["sun"].texture, 0)

	-- Chest Hair
    SetPedHeadOverlay(ped, 10, data["chest"].item, data["chest_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 10, 1, data["chest"].texture, 0)

    -- Lipstick
    SetPedHeadOverlay(ped, 8, data["lipstick"].item,  data["lipstick_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 8, 1, data["lipstick"].item, 0)

    -- Makeup
	
	SetPedHeadOverlay(ped, 4, data["makeup"].item, data["makeup_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 4, 1, data["makeup"].texture, 0)

    -- Ageing
	SetPedHeadOverlay(ped, 3, data["ageing"].item, data["ageing_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 3, 1, data["ageing"].texture, 0)

    -- Arms
    SetPedComponentVariation(ped, 3, data["arms"].item, 0, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)

    -- T-Shirt
     SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
     SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)

     -- Vest
     SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
     SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)

     -- Torso 2
     SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
     SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)

     -- Shoes
     SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
     SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)

     -- Mask
     SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
     SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)

    -- Badge
    SetPedComponentVariation(ped, 10, data["decals"].item, 0, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)

    -- Accessory
    SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
    SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)

    -- Bag
    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)

    SetPedEyeColor(ped, data['eye_color'].item)

    SetPedHeadOverlay(ped, 9, data["moles"].item, data["moles_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 9, 1, data["moles"].texture, 0)

    SetPedFaceFeature(ped, 0, (data['nose_0'].item / 10))
    SetPedFaceFeature(ped, 1, (data['nose_1'].item / 10))
    SetPedFaceFeature(ped, 2, (data['nose_2'].item / 10))
    SetPedFaceFeature(ped, 3, (data['nose_3'].item / 10))
    SetPedFaceFeature(ped, 4, (data['nose_4'].item / 10))
    SetPedFaceFeature(ped, 5, (data['nose_5'].item / 10))
    SetPedFaceFeature(ped, 6, (data['eyebrown_high'].item / 10))
    SetPedFaceFeature(ped, 7, (data['eyebrown_forward'].item / 10))
    SetPedFaceFeature(ped, 8, (data['cheek_1'].item / 10))
    SetPedFaceFeature(ped, 9, (data['cheek_2'].item / 10))
    SetPedFaceFeature(ped, 10,(data['cheek_3'].item / 10))
    SetPedFaceFeature(ped, 11, (data['eye_opening'].item / 10))
    SetPedFaceFeature(ped, 12, (data['lips_thickness'].item / 10))
    SetPedFaceFeature(ped, 13, (data['jaw_bone_width'].item / 10))
    SetPedFaceFeature(ped, 14, (data['jaw_bone_back_lenght'].item / 10))
    SetPedFaceFeature(ped, 15, (data['chimp_bone_lowering'].item / 10))
    SetPedFaceFeature(ped, 16, (data['chimp_bone_lenght'].item / 10))
    SetPedFaceFeature(ped, 17, (data['chimp_bone_width'].item / 10))
    SetPedFaceFeature(ped, 18, (data['chimp_hole'].item / 10))
    SetPedFaceFeature(ped, 19, (data['neck_thikness'].item / 10))

    -- Hat
     if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
         SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
     else
         ClearPedProp(ped, 0)
     end    
     -- Glass
     if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
         SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
     else
         ClearPedProp(ped, 1)
     end    
     -- Ear
     if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
         SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
     else
         ClearPedProp(ped, 2)
     end    
     -- Watch
     if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
         SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
     else
         ClearPedProp(ped, 6)
     end    
     -- Bracelet
     if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
         SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
     else
         ClearPedProp(ped, 7)
     end
end

RegisterNUICallback('close', function()
    single_arm_open = false
    SetNuiFocus(false, false)
    creatingCharacter = false
    disableCam()
    
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNUICallback('getCatergoryItems', function(data, cb)
    cb(Config.Menus[data.category])
end)

RegisterNUICallback('updateSkin', function(data)
    ChangeVariation(data)
end)

RegisterNUICallback('updateSkinOnInput', function(data)

    ChangeVariation(data)
end)

RegisterNUICallback('removeOutfit', function(data, cb)
    TriggerServerEvent('qb-clothing:server:removeOutfit', data.outfitName, data.outfitId)
    QBCore.Functions.Notify("You have deleted your"..data.outfitName.." outfit!")
end)

function ChangeVariation(data)
    local ped = PlayerPedId()
    local clothingCategory = data.clothingType
    local type = data.type
    local item = data.articleNumber

    if clothingCategory == "pants" then
        if type == "item" then
            SetPedComponentVariation(ped, 4, item, 0, 0)
            --skinData["pants"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 4)
            SetPedComponentVariation(ped, 4, curItem, item, 0)
            --skinData["pants"].texture = item
        end
	elseif clothingCategory == "face" then
        if type == "item" then
            SetPedHeadBlendData(ped, tonumber(item), skinData["face2"].item, nil, skinData["face"].texture, skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face"].item = item
        elseif type == "texture" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, item, skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix, nil, true)
            skinData["face"].texture = item
        end
    elseif clothingCategory == "face2" then
        if type == "item" then
            SetPedHeadBlendData(ped, skinData["face"].item, tonumber(item), nil, skinData["face"].texture, skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix , nil, true)
            skinData["face2"].item = item
        elseif type == "texture" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture, item, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix , nil, true)
            skinData["face2"].texture = item
        end
    elseif clothingCategory == "facemix" then
        if type == "skinMix" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture, skinData["face2"].texture, nil, skinData["facemix"].shapeMix, item, nil, true)
            skinData["facemix"].skinMix = item
        elseif type == "shapeMix" then
            SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture, skinData["face2"].texture, nil, item, skinData["facemix"].skinMix , nil, true)
            skinData["facemix"].shapeMix = item
        end
	elseif clothingCategory == "hair" then
        SetPedHeadBlendData(ped, skinData["face"].item, skinData["face2"].item, nil, skinData["face"].texture, skinData["face2"].texture, nil, skinData["facemix"].shapeMix, skinData["facemix"].skinMix , nil, true)
        if type == "item" then
            SetPedComponentVariation(ped, 2, item, 0, 0)
            skinData["hair"].item = item
        elseif type == "texture" then
            SetPedHairColor(ped, item, item)
            skinData["hair"].texture = item
        end
    elseif clothingCategory == "eyebrows" then
        if type == "item" then
            SetPedHeadOverlay(ped, 2, item, skinData["eyebrows_opacity"].item / 100 + 0.0)
            skinData["eyebrows"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 2, 1, item, 0)
            skinData["eyebrows"].texture = item
        end
	elseif clothingCategory == "eyebrows_opacity" then
        if type == "item" then
            skinData["eyebrows_opacity"].item = item
            SetPedHeadOverlay(ped, 2,  skinData["eyebrows"].item, skinData["eyebrows_opacity"].item / 100 + 0.0)
        end
    elseif clothingCategory == "beard" then
        if type == "item" then
            SetPedHeadOverlay(ped, 1, item, skinData["beard_opacity"].item / 100 + 0.0)
            skinData["beard"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 1, 1, item, 0)
            skinData["beard"].texture = item
        end
    elseif clothingCategory == "beard_opacity" then
        if type == "item" then
            skinData["beard_opacity"].item = item
            SetPedHeadOverlay(ped, 1, skinData["beard"].item, skinData["beard_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 1, 1, item, 0)
            skinData["beard"].texture = item
        end
	elseif clothingCategory == "chest" then
        if type == "item" then
            SetPedHeadOverlay(ped, 10, item, skinData["chest_opacity"].item / 100 + 0.0)
            skinData["chest"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 10, 1, item, 0)
            skinData["chest"].texture = item
        end
    elseif clothingCategory == "chest_opacity" then
        if type == "item" then
            skinData["chest_opacity"].item = item
            SetPedHeadOverlay(ped, 10, skinData["chest"].item, skinData["chest_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 10, 1, item, 0)
            skinData["chest"].texture = item
        end
	elseif clothingCategory == "sun" then
        if type == "item" then
            skinData["sun"].item = item
            SetPedHeadOverlay(ped, 7, item, skinData["sun_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 7, 1, item, 0)
            skinData["sun"].texture = item
        end
	elseif clothingCategory == "sun_opacity" then
        if type == "item" then
            skinData["sun_opacity"].item = item
            SetPedHeadOverlay(ped, 7,  skinData["sun"].item, skinData["sun_opacity"].item / 100 + 0.0)
        end
	elseif clothingCategory == "blemishes" then
        if type == "item" then
            skinData["blemishes"].item = item
            SetPedHeadOverlay(ped, 0, item, skinData["blemishes_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 0, 1, item, 0)
            skinData["blemishes"].texture = item
        end
	elseif clothingCategory == "blemishes_opacity" then
        if type == "item" then
            skinData["blemishes_opacity"].item = item
            SetPedHeadOverlay(ped, 0,  skinData["blemishes"].item, skinData["blemishes_opacity"].item / 100 + 0.0)
        end
	elseif clothingCategory == "complexion" then
        if type == "item" then
            skinData["complexion"].item = item
            SetPedHeadOverlay(ped, 6, item, skinData["complexion_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 6, 1, item, 0)
            skinData["complexion"].texture = item
        end
	elseif clothingCategory == "complexion_opacity" then
        if type == "item" then
            skinData["complexion_opacity"].item = item
            SetPedHeadOverlay(ped, 6,  skinData["complexion"].item, skinData["complexion_opacity"].item / 100 + 0.0)
        end
    elseif clothingCategory == "blush" then
        if type == "item" then
            skinData["blush"].item = item
            SetPedHeadOverlay(ped, 5, item, skinData["blush_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 5, 1, item, 0)
            skinData["blush"].texture = item
        end
	elseif clothingCategory == "blush_opacity" then
        if type == "item" then
            skinData["blush_opacity"].item = item
            SetPedHeadOverlay(ped, 5,  skinData["blush"].item, skinData["blush_opacity"].item / 100 + 0.0)
        end
    elseif clothingCategory == "lipstick" then
        if type == "item" then
            SetPedHeadOverlay(ped, 8, item, skinData["lipstick_opacity"].item / 100 + 0.0)
            skinData["lipstick"].item = item
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 8, 1, item, 0)
            skinData["lipstick"].texture = item
        end
	elseif clothingCategory == "lipstick_opacity" then
        if type == "item" then
            skinData["lipstick_opacity"].item = item
            SetPedHeadOverlay(ped, 8,  skinData["lipstick"].item, skinData["lipstick_opacity"].item / 100 + 0.0)
        end
	 elseif clothingCategory == "makeup" then
        if type == "item" then
            skinData["makeup"].item = item
            SetPedHeadOverlay(ped, 4, item, skinData["makeup_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 4, 1, item, 0)
            skinData["makeup"].texture = item
        end
	elseif clothingCategory == "makeup_opacity" then
        if type == "item" then
            skinData["makeup_opacity"].item = item
            SetPedHeadOverlay(ped, 4,  skinData["makeup"].item, skinData["makeup_opacity"].item / 100 + 0.0)
        end
	elseif clothingCategory == "ageing" then
        if type == "item" then
            skinData["ageing"].item = item
            SetPedHeadOverlay(ped, 3, item, skinData["ageing_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 5, 1, item, 0)
            skinData["ageing"].texture = item
        end
	elseif clothingCategory == "ageing_opacity" then
        if type == "item" then
            skinData["ageing_opacity"].item = item
            SetPedHeadOverlay(ped, 3,  skinData["ageing"].item, skinData["ageing_opacity"].item / 100 + 0.0)
        end

    elseif clothingCategory == "arms" then
        if type == "item" then
            SetPedComponentVariation(ped, 3, item, 0, 2)
            skinData["arms"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 3)
            SetPedComponentVariation(ped, 3, curItem, item, 0)
            skinData["arms"].texture = item
        end
     elseif clothingCategory == "eye_color" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            SetPedEyeColor(ped, item)
            skinData["eye_color"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            -- SetPedEyeColor(ped, item)
            -- skinData["eye_color"].texture = item
        end
	elseif clothingCategory == "moles" then
        if type == "item" then
            skinData["moles"].item = item
            SetPedHeadOverlay(ped, 9, item, skinData["moles_opacity"].item / 100 + 0.0)
        elseif type == "texture" then
            SetPedHeadOverlayColor(ped, 5, 1, item, 0)
            skinData["moles"].texture = item
        end
	elseif clothingCategory == "moles_opacity" then
        if type == "item" then
            skinData["moles_opacity"].item = item
            SetPedHeadOverlay(ped, 9,  skinData["moles"].item, skinData["moles_opacity"].item / 100 + 0.0)
        end
		
    elseif clothingCategory == "nose_0" then
        if type == "item" then
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 0, newitem)
            skinData["nose_0"].item = item
        elseif type == "texture" then
            
        end
        
    elseif clothingCategory == "nose_1" then
        if type == "item" then
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 1, newitem)
            skinData["nose_1"].item = item
        elseif type == "texture" then
            
        end
    elseif clothingCategory == "nose_2" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 2, newitem)
            skinData["nose_2"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "nose_3" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 3, newitem)
            skinData["nose_3"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "nose_4" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 4, newitem)
            skinData["nose_4"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "nose_5" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 5, newitem)
            skinData["nose_5"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
           
        end
    elseif clothingCategory == "eyebrown_high" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 6, newitem)
            skinData["eyebrown_high"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
           
        end
    elseif clothingCategory == "eyebrown_forward" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 7, newitem)
            skinData["eyebrown_forward"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "cheek_1" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 8, newitem)
            skinData["cheek_1"].item = item
        elseif type == "texture" then

            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "cheek_2" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 9, newitem)
            skinData["cheek_1"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "cheek_3" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 10, newitem)
            skinData["cheek_3"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "eye_opening" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 11, newitem)
            skinData["eye_opening"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "lips_thickness" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 12, newitem)
            skinData["lips_thickness"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "jaw_bone_width" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 13, newitem)
            skinData["jaw_bone_width"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "jaw_bone_back_lenght" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 14, newitem)
            skinData["jaw_bone_back_lenght"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "chimp_bone_lowering" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 15, newitem)
            skinData["chimp_bone_lowering"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "chimp_bone_lenght" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 16, newitem)
            skinData["chimp_bone_lenght"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "chimp_bone_width" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 17, newitem)
            skinData["chimp_bone_width"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "chimp_hole" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item
            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 18, newitem)
            skinData["chimp_hole"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "neck_thikness" then
        if type == "item" then
            -- SetPedEyeColor(ped, 12, item, 0, 2)
            -- skinData["arms"].item = item


            local newitem = (item / 10)
            -- print(newitem)
            SetPedFaceFeature(ped, 19, newitem)
            skinData["neck_thikness"].item = item
        elseif type == "texture" then
            -- local curItem = GetPedDrawableVariation(ped, 1)
            
        end
    elseif clothingCategory == "t-shirt" then
        if type == "item" then
            SetPedComponentVariation(ped, 8, item, 0, 2)
            --skinData["t-shirt"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 8)
            SetPedComponentVariation(ped, 8, curItem, item, 0)
            --skinData["t-shirt"].texture = item
        end
    elseif clothingCategory == "vest" then
        if type == "item" then

            SetPedComponentVariation(ped, 9, tonumber(item), 0, 2)
            --skinData["vest"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 9)
            SetPedComponentVariation(ped, 9, curItem, item, 0)
            --skinData["vest"].texture = item
        end
    elseif clothingCategory == "bag" then
        if type == "item" then
            SetPedComponentVariation(ped, 5, item, 0, 2)
           -- skinData["bag"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 5)

            SetPedComponentVariation(ped, 5, curItem, item, 0)
           -- skinData["bag"].texture = item
        end
    elseif clothingCategory == "decals" then
        if type == "item" then
            SetPedComponentVariation(ped, 10, item, 0, 2)
            skinData["decals"].item = item
        elseif type == "texture" then
            SetPedComponentVariation(ped, 10, skinData["decals"].item, item, 0)
            skinData["decals"].texture = item
        end
    elseif clothingCategory == "accessory" then
        if type == "item" then
            SetPedComponentVariation(ped, 7, item, 0, 2)
           -- skinData["accessory"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 7)


            SetPedComponentVariation(ped, 7, curItem, item, 0)
          --  skinData["accessory"].texture = item
        end
    elseif clothingCategory == "torso2" then
        if type == "item" then
            SetPedComponentVariation(ped, 11, item, 0, 2)
          --  skinData["torso2"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 11)
            SetPedComponentVariation(ped, 11, curItem, item, 0)
          --  skinData["torso2"].texture = item
        end
    elseif clothingCategory == "shoes" then
        if type == "item" then
            SetPedComponentVariation(ped, 6, item, 0, 2)
          --  skinData["shoes"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 6)
            SetPedComponentVariation(ped, 6, curItem, item, 0)
          --  skinData["shoes"].texture = item
        end
    elseif clothingCategory == "mask" then
        if type == "item" then
            SetPedComponentVariation(ped, 1, item, 0, 2)
           -- skinData["mask"].item = item
        elseif type == "texture" then
            local curItem = GetPedDrawableVariation(ped, 1)
            SetPedComponentVariation(ped, 1, curItem, item, 0)
          --  skinData["mask"].texture = item
        end
    elseif clothingCategory == "hat" then
        if type == "item" then
      
            if item ~= -1 then
                SetPedPropIndex(ped, 0, item, skinData["hat"].texture, true)
            else
                ClearPedProp(ped, 0)
            end
           -- skinData["hat"].item = item
        elseif type == "texture" then
            local current = GetPedPropIndex(ped, 0)
            SetPedPropIndex(ped, 0, current, tonumber(item), true)
         --   skinData["hat"].texture = item
        end
    elseif clothingCategory == "glass" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 1, item, skinData["glass"].texture, true)
            --    skinData["glass"].item = item
            else
                ClearPedProp(ped, 1)
            end
        elseif type == "texture" then
            local current = GetPedPropIndex(ped, 1)
            SetPedPropIndex(ped, 1, current, item, true)
           -- skinData["glass"].texture = item
        end
    elseif clothingCategory == "ear" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 2, item, skinData["ear"].texture, true)
            else
                ClearPedProp(ped, 2)
            end
           -- skinData["ear"].item = item
        elseif type == "texture" then
            local current = GetPedPropIndex(ped, 2)


            SetPedPropIndex(ped, 2, current, item, true)
           -- skinData["ear"].texture = item
        end
    elseif clothingCategory == "watch" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 6, item, skinData["watch"].texture, true)
            else
                ClearPedProp(ped, 6)
            end
           -- skinData["watch"].item = item
        elseif type == "texture" then
            local current = GetPedPropIndex(ped, 6)


            SetPedPropIndex(ped, 6, current, item, true)
            --skinData["watch"].texture = item
        end
    elseif clothingCategory == "bracelet" then
        if type == "item" then
            if item ~= -1 then
                SetPedPropIndex(ped, 7, item, skinData["bracelet"].texture, true)
            else
                ClearPedProp(ped, 7)
            end
           -- skinData["bracelet"].item = item
        elseif type == "texture" then
            local current = GetPedPropIndex(ped, 7)
            SetPedPropIndex(ped, 7, current, item, true)
           -- skinData["bracelet"].texture = item
        end
    end

    GetMaxValues()
end

function tprint (tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
	  toprint = toprint .. string.rep(" ", indent)
	  if (type(k) == "number") then
		toprint = toprint .. "[" .. k .. "] = "
	  elseif (type(k) == "string") then
		toprint = toprint  .. k ..  "= "   
	  end
	  if (type(v) == "number") then
		toprint = toprint .. v .. ",\r\n"
	  elseif (type(v) == "string") then
		toprint = toprint .. "\"" .. v .. "\",\r\n"
	  elseif (type(v) == "table") then
		toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
	  else
		toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
	  end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
  end


function LoadPlayerModel(skin)
    RequestModel(skin)
    while not HasModelLoaded(skin) do
        Citizen.Wait(0)
    end
end

local blockedPeds = {
    "mp_m_freemode_01",
    "mp_f_freemode_01",
    "tony",
    "g_m_m_chigoon_02_m",
    "u_m_m_jesus_01",
    "a_m_y_stbla_m",
    "ig_terry_m",
    "a_m_m_ktown_m",
    "a_m_y_skater_m",
    "u_m_y_coop",
    "ig_car3guy1_m",
}

function isPedAllowedRandom(skin)
    local retval = false
    for k, v in pairs(blockedPeds) do
        if v ~= skin then
            retval = true
        end
    end
    return retval
end

function ChangeToSkinNoUpdate(skin)
    local ped = PlayerPedId()
    local model = GetHashKey(skin)
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)

        for k, v in pairs(skinData) do
            if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" then
                ChangeVariation({
                    clothingType = k,
                    articleNumber = v.defaultItem,
                    type = "item",
                })
            else
                 if k ~= "face" and k ~= "hair" and k ~= "face2" then
                    ChangeVariation({
                        clothingType = k,
                        articleNumber = v.defaultItem,
                        type = "item",
                    })
                end
            end
            
            if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" then
                ChangeVariation({
                    clothingType = k,
                    articleNumber = v.defaultTexture,
                    type = "texture",
                })
            else
                if k ~= "face" and k ~= "hair" and k ~= "face2" then
                    ChangeVariation({
                        clothingType = k,
                        articleNumber = v.defaultTexture,
                        type = "texture",
                    })
                end
            end
        end
    end)

    -- SetEntityInvincible(ped, true)
    -- if IsModelInCdimage(model) and IsModelValid(model) then
    --     LoadPlayerModel(model)
    --     SetPlayerModel(PlayerId(), model)

    --     for k, v in pairs(skinData) do
    --         skinData[k].item = skinData[k].defaultItem
    --         skinData[k].texture = skinData[k].defaultTexture
    --     end

    --     if isPedAllowedRandom() then
    --         SetPedRandomComponentVariation(ped, true)
    --     end
        
    --     SendNUIMessage({action = "toggleChange", allow = true})
	-- 	SetModelAsNoLongerNeeded(model)
	-- end
	-- SetEntityInvincible(ped, false)
    -- GetMaxValues()
end

RegisterNUICallback('setCurrentPed', function(data, cb)
    local playerData = QBCore.Functions.GetPlayerData()

    if playerData.charinfo.gender == 0 then
        cb(Config.ManPlayerModels[data.ped])
        ChangeToSkinNoUpdate(Config.ManPlayerModels[data.ped])
    else
        cb(Config.WomanPlayerModels[data.ped])
        ChangeToSkinNoUpdate(Config.WomanPlayerModels[data.ped])
    end
end)





RegisterNUICallback('saveClothing', function(data)

    SaveSkin()


    for l,value in pairs(data.selectedClothes) do

        if value.selected then

            if(data.selectedTextures[l].value)then
                local id = 0
                if(l == "t-shirt") then
                    id = 8
                elseif(l == "torso2") then
                    id = 11
                elseif(l == 'vest') then
                    id = 9
                elseif(l == 'accessory') then
                    id = 7
                elseif(l== 'bag') then
                    id = 5
                elseif(l== 'shoes') then
                    id = 6
                elseif(l=='pants') then
                    id = 4
                elseif(l=='hat') then
                    id = 0
                elseif(l=='glass') then
                    id = 1
                elseif(l=='ear') then
                    id = 2
                elseif(l == 'watch')then
                    id = 6
                elseif(l == 'bracelet') then
                     id = 7
                end 
                local hash = nil;
                local component, drawable, texture, gxt;
                
                if(l == 'watch' or l == 'bracelet' or l == 'ear' or l == 'glass' or l == 'hat') then
                    hash = GetHashNameForProp(PlayerPedId(), id, value.value, data.selectedTextures[l].value)
                    component, drawable, texture, gxt = GetPropDataFromHash(hash)
                else                    
                    hash = GetHashNameForComponent(PlayerPedId(), id, tonumber(value.value), tonumber(data.selectedTextures[l].value)) 
                    component, drawable, texture, gxt = GetComponentDataFromHash(hash)
                end
                
                if(gxt ~= '') then
                    if (gxt ~= nil) then

                        local label = GetLabelText(gxt)
                   

                        value.label = label;
                    end
                end
            end
        end
    end
    if(not data.packaged)  then
        TriggerServerEvent("lucid:giveMetadataClothes", data.selectedClothes, data.selectedTextures, data.totalPrice)
    else
        TriggerServerEvent("lucid:giveOutfitBag", data.selectedClothes, data.selectedTextures, data.totalPrice)
    end

    
    resetClothes(json.decode(previousSkinData))
end)







function SaveSkin()
	local model = GetEntityModel(PlayerPedId())
    clothing = json.encode(skinData)
	TriggerServerEvent("qb-clothing:saveSkin", model, clothing)
end


RegisterCommand('arms', function()
        single_arm_open = true
        openMenu({
            {menu = "singleArm", label = "Arms", selected = true},
        })
end)
RegisterCommand('character', function()
    openMenu({
        {menu = "character", label = "Clothing", selected = true},
        {menu = "clothing", label = "Character", selected = false},
        {menu = "accessoires", label = "Accessories", selected = false}
    })
end)

RegisterNetEvent('qb-clothes:client:CreateFirstCharacter')
AddEventHandler('qb-clothes:client:CreateFirstCharacter', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        local skin = "mp_m_freemode_01"
        openMenu({
            {menu = "character", label = "Clothing", selected = true},
            {menu = "clothing", label = "Character", selected = false},
            {menu = "accessoires", label = "Accessories", selected = false}
        })

        if PlayerData.charinfo.gender == 1 then 
            skin = "mp_f_freemode_01" 
        end
        
        ChangeToSkinNoUpdate(skin)
        SendNUIMessage({
            action = "ResetValues",
        })
    end)
end)

RegisterNetEvent("qb-clothes:loadSkin")
AddEventHandler("qb-clothes:loadSkin", function(new, model, data)
    model = model ~= nil and tonumber(model) or false
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
        data = json.decode(data)
        TriggerEvent('qb-clothing:client:loadPlayerClothing', data, PlayerPedId())
    end)
end)


function f(n)
	n = n + 0.00000
	return n
end

RegisterNetEvent('lucid:removePlayerClothes')
AddEventHandler('lucid:removePlayerClothes', function(clothes)

    
    if(clothes) then
        
        local ped = PlayerPedId()

        if (skinData[clothes.type]) then
            skinData[clothes.type].item = skinData[clothes.type].defaultItem
            skinData[clothes.type].texture = skinData[clothes.type].defaultTexture
        end

        if(clothes.type == 't-shirt') then
            -- Arms
            SetPedComponentVariation(ped, 3, 15, 0, 2)
            SetPedComponentVariation(ped, 3, 15, 0, 0)
            skinData['arms'].item = 15
            skinData['arms'].texture = 0
            skinData['t-shirt'].item = 15
            skinData['t-shirt'].texture = 0
            -- Tshirt
            SetPedComponentVariation(ped, 8, 15, 0, 2)
            SetPedComponentVariation(ped, 8, 15, 0, 0)
            
            PlayToggleEmote({Dict = "clothingtie", Anim = "try_tie_negative_a", Move = 51, Dur = 1200})
        elseif(clothes.type == 'mask') then
            -- Mask
            SetPedComponentVariation(ped, 1, 0, 0, 2)
            SetPedComponentVariation(ped, 1, 0,0, 0)
            PlayToggleEmote( {Dict = "mp_masks@standard_car@ds@", Anim = "put_on_mask", Move = 51, Dur = 600})

        elseif(clothes.type == 'torso2') then

            -- Arms
            SetPedComponentVariation(ped, 3, 15, 0, 2)
            SetPedComponentVariation(ped, 3, 15, 0, 0)

            -- Tshirt
            SetPedComponentVariation(ped, 8, 15, 0, 2)
            SetPedComponentVariation(ped, 8, 15, 0, 0)

            -- Torso
            SetPedComponentVariation(ped, 11, 15, 0, 2)
            SetPedComponentVariation(ped, 11, 15, 0, 0)

            skinData['arms'].item = 15
            skinData['arms'].texture = 0
            skinData['t-shirt'].item = 15
            skinData['t-shirt'].texture = 0
            skinData['torso2'].item = 15
            skinData['torso2'].texture = 0


            PlayToggleEmote({Dict = "missmic4", Anim = "michael_tux_fidget", Move = 51, Dur = 1500})

        elseif(clothes.type == 'vest') then
            SetPedComponentVariation(ped, 9, 0, 0, 2)
            SetPedComponentVariation(ped, 9, 0, 0, 0)
            PlayToggleEmote({Dict = "clothingtie", Anim = "try_tie_negative_a", Move = 51, Dur = 1200})
            skinData['vest'].item = 0
            skinData['vest'].texture = 0
        elseif(clothes.type == 'accessory') then
            SetPedComponentVariation(ped, 7, 0, 0, 2)
            SetPedComponentVariation(ped, 7, 0, 0, 0)
            PlayToggleEmote( {Dict = "clothingtie", Anim = "try_tie_positive_a", Move = 51, Dur = 2100})
            skinData['accessory'].item = 0
            skinData['accessory'].texture = 0

        elseif(clothes.type == 'bag') then
            SetPedComponentVariation(ped, 5, 0, 0, 2)
            SetPedComponentVariation(ped, 5, 0, 0, 0)
            PlayToggleEmote({Dict = "anim@heists@ornate_bank@grab_cash", Anim = "intro", Move = 51, Dur = 1600})
            skinData['bag'].item = 0
            skinData['bag'].texture = 0

        elseif(clothes.type == 'pants') then
			if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            SetPedComponentVariation(ped, 4, 15, 0, 2)
            SetPedComponentVariation(ped, 4, 15, 0, 0)
            PlayToggleEmote({Dict = "re@construction", Anim = "out_of_breath", Move = 51, Dur = 1300})
            skinData['pants'].item = 15
            skinData['pants'].texture = 0
			else
            SetPedComponentVariation(ped, 4, 21, 0, 2)
            SetPedComponentVariation(ped, 4, 21, 0, 0)
            PlayToggleEmote({Dict = "re@construction", Anim = "out_of_breath", Move = 51, Dur = 1300})
            skinData['pants'].item = 21
            skinData['pants'].texture = 0
			end

        elseif(clothes.type == 'shoes') then
		if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            SetPedComponentVariation(ped, 6, 35, 0, 2)
            SetPedComponentVariation(ped, 6, 35, 0, 0)
            PlayToggleEmote( {Dict = "random@domestic", Anim = "pickup_low", Move = 0, Dur = 1200})
            skinData['shoes'].item = 35
            skinData['shoes'].texture = 0
			else
			 SetPedComponentVariation(ped, 6, 34, 0, 2)
            SetPedComponentVariation(ped, 6, 34, 0, 0)
            PlayToggleEmote( {Dict = "random@domestic", Anim = "pickup_low", Move = 0, Dur = 1200})
            skinData['shoes'].item = 34
            skinData['shoes'].texture = 0
			end
        elseif(clothes.type == 'hat') then

            PlayToggleEmote({Dict = "missheist_agency2ahelmet", Anim = "take_off_helmet_stand", Move = 51, Dur = 1200})
            ClearPedProp(ped, 0)
            
        elseif(clothes.type == 'glass') then

            PlayToggleEmote({Dict = "clothingspecs", Anim = "take_off", Move = 51, Dur = 1400})
            ClearPedProp(ped, 1)
        elseif(clothes.type == 'ear') then
            PlayToggleEmote({Dict = "mp_cp_stolen_tut", Anim = "b_think", Move = 51, Dur = 900})    
            ClearPedProp(ped, 2)
        elseif(clothes.type == 'watch') then
    
            PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})
            ClearPedProp(ped, 6)
        elseif(clothes.type == 'bracelet') then
        
            PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})
            ClearPedProp(ped, 7)

        end
        SaveSkin()


    end
end)

RegisterNetEvent('lucid:wearPlayerClothes')
AddEventHandler('lucid:wearPlayerClothes', function(clothes)

    if(clothes) then
        local ped = PlayerPedId()
        if (skinData[clothes.type]) then
            skinData[clothes.type].item = clothes.value
            skinData[clothes.type].texture = clothes.texture  
            SaveSkin()
        end

        if(clothes.type == 't-shirt') then

            print('tshirt value : ', clothes.value)
            SetPedComponentVariation(ped, 8, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 8, clothes.value, clothes.texture, 0)
            PlayToggleEmote({Dict = "clothingtie", Anim = "try_tie_negative_a", Move = 51, Dur = 1200})
        elseif(clothes.type == 'mask') then
            -- Mask
            SetPedComponentVariation(ped, 1, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 1, clothes.value,  clothes.texture, 0)
            PlayToggleEmote( {Dict = "mp_masks@standard_car@ds@", Anim = "put_on_mask", Move = 51, Dur = 600})


        elseif(clothes.type == 'torso2') then
            SetPedComponentVariation(ped, 11, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 11, clothes.value, clothes.texture, 0)
            PlayToggleEmote({Dict = "missmic4", Anim = "michael_tux_fidget", Move = 51, Dur = 1500})

        elseif(clothes.type == 'vest') then
            SetPedComponentVariation(ped, 9, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 9, clothes.value, clothes.texture, 0)
            PlayToggleEmote({Dict = "clothingtie", Anim = "try_tie_negative_a", Move = 51, Dur = 1200})

        elseif(clothes.type == 'accessory') then
            SetPedComponentVariation(ped, 7, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 7, clothes.value, clothes.texture, 0)
            PlayToggleEmote( {Dict = "clothingtie", Anim = "try_tie_positive_a", Move = 51, Dur = 2100})


        elseif(clothes.type == 'bag') then
            SetPedComponentVariation(ped, 5, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 5, clothes.value, clothes.texture, 0)
            PlayToggleEmote({Dict = "anim@heists@ornate_bank@grab_cash", Anim = "intro", Move = 51, Dur = 1600})


        elseif(clothes.type == 'pants') then
            SetPedComponentVariation(ped, 4, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 4, clothes.value, clothes.texture, 0)
            PlayToggleEmote({Dict = "re@construction", Anim = "out_of_breath", Move = 51, Dur = 1300})


        elseif(clothes.type == 'shoes') then
            SetPedComponentVariation(ped, 6, clothes.value, 0, 2)
            SetPedComponentVariation(ped, 6, clothes.value, clothes.texture, 0)
            PlayToggleEmote( {Dict = "random@domestic", Anim = "pickup_low", Move = 0, Dur = 1200})


        elseif(clothes.type == 'hat') then
            if clothes.value ~= -1 and clothes.value ~= 0 then
                PlayToggleEmote( {Dict = "mp_masks@standard_car@ds@", Anim = "put_on_mask", Move = 51, Dur = 600})


                SetPedPropIndex(ped, 0, clothes.value, clothes.texture, true)
            else
                PlayToggleEmote({Dict = "missheist_agency2ahelmet", Anim = "take_off_helmet_stand", Move = 51, Dur = 1200})


                ClearPedProp(ped, 0)
            end
        elseif(clothes.type == 'glass') then
            if clothes.value ~= -1 and clothes.value ~= 0 then
                PlayToggleEmote({Dict = "clothingspecs", Anim = "take_off", Move = 51, Dur = 1400})

                SetPedPropIndex(ped, 1, clothes.value, clothes.texture, true)
            else
                PlayToggleEmote({Dict = "clothingspecs", Anim = "take_off", Move = 51, Dur = 1400})

                ClearPedProp(ped, 1)
            end
        elseif(clothes.type == 'ear') then
            if clothes.value ~= -1 and clothes.value ~= 0 then
                PlayToggleEmote({Dict = "mp_cp_stolen_tut", Anim = "b_think", Move = 51, Dur = 900})
                SetPedPropIndex(ped, 2, clothes.value, clothes.texture, true)
            else
                PlayToggleEmote({Dict = "mp_cp_stolen_tut", Anim = "b_think", Move = 51, Dur = 900})    

                ClearPedProp(ped, 2)
            end
        elseif(clothes.type == 'watch') then
            if clothes.value ~= -1 and clothes.value ~= 0 then
                PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})

                SetPedPropIndex(ped, 6, clothes.value, clothes.texture, true)
            else
                PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})


                ClearPedProp(ped, 6)
            end
        elseif(clothes.type == 'bracelet') then
            if clothes.value ~= -1 and clothes.value ~= 0 then
                PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})
                SetPedPropIndex(ped, 7, clothes.value, clothes.texture, true)
            else
                PlayToggleEmote({Dict = "nmt_3_rcm-10", Anim = "cs_nigel_dual-10", Move = 51, Dur = 1200})
                ClearPedProp(ped, 7)
            end
        end
    end
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing')
AddEventHandler('qb-clothing:client:loadPlayerClothing', function(data, ped)
    if ped == nil then ped = PlayerPedId() end

    for i = 0, 11 do
        SetPedComponentVariation(ped, i, 0, 0, 0)
    end

    for i = 0, 7 do
        ClearPedProp(ped, i)
    end

  -- Face
    if not data["facemix"] or not data["face2"] then
        data["facemix"] = skinData["facemix"]
        data["facemix"].shapeMix = data["facemix"].defaultShapeMix
        data["facemix"].skinMix = data["facemix"].defaultSkinMix
        data["face2"] = skinData["face2"]
    end
    SetPedHeadBlendData(ped, data["face"].item, data["face2"].item, nil, data["face"].texture, data["face2"].texture, nil, data["facemix"].shapeMix, data["facemix"].skinMix, nil, true)

    -- Pants
    SetPedComponentVariation(ped, 4, data["pants"].item, 0, 0)
    SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)

    -- Hair
    SetPedComponentVariation(ped, 2, data["hair"].item, 0, 0)
    SetPedHairColor(ped, data["hair"].texture, data["hair"].texture)

    -- Eyebrows
    SetPedHeadOverlay(ped, 2, data["eyebrows"].item, data["eyebrows_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows"].texture, 0)

    -- Beard
    SetPedHeadOverlay(ped, 1, data["beard"].item, data["beard_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 1, 1, data["beard"].texture, 0)
	
	-- Chest Hair
    SetPedHeadOverlay(ped, 10, data["chest"].item, data["chest_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 10, 1, data["chest"].texture, 0)
	
	 -- Sun Damage
    SetPedHeadOverlay(ped, 7, data["sun"].item, data["sun_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 7, 1, data["sun"].texture, 0)
	
	 -- Blemishes
    SetPedHeadOverlay(ped, 0, data["blemishes"].item, data["blemishes_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 0, 1, data["blemishes"].texture, 0)
	
	 -- Complexion
    SetPedHeadOverlay(ped, 6, data["complexion"].item, data["complexion_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 6, 1, data["complexion"].texture, 0)
	
    -- Blush
    SetPedHeadOverlay(ped, 5, data["blush"].item, data["blush_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 5, 1, data["blush"].texture, 0)

    -- Lipstick
    SetPedHeadOverlay(ped, 8, data["lipstick"].item, data["lipstick_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 8, 1, data["lipstick"].texture, 0)

    -- Makeup
	 SetPedHeadOverlay(ped, 4, data["makeup"].item, data["makeup_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 4, 1, data["makeup"].texture, 0)

    -- Ageing
	 SetPedHeadOverlay(ped, 3, data["ageing"].item, data["ageing_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 3, 1, data["ageing"].texture, 0)
	
    -- Arms
    SetPedComponentVariation(ped, 3, data["arms"].item, 0, 2)
    SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)

    -- T-Shirt
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, 0, 2)
    SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0) 
    -- Vest
    SetPedComponentVariation(ped, 9, data["vest"].item, 0, 2)
    SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)   
    -- Torso 2
    SetPedComponentVariation(ped, 11, data["torso2"].item, 0, 2)
    SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)  
    -- Shoes
    SetPedComponentVariation(ped, 6, data["shoes"].item, 0, 2)
    SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0) 
    -- Mask
    SetPedComponentVariation(ped, 1, data["mask"].item, 0, 2)
    SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)

    -- Badge
    SetPedComponentVariation(ped, 10, data["decals"].item, 0, 2)
    SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)

    -- Accessory
      SetPedComponentVariation(ped, 7, data["accessory"].item, 0, 2)
      SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)

    -- Bag
    SetPedComponentVariation(ped, 5, data["bag"].item, 0, 2)
    SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)    
    -- Hat
     if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
         SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
     else
         ClearPedProp(ped, 0)
     end    
     -- Glass
     if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
         SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
     else
         ClearPedProp(ped, 1)
     end    
     -- Ear
     if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
         SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
     else
         ClearPedProp(ped, 2)
     end    
     -- Watch
     if data["watch"].item ~= -1 and data["watch"].item ~= 0 then
         SetPedPropIndex(ped, 6, data["watch"].item, data["watch"].texture, true)
     else
         ClearPedProp(ped, 6)
     end    
     -- Bracelet
     if data["bracelet"].item ~= -1 and data["bracelet"].item ~= 0 then
         SetPedPropIndex(ped, 7, data["bracelet"].item, data["bracelet"].texture, true)
     else
         ClearPedProp(ped, 7)
     end

    if data["eye_color"].item ~= -1 and data["eye_color"].item ~= 0 then
        SetPedEyeColor(ped, data['eye_color'].item)
    else
       
    end

    -- if data["moles"].item ~= -1 and data["moles"].item ~= 0 then
        -- SetPedHeadOverlay(ped, 9, data['moles'].item, (data['moles'].texture / 10))
    -- else
       
    -- end
	
	SetPedHeadOverlay(ped, 9, data["moles"].item, data["moles_opacity"].item / 100 + 0.0)
    SetPedHeadOverlayColor(ped, 9, 1, data["moles"].texture, 0)

    SetPedFaceFeature(ped, 0, (data['nose_0'].item / 10))
    SetPedFaceFeature(ped, 1, (data['nose_1'].item / 10))
    SetPedFaceFeature(ped, 2, (data['nose_2'].item / 10))
    SetPedFaceFeature(ped, 3, (data['nose_3'].item / 10))
    SetPedFaceFeature(ped, 4, (data['nose_4'].item / 10))
    SetPedFaceFeature(ped, 5, (data['nose_5'].item / 10))
    SetPedFaceFeature(ped, 6, (data['eyebrown_high'].item / 10))
    SetPedFaceFeature(ped, 7, (data['eyebrown_forward'].item / 10))
    SetPedFaceFeature(ped, 8, (data['cheek_1'].item / 10))
    SetPedFaceFeature(ped, 9, (data['cheek_2'].item / 10))
    SetPedFaceFeature(ped, 10,(data['cheek_3'].item / 10))
    SetPedFaceFeature(ped, 11, (data['eye_opening'].item / 10))
    SetPedFaceFeature(ped, 12, (data['lips_thickness'].item / 10))
    SetPedFaceFeature(ped, 13, (data['jaw_bone_width'].item / 10))
    SetPedFaceFeature(ped, 14, (data['jaw_bone_back_lenght'].item / 10))
    SetPedFaceFeature(ped, 15, (data['chimp_bone_lowering'].item / 10))
    SetPedFaceFeature(ped, 16, (data['chimp_bone_lenght'].item / 10))
    SetPedFaceFeature(ped, 17, (data['chimp_bone_width'].item / 10))
    SetPedFaceFeature(ped, 18, (data['chimp_hole'].item / 10))
    SetPedFaceFeature(ped, 19, (data['neck_thikness'].item / 10))


    skinData = data
end)

function typeof(var)
    local _type = type(var);
    if(_type ~= "table" and _type ~= "userdata") then
        return _type;
    end
    local _meta = getmetatable(var);
    if(_meta ~= nil and _meta._NAME ~= nil) then
        return _meta._NAME;
    else
        return _type;
    end
end

RegisterNetEvent('qb-clothing:client:loadOutfit')
AddEventHandler('qb-clothing:client:loadOutfit', function(oData)
    local ped = PlayerPedId()

    data = oData.outfitData

    if typeof(data) ~= "table" then data = json.decode(data) end

    for k, v in pairs(data) do
        skinData[k].item = data[k].item
        skinData[k].texture = data[k].texture
    end

    -- Pants
     if data["pants"] ~= nil then
         SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)
     end    
     -- Arms
     if data["arms"] ~= nil then
         SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)
     end    
     -- T-Shirt
     if data["t-shirt"] ~= nil then
         SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)
     end    
     -- Vest
     if data["vest"] ~= nil then
         SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)
     end    
     -- Torso 2
     if data["torso2"] ~= nil then
         SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)
     end    
     -- Shoes
     if data["shoes"] ~= nil then
         SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)
     end    
     -- Bag
     if data["bag"] ~= nil then
         SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
     end    
     -- Badge
     if data["badge"] ~= nil then
         SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)
     end    
     -- Accessory
     if data["accessory"] ~= nil then
         if QBCore.Functions.GetPlayerData().metadata["tracker"] then
             SetPedComponentVariation(ped, 7, 13, 0, 0)
         else
             SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
         end
     else
         if QBCore.Functions.GetPlayerData().metadata["tracker"] then
             SetPedComponentVariation(ped, 7, 13, 0, 0)
         else
             SetPedComponentVariation(ped, 7, -1, 0, 2)
         end
     end    
     -- Mask
     if data["mask"] ~= nil then
         SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)
     end    
     -- Bag
     if data["bag"] ~= nil then
         SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
     end    
     -- Hat
     if data["hat"] ~= nil then
         if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
             SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
         else
             ClearPedProp(ped, 0)
         end
     end    
     -- Glass
     if data["glass"] ~= nil then
         if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
             SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
         else
             ClearPedProp(ped, 1)
         end
     end    
     -- Ear
     if data["ear"] ~= nil then
         if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
             SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
         else
             ClearPedProp(ped, 2)
         end
     end    
    if oData.outfitName ~= nil then
        QBCore.Functions.Notify("You have chosen "..oData.outfitName.."! Press Confirm to confirm outfit.")
    end
end)

local faceProps = {
	[1] = { ["Prop"] = -1, ["Texture"] = -1 },
	[2] = { ["Prop"] = -1, ["Texture"] = -1 },
	[3] = { ["Prop"] = -1, ["Texture"] = -1 },
	[4] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[5] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[6] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
}

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent("qb-clothing:client:adjustfacewear")
AddEventHandler("qb-clothing:client:adjustfacewear",function(type)
    if QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] then return end
	removeWear = not removeWear
	local AnimSet = "none"
	local AnimationOn = "none"
	local AnimationOff = "none"
	local PropIndex = 0

	local AnimSet = "mp_masks@on_foot"
	local AnimationOn = "put_on_mask"
	local AnimationOff = "put_on_mask"

	faceProps[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 0)
	faceProps[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 0)
	faceProps[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 0)

	for i = 0, 3 do
		if GetPedPropIndex(PlayerPedId(), i) ~= -1 then
			faceProps[i+1]["Prop"] = GetPedPropIndex(PlayerPedId(), i)
		end
		if GetPedPropTextureIndex(PlayerPedId(), i) ~= -1 then
			faceProps[i+1]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), i)
		end
	end

	if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 then
		faceProps[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
		faceProps[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)
		faceProps[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
	end

	if GetPedDrawableVariation(PlayerPedId(), 11) ~= -1 then
		faceProps[5]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
		faceProps[5]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)
		faceProps[5]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
	end

	if type == 1 then
		PropIndex = 0
	elseif type == 2 then
		PropIndex = 1

		AnimSet = "clothingspecs"
		AnimationOn = "take_off"
		AnimationOff = "take_off"

	elseif type == 3 then
		PropIndex = 2
	elseif type == 4 then
		PropIndex = 1
		if removeWear then
			AnimSet = "missfbi4"
			AnimationOn = "takeoff_mask"
			AnimationOff = "takeoff_mask"
		end
	elseif type == 5 then
		PropIndex = 11
		AnimSet = "oddjobs@basejump@ig_15"
		AnimationOn = "puton_parachute"
		AnimationOff = "puton_parachute"	
		--mp_safehouseshower@male@ male_shower_idle_d_towel
		--mp_character_creation@customise@male_a drop_clothes_a
		--oddjobs@basejump@ig_15 puton_parachute_bag
	end

	loadAnimDict( AnimSet )
	if type == 5 then
		if removeWear then
			SetPedComponentVariation(PlayerPedId(), 3, 2, faceProps[6]["Texture"], faceProps[6]["Palette"])
		end
	end
	if removeWear then
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOff, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if type ~= 5 then
			if type == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
			else
				if type ~= 2 then
					ClearPedProp(PlayerPedId(), tonumber(PropIndex))
				end
			end
		end
	else
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if type ~= 5 and type ~= 2 then
			if type == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, faceProps[type]["Prop"], faceProps[type]["Texture"], faceProps[type]["Palette"])
			else
				SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(faceProps[PropIndex+1]["Prop"]), tonumber(faceProps[PropIndex+1]["Texture"]), false)
			end
		end
	end
	if type == 5 then
		if not removeWear then
			SetPedComponentVariation(PlayerPedId(), 3, 1, faceProps[6]["Texture"], faceProps[6]["Palette"])
			SetPedComponentVariation(PlayerPedId(), PropIndex, faceProps[type]["Prop"], faceProps[type]["Texture"], faceProps[type]["Palette"])
		else
			SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
		end
		Citizen.Wait(1800)
	end
	if type == 2 then
		Citizen.Wait(600)
		if removeWear then
			ClearPedProp(PlayerPedId(), tonumber(PropIndex))
		end

		if not removeWear then
			Citizen.Wait(140)
			SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(faceProps[PropIndex+1]["Prop"]), tonumber(faceProps[PropIndex+1]["Texture"]), false)
		end
	end
	if type == 4 and removeWear then
		Citizen.Wait(1200)
	end
	ClearPedTasks(PlayerPedId())
end)




function GetComponentDataFromHash(hash)
    local blob = string.rep('\0\0\0\0\0\0\0\0', 9 + 16)
    if not Citizen.InvokeNative(0x74C0E2A57EC66760, hash, blob) then
        return nil
    end

    -- adapted from: https://gist.github.com/root-cause/3b80234367b0c856d60bf5cb4b826f86
    local lockHash = string.unpack('<i4', blob, 1)
    local hash = string.unpack('<i4', blob, 9)
    local locate = string.unpack('<i4', blob, 17)
    local drawable = string.unpack('<i4', blob, 25)
    local texture = string.unpack('<i4', blob, 33)
    local field5 = string.unpack('<i4', blob, 41)
    local component = string.unpack('<i4', blob, 49)
    local field7 = string.unpack('<i4', blob, 57)
    local field8 = string.unpack('<i4', blob, 65)
    local gxt = string.unpack('c64', blob, 73)

    return component, drawable, texture, gxt, field5, field7, field8
end


function GetPropDataFromHash(hash)
    local blob = string.rep('\0\0\0\0\0\0\0\0', 9 + 16)
    if not Citizen.InvokeNative(0x5D5CAFF661DDF6FC, hash, blob) then
        return nil
    end

    -- adapted from: https://gist.github.com/root-cause/3b80234367b0c856d60bf5cb4b826f86
    local lockHash = string.unpack('<i4', blob, 1)
    local hash = string.unpack('<i4', blob, 9)
    local locate = string.unpack('<i4', blob, 17)
    local drawable = string.unpack('<i4', blob, 25)
    local texture = string.unpack('<i4', blob, 33)
    local field5 = string.unpack('<i4', blob, 41)
    local prop = string.unpack('<i4', blob, 49)
    local field7 = string.unpack('<i4', blob, 57)
    local field8 = string.unpack('<i4', blob, 65)
    local gxt = string.unpack('c64', blob, 73)

    return prop, drawable, texture, gxt, field5, field7, field8
end