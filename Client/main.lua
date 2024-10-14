for k,v in pairs(Config.Elevators) do 
    local Elevators = Config.Elevators[k]
    for k2, v2 in pairs(Elevators.Floors) do 
        local point = lib.points.new({
            coords = v2.coords,
            distance = 3,
        })
         
        function point:onEnter()
            lib.showTextUI('Press [E] to open the elevator ' .. v.Name, {
                position = "left-center",
                icon = 'elevator',
                style = {
                    borderRadius = '.3vw',
                    backgroundColor = '#111111',
                    color = 'white',
                    boxShadow = '0 0 .4vw rgba(0, 0, 0, 0.5)',
                }
            })
        end
         
        function point:onExit()
            lib.hideTextUI()
        end
         
        function point:nearby()
            DrawMarker(21, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.4, 0.4, 0.4,  0, 102, 255, 100, false, true, 2, true, nil, nil, false)
            if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
                local currentFloors = Config.Elevators[k].Floors
                loadFloors(currentFloors, v2.number, k)
            end
        end
    end
end

function loadFloors(currentFloors, currentFloor, currentInfo)
    for k,v in pairs(currentFloors) do 
        SendNUIMessage({
            action = 'show',
            planta = currentFloor,
            numbers = v,
            currentInfo = currentInfo,
        })
    end
    SetNuiFocus(true, true)
end

RegisterNUICallback('tp', function(data, cb)
    local nextFloor = Config.Elevators[data.floorInfo]
    for k,v in pairs(nextFloor.Floors) do 
        if tonumber(v.number) == tonumber(data.floorIndex) then
            local coords = v.coords
            DoScreenFadeOut(1000)
            Wait(2000)
            SetEntityCoords(cache.ped, vector3(coords.x, coords.y, coords.z))
            Wait(4000)
            DoScreenFadeIn(2000)
            break
        end
    end
end)

RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
end)

