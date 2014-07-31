

Zombie = Core.class(Sprite)
	
--Init initialisiert die zombie-Werte wie ein Konstruktor.
function Zombie:init(type, direction, speed)

	self.speed = speed
	self.type = type
	
	if  type == "general" then
		self.picture = Bitmap.new(Texture.new("zombie.png"))
		self:addChild(self.picture)
	end
	
	if  type == "soldier" then
		self.picture = Bitmap.new(Texture.new("zombie02.png"))
		self:addChild(self.picture)
	end
	
    local function shot(zombie, event)
		if zombie:hitTestPoint(event.touch.x, event.touch.y) then
			
			zombie.alive = false
			local killSound = Sound.new("shot.wav")
			local shotSound = Sound.new("gun.wav")
			shotSound:play()
			killSound:play()
			
			local effect = SplatterEffect.new(event.touch.x, event.touch.y, 70, 50, gameScreen)
			
			if zombie.type == "soldier" then
				effect:setScale(1.0)
			else
				effect:setScale(2.0)
			end
			if zombie.type == "general" then
				gameScreen:addScore("general")
			end
			if zombie.type == "soldier" then
				gameScreen:addScore("soldier")
			end
		end
	end

	
	if direction == "left" then
		self.xdirection = 1
	end
	
	if direction == "right" then
		self.xdirection = -1
	end


	
	
	self.width = self.picture:getWidth()
	self.height = self.picture:getHeight()
	
	
	
	
	local yPos = SCREEN_HEIGHT - self.height
	 
	local xPos = 0
	
	if direction == "left" then
		 xPos  = - self.width
	elseif direction == "right" then
		 xPos = SCREEN_WIDTH
	end
	
	
	self:setPosition(xPos, yPos)
	self.alive = true

	self:addEventListener(Event.TOUCHES_END, shot, self)

end

--Update bewegt den Zombie.
function Zombie:update()

	
	
		local xspeed = self.speed
		
		local oldX = self:getX()
		
		local newX = oldX + (self.xdirection * xspeed )
		
		if newX > (SCREEN_WIDTH + self.width + 1) then  
			self.alive = false
			print("zombie ist tot")
			gameScreen:addScore("fail")
			gameScreen.failCounter = gameScreen.failCounter + 1
		end
		
		
		

		self:setX(newX)
    
	
end
