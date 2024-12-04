function onEvent(name,value1,value2)
    if name == "Set Cam Zoom" then
        doTweenZoom('camz','camGame',tonumber(value1),tonumber(value2),'cubeOut')
	end
end

function onTweenCompleted(name)
if name == 'camz' or name == 'finalzoommario' or name == 'finalzoombf' or name == 'boing' then
    setProperty("defaultCamZoom",getProperty('camGame.zoom')) 
end
end