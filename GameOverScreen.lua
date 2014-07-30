 GameOverScreen= Core.class(Sprite)

 function GameOverScreen:init()
 
	self.showScore = false
 
	self.picture = Bitmap.new(Texture.new("gameOver.png"))
		self:addChild(self.picture)

	
	
	self.scoreLabel = TextField.new(nil, "")
	self:addChild(self.scoreLabel)
	self.scoreLabel:setTextColor(0xff0000)
	self.scoreLabel:setPosition(183, 275)
	self.scoreLabel:setScale(2)
	
	self.gameOverLabel = TextField.new(nil, "Game Over")
	self:addChild(self.gameOverLabel)
	self.gameOverLabel:setTextColor(0xff0000)
	self.gameOverLabel:setPosition(188, 35)
	self.gameOverLabel:setScale(3)
	
	self.returnButton = TextField.new(nil, "return to menu")
	self:addChild(self.returnButton)
	self.returnButton:setTextColor(0xff0000)
	self.returnButton:setPosition(174, 300)
	self.returnButton:setScale(3)
	
	local function goMenu(button, event)
		if self.returnButton:hitTestPoint(event.touch.x, event.touch.y) then
			changeToScreen("menu")
		end	
	end
	
	self.returnButton:addEventListener(Event.TOUCHES_END, goMenu, self.returnButton)
	
	
	
 end
 
 
 
function GameOverScreen:start()

	if self.showScore then
		local scoreFile = io.open("|D|score.txt", "r")  --> open text.txt in documents directory to read
		local currentHighScore = scoreFile:read("*all")             --> read whole file
		scoreFile:close()
		self.scoreLabel:setText("New Highscore: " .. currentHighScore)
		print(self.showScore)
	end
	
end

function GameOverScreen:pause()

end
 
 
	
	