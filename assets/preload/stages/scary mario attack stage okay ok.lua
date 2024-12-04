local ffi = require("ffi")  -- Load FFI module (instance)

local user32 = ffi.load("user32")   -- Load User32 DLL handle

ffi.cdef([[
enum{
    MB_OK = 0x00000000L,
    MB_ICONINFORMATION = 0x00000040L
};

typedef void* HANDLE;
typedef HANDLE HWND;
typedef const char* LPCSTR;
typedef unsigned UINT;

int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
]]) -- Define C -> Lua interpretation

what = false

function onGameOver()

    return Function_Stop
end

dead = false
hahayoudie = false

frameBF = 0
frameGF = 0
frameDAD = 0
frameLose = 0
function onCustomSubstateUpdate(n,elapsed)
    if n == 'gamerrrr' then
        frameBF = frameBF + (elapsed*12)
        frameDAD = frameDAD + (elapsed*20)
        frameGF = frameGF + (elapsed*20)
        frameLose = frameLose + (elapsed*20)

        setProperty('boyfriend.animation.curAnim.curFrame',frameBF)
        setProperty('gf.animation.curAnim.curFrame',frameGF)
        setProperty('dad.animation.curAnim.curFrame',frameDAD)
        setProperty('loseSprite.animation.curAnim.curFrame',frameLose)
    end
end


function onUpdate(elapsed)
    if getHealth() <= 0.0001 and not dead then
        openCustomSubstate('gamerrrr',true)
        dead = true
    end

end

function onCustomSubstateCreatePost(n)
    if n == 'gamerrrr' then
        if not hahayoudie then
            setProperty('camHUD.alpha', 0)
            setProperty('boyfriend.alpha', 0)
            setProperty("deadboy.alpha", 1)
            doTweenX("horizontaldeath", "deadboy", getRandomInt(700,500), 1.0, "quadOut")
            doTweenY("verticaldeath1", "deadboy", getRandomInt(450,500), 0.5, "quadOut")
            doTweenAngle("spinspin", "deadboy", -340, 0.5, "quadOut")
            playSound('ow',1)
            runTimer("flop", 3.6)

            hahayoudie = true
        end
    end
end

function onCreate()
	setProperty("skipCountdown", true)
end

xthingy = -850
xthingy2 = 130
isshaking = 0

