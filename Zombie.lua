

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
	
	
	
	
	local yPos = SCREEN_WIDTH_LOGICAL - self.height
	 
	local xPos = 0
	
	if direction == "left" then
		 xPos  = - self.width
	elseif direction == "right" then
		 xPos = SCREEN_HEIGHT_LOGICAL
	end
	
	
	self:setPosition(xPos, yPos)
	self.alive = true

	self:addEventListener(Event.TOUCHES_END, shot, self)

end



	
--Draw zeichnet den Zombie.
function Zombie:draw()
	
	
	--self:clear()
	--self:beginPath()

	--self:setFillStyle(Shape.SOLID, 0xff0000)
	--self:setLineStyle(1, 0x000000)

	--self:moveTo(0,0)
	--self:lineTo(0,self.height)
	--self:lineTo(self.width,self.height)
	--self:lineTo(self.width,0)
	--self:lineTo(0,0)
	
	--self:endPath()
	
	
	
	
	
	
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
