

Zombie = Core.class(Shape)

--Init initialisiert die zombie-Werte wie ein Konstruktor.
function Zombie:init(type, direction)

	--picture = Bitmap.new(Texture.new("WAWBackGround.png"))

    local function shot(zombie, event)
		if zombie:hitTestPoint(event.touch.x, event.touch.y) then
			zombie.alive = false
		end
	end

	
	if direction == "left" then
		self.xdirection = 1
	end
	
	if direction == "right" then
		self.xdirection = -1
	end



	if type == "soldier" then
		self.width = 50
		self.height = 50
	end
	
	if type == "general" then
		self.width = 75
		self.height = 100
	end
	
	
	local yPos = 320 - self.height
	 
	local xPos = 0
	
	if direction == "left" then
		 xPos  = - self.width
	elseif direction == "right" then
		 xPos = 480
	end
	
	
	self:setPosition(xPos, yPos)
	self.alive = true

	self:addEventListener(Event.TOUCHES_END, shot, self)

end



	
--Draw zeichnet den Zombie.
function Zombie:draw()
	self:clear()
	self:beginPath()

	self:setFillStyle(Shape.SOLID, 0xff0000)
	self:setLineStyle(1, 0x000000)

	self:moveTo(0,0)
	self:lineTo(0,self.height)
	self:lineTo(self.width,self.height)
	self:lineTo(self.width,0)
	self:lineTo(0,0)
	
	
	self:endPath()
	
	
end

--Update bewegt den Zombie.
function Zombie:update()

    

    local xspeed = 1.9
	
	local oldX = self:getX()
    
    local newX = oldX + (self.xdirection * xspeed )
	
	if newX > (SCREEN_WIDTH + self.width + 1) then  
		self.alive = false
		print("zombie ist tot")
	end
	

	self:setX(newX)
    
	
end