function onCreatePost()
	setProperty('camZoomingMult', 0)
	setProperty('healthBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('showRating', false);
    setProperty('showComboNum', false); 
    runHaxeCode('FlxG.camera.pixelPerfectRender = true;')
    setPropertyFromClass('ClientPrefs', 'noteSplashes', false)
    setPropertyFromClass('Main', 'fpsVar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)

	createInstance('backdrop', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('backdrop', 'sky')
    addInstance('backdrop')
    setProperty('backdrop.velocity.x', 10)
    setProperty("backdrop.alpha", 1)
	scaleObject('backdrop', 3, 3)

    makeLuaSprite('castleleft1', 'castle', xthingy, 900);
    setScrollFactor('castleleft1',0.9,0.9)
    addLuaSprite('castleleft1', false);
	scaleObject('castleleft1', 2.3, 2.3)
    doTweenColor("shh", "castleleft1", "333333", 0.0001, "linear")
	setProperty('castleleft1.antialiasing', false)

    makeLuaSprite('castleright1', 'castle', xthingy2, 900);
    setScrollFactor('castleright1',0.9,0.9)
    addLuaSprite('castleright1', false);
	scaleObject('castleright1', 2.3, 2.3)
    doTweenColor("shh2", "castleright1", "333333", 0.0001, "linear")
	setProperty('castleright1.antialiasing', false)

	makeLuaSprite('castlemain', 'castle', -600, 150);
    setScrollFactor('castlemain',1,1)
    addLuaSprite('castlemain', false);
	scaleObject('castlemain', 3, 3)
	setProperty('castlemain.antialiasing', false)

	createInstance('floor', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('floor', 'Floor')
    addInstance('floor')
    setProperty("floor.alpha", 1)
	setProperty("floor.y", 150)
	scaleObject('floor', 3, 3)

    makeLuaSprite('koopa1', 'koopa1', -390, 627);
    setScrollFactor('koopa1',1,1)
    addLuaSprite('koopa1', true);
	scaleObject('koopa1', 3, 3)
	setProperty('koopa1.antialiasing', false)
    
    makeLuaSprite('koopa2', 'koopa2', -190, 627);
    setScrollFactor('koopa2',1,1)
    addLuaSprite('koopa2', true);
	scaleObject('koopa2', 3, 3)
	setProperty('koopa2.antialiasing', false)

    makeLuaSprite('koopa3', 'koopa3', 490, 627);
    setScrollFactor('koopa3',1,1)
    addLuaSprite('koopa3', true);
	scaleObject('koopa3', 3, 3)
	setProperty('koopa3.antialiasing', false)

    makeLuaSprite('koopa4', 'koopa4', 690, 627);
    setScrollFactor('koopa4',1,1)
    addLuaSprite('koopa4', true);
	scaleObject('koopa4', 3, 3)
	setProperty('koopa4.antialiasing', false)
    
	makeLuaSprite('deadboy', 'deadboy', 350, 590);
    setScrollFactor('deadboy',1,1)
    addLuaSprite('deadboy', true);
	scaleObject('deadboy', 3, 3)
	setProperty('deadboy.antialiasing', false)
    setProperty("deadboy.flipX", true)
    setProperty("deadboy.alpha", 0)

    makeLuaSprite('vig', 'vignette', -630, 00);
    setScrollFactor('vig',1,1)
    setProperty("vig.alpha", 0)
    addLuaSprite('vig', true);
    scaleObject("vig", 0.9, 0.9)

    makeLuaSprite('introblackthing', '', 0, 0);
    makeGraphic('introblackthing',1280,720, '000000')
    setScrollFactor('introblackthing',0,0)
    addLuaSprite('introblackthing', true);
    setProperty('introblackthing.scale.y',2)
    setProperty('introblackthing.scale.x',2)
    setProperty('introblackthing.alpha',1)

    setProperty('camHUD.alpha', 0)
    triggerEvent("Camera Follow Pos", 240, 350)
    setProperty('boyfriendCameraOffset',{-40,0})
    setProperty('opponentCameraOffset',{-100, 30})

    -- HUD SHIT

    makeLuaText('scoretest', '', screenWidth, 50, 100);
    setTextSize('scoretest', 12);
    setTextAlignment('scoretest', 'left');
    addLuaText('scoretest');
    scaleObject("scoretest", 2, 2)
    setTextString("scoretest", "SCORE")
    setTextBorder("scoretest", 0, "FFFFFF")
    setTextFont("scoretest", 'Zero.otf')

    makeLuaText('meee', '', screenWidth, 50, 10);
    setTextSize('meee', 12);
    setTextAlignment('meee', 'left');
    scaleObject("meee", 2, 2)
    addLuaText('meee');
    setTextString("meee", "BOYFRIEND")
    setTextBorder("meee", 0, "FFFFFF")
    setTextFont("meee", 'Zero.otf')
    setProperty("mee.antialiasing", true)

    setProperty("healthBar.x", 40)
    setHealthBarColors("000000", "990000")
    setProperty("health", 2)

    makeLuaText('scorenumber', '', screenWidth, 190, 100);
    setTextSize('scorenumber', 12);
    setTextAlignment('scorenumber', 'left');
    addLuaText('scorenumber');
    scaleObject("scorenumber", 2, 2)
    setTextColor("scorenumber", "FF0000")
    setTextBorder("scorenumber", 0, "FFFFFF")
    setTextFont("scorenumber", 'lalala butt butt')

    if downscroll == false then
        setProperty('scoretest.y', 650)
        setProperty('scorenumber.y', 650)
        setProperty('meee.y', 540)
        setProperty("healthBar.y", 600)
    else  
     setProperty("healthBar.y", 50)
    end

end

function onSongStart()
    doTweenAlpha("yeah man", "introblackthing", 0, 8.0, "cubeInOut")
    doTweenZoom("woaah", "game", 1, 9.0, "cubeInOut")
end

function onBeatHit()


    if curBeat == 32 then
        doTweenAlpha("gameplay", "camHUD", 1, 1.0, "cubeOut")
    end

    if curBeat == 129 then
        doTweenZoom('woa','camGame',1.8, 1.5,'cubeIn')
        doTweenY("wee1", "castleleft1", 350, 5.0, "cubeOutIn")
        doTweenY("wee2", "castleright1", 350, 5.0, "cubeOutIn")
        isshaking = 1
    end

    if curBeat == 132 then
        cancelTween("woa")
        doTweenZoom('camz','camGame',0.9, 1,'cubeOut')
        setProperty('boyfriendCameraOffset', {-40,-100} )
        setProperty('opponentCameraOffset', {-100, -70} )
    end

    if curBeat >= 196 and curBeat <= 260 then
        if curBeat % 2 == 0  then
        else
         triggerEvent("Add Camera Zoom", 0.015, 0)
        end

    end

    if curBeat == 292 then
        doTweenZoom('finalzoommario','camGame',1.4, 7,'quadIn')
        doTweenAlpha("scaryred", "vig", 0.6, 2, "linear")
    end

    if curBeat == 308 then
        cancelTween("finalzoommario")
        doTweenZoom('finalzoombf','camGame',1, 7,'quadIn')
    end

    if curBeat == 324 then
        cancelTween("finalzoombf")
        doTweenZoom('boing','camGame',0.9, 1,'cubeOut')
    end

    if curBeat == 328 then
        setProperty('camHUD.alpha', 0)
        setProperty('introblackthing.alpha', 1)
    end
end


function onTweenCompleted(name)
    if name == 'camz' then
     setProperty("defaultCamZoom",getProperty('camGame.zoom')) 
    end
    if name == 'wee1' then
        isshaking = 0
    end
    if name == 'goinup' then
        doTweenY("goindown", "boyfriend", getProperty("boyfriend.y" + 150), 1.0, "cubeInOut")
        doTweenAngle("wowaowaoaw", "boyfriend", 15, 4.0, "cubeInOut")
    
    end
    if name == 'verticaldeath1' then
        doTweenY("verticaldeath2", "deadboy", 1200, 1.0, "cubeIn")
    end
    if name == 'verticaldeath2' then
        restartSong()
    end
    if name == 'spinspin' then
        doTweenAngle("yoowww", "deadboy", -450, 2.0, "cubeInOut")
    end

end

function onUpdatePost()
    setTextString("scorenumber", score)

    if isshaking == 1 then
        setProperty('castleleft1.x', xthingy + getRandomInt(5, -5))
        setProperty('castleright1.x', xthingy2 + getRandomInt(5, -5))
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)

    setProperty("health", getProperty("health") - 0.1)
    
end