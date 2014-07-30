Game = Core.class(Sprite)

function Game:init()

	self.speed = 0

	self.running = true

	self.failCounter = 0
	
	self.paused = false
	
		--Erzeugt Hintergrundmusik
	self.music = Sound.new("music.mp3")
	self.music:play(0, true)

	--Hintergrund wird erzeugt
	self.background = Bitmap.new(Texture.new("background.png"))
	self:addChild(self.background)

	 --Punktestand insgesamt:
	self.gesamtPunkte = TextField.new(nil, "Score:")
	self:addChild(self.gesamtPunkte)
	self.gesamtPunkte:setTextColor(0xff0000)
	self.gesamtPunkte:setPosition(418, 30)
	self.gesamtPunkte:setScale(2.5)

	--Punktestand aktuell:
	self.aktuellePunkte = TextField.new(nil, "")
	self:addChild(self.aktuellePunkte)
	self.aktuellePunkte:setTextColor(0xff0000)
	self.aktuellePunkte:setPosition(514, 54)
	self.aktuellePunkte:setScale(2.5)
	
	--Pausieren Knopf:
	self.pausieren = TextField.new(nil, "Pause")
	self:addChild(self.aktuellePunkte)
	self.pausieren:setTextColor(0xff0000)
	self.pausieren:setPosition(10, 30)
	self.pausieren:setScale(3)
	
	local function onTouch(button, event)
	    if button:hitTestPoint(event.touch.x, event.touch.y) then
			changeToScreen("menu")
			
		end
	end
	
	self:addChild(self.pausieren)

	self.pausieren:addEventListener(Event.TOUCHES_END, onTouch, self.pausieren)
	
	


	--Table speichert die Zombies.
	self.zombieList = {}





	--Der timer erzeugt jede sekunde einen zombie und addet ihn zur stage.
	self.timer = Timer.new(1900)
	self.timer:addEventListener(Event.TIMER, self.onTimer, self)
	
	self.score = 0
	
	
	
	self:displayScore("score: " .. 0, 0)

	
	self:addEventListener(Event.ENTER_FRAME, self.update, self)

end

function Game:displayScore(gesPunkte, aktPunkte)
	self.gesamtPunkte:setText(gesPunkte)
	self.aktuellePunkte:setText(aktPunkte)	
end

function Game:start()
	self.timer:start()
end

function Game:pause()
	self.timer:stop()
	gameScreen.paused = true
end

 function Game:onTimer(event)

	local zombie = Zombie.new("soldier", "left", self.speed)
    table.insert(self.zombieList, zombie)
	self:addChild(zombie)
    zombie = Zombie.new("general", "right")
	table.insert(self.zombieList, zombie)
	self:addChild(zombie)
	
end




function Game:readHighScore()

	
	
		
	local scoreFile = io.open("|D|score.txt", "r")
	if not scoreFile then
		scoreFile = io.open("|D|score.txt", "w")
		scoreFile:write("0")
	end	
	local currentHighScore = scoreFile:read("*all")             --> read whole file
	scoreFile:close()
	
	print(currentHighScore)
	
	if  currentHighScore == "" then
		scoreFile = io.open("|D|score.txt", "w")
		scoreFile:write("0")
		scoreFile:close()
		return 0
	else
		return  tonumber(currentHighScore)
	end
	
end

function Game:setScoreAsHighScore()
	local scoreFile = io.open("|D|score.txt", "w")

	
--> open text.txt in documents directory to write
	scoreFile:write(self.score)                  --> write a string
	scoreFile:close()   
	
end


function Game:checkHighScore()
 local currentHighScore = self:readHighScore() 
 if self.score >= currentHighScore then
	self:setScoreAsHighScore()
	gameOver.showScore = true
 end
	

end




--Ändert den Score:
function Game:addScore(typ)
	local points = 0
	if typ == "general" then
		points = 10
	end
	if typ == "soldier" then
		points = 5
	end
	if typ == "fail" then
		points = -5
		if self.failCounter == 5 then
			self:checkHighScore()
			changeToScreen("gameOver")
			self.running = false
		end
	end
	
	self.score = self.score + points
	self:displayScore("score: " .. self.score, points )
	
end


--onEnterFrame iteriert über die table und zeichnet, bewegt, und löscht die Zombies mit 60 fps.
 function Game:update(event)
	if gameScreen.paused then
		return
	end
	
	for key,zombie in ipairs(self.zombieList) do
		zombie:draw()
		zombie:update()
		if  not zombie.alive then 
			SplatterEffect.new(zombie:getX(), zombie:getY(),80, 50, self)
			table.remove(self.zombieList ,key)
			self:removeChild(zombie)
			print("Zombie wurde gelöscht")

		end
	end
end
 
 
 
 
 
 
 
 
