-- Der score soll immer direkt aktuell sein.
-- Es muss eine bedingung da sein die entscheidet ob der NEUE score ins gameOver kommt.




Menu = Core.class(Sprite)

function Menu:init()

	self.picture = Bitmap.new(Texture.new("menu.png"))
		self:addChild(self.picture)
		
	self.difficultyHard = TextField.new(nil, "Difficulty: Hard")
	self:addChild(self.difficultyHard)
	self.difficultyHard:setTextColor(0xff0000)
	self.difficultyHard:setPosition(20, 225)
	self.difficultyHard:setScale(3)
	
	self.difficultyNormal = TextField.new(nil, "Difficulty: Normal")
	self:addChild(self.difficultyNormal)
	self.difficultyNormal:setTextColor(0xff0000)
	self.difficultyNormal:setPosition(20, 185)
	self.difficultyNormal:setScale(3)
	
	self.difficultySimple = TextField.new(nil, "Difficulty: Simple")
	self:addChild(self.difficultySimple)
	self.difficultySimple:setTextColor(0xff0000)
	self.difficultySimple:setPosition(20, 140)
	self.difficultySimple:setScale(3)
	
	
	 self.startButton = TextField.new(nil, "start new game")
	self:addChild(self.startButton)
	self.startButton:setTextColor(0xff0000)
	self.startButton:setPosition(20, 34)
	self.startButton:setScale(3)
	
	self.continueButton = TextField.new(nil, "continue")
	self.continueButton:setTextColor(0xff0000)
	self.continueButton:setPosition(20, 80)
	self.continueButton:setScale(3)
	
	local function begin(button, event)	
		if button:hitTestPoint(event.touch.x, event.touch.y) then
			gameScreen = Game.new()
			collectgarbage()
			changeToScreen("game")
		end
	end
	
	self.startButton:addEventListener(Event.TOUCHES_END, begin, self.startButton)
	
	local function continue(button, event)
		if button:hitTestPoint(event.touch.x, event.touch.y) then
			changeToScreen("game")
			gameScreen.paused = false
		end
	end
	
	self.continueButton:addEventListener(Event.TOUCHES_END, continue, self.continueButton)
	
end

function Menu:start()
	if self.continueButton:getParent() == self then
		self:removeChild(self.continueButton)
	end
	
	if gameScreen and  gameScreen.running   then
		self:addChild(self.continueButton)	
	end
	
	if gameScreen and  gameScreen.running   then
	
	end
	
	
	
	
end


function Menu:pause()
	
end