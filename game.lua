SCREEN_WIDTH = application:getContentWidth()
SCREEN_HEIGHT = application:getContentHeight()

local background = Bitmap.new(Texture.new("WAWBackGround.png"))
stage:addChild(background)

--Table speichert die Zombies.
zombieList = {}





--Der timer erzeugt jede sekunde einen zombie und addet ihn zur stage.
local timer = Timer.new(1900)


local function onTimer(event)

	local zombie = Zombie.new("soldier", "left")
    table.insert(zombieList, zombie)
	stage:addChild(zombie)
    zombie = Zombie.new("general", "right")
	table.insert(zombieList, zombie)
	stage:addChild(zombie)
	
end

timer:addEventListener(Event.TIMER, onTimer)
	
timer:start()




--onEnterFrame iteriert über die table und zeichnet, bewegt, und löscht die Zombies mit 60 fps.
 function onEnterFrame(event)
	for key,zombie in ipairs(zombieList) do
	    
		
		
		zombie:draw()
		zombie:update()
		if  not zombie.alive then 
			table.remove(zombieList ,key)
			stage:removeChild(zombie)
			print("Zombie wurde gelöscht")
		end
	end
end
 
 stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)
 
 
 
 
 
 
