SplatterEffect = Core.class(Sprite)

function getDistance(aX, aY, bX, bY)
	dX = bX - aX
	dY = bY - aY
	
	distance = math.sqrt((dX * dX) + (dY * dY))
	
	return distance
end

function SplatterEffect:init(x, y, radius, splashCount, parent)
	print("Splatter: " .. x .. " " .. y)
	self.bloodSplashs = {}
	
	self:setPosition(x, y)
	
	self.bloodSplashTex = Texture.new("splatter.png")
	
	for i = 0, splashCount, 1 do
		local bloodSplash = Bitmap.new(self.bloodSplashTex)
		local posX = math.random(-radius, radius)
		local posY = math.random(-radius, radius)
		local distance = getDistance(0, 0, posX, posY)
		local scale = 3.0 / (distance * 0.1)
		scale = math.min(scale, 1.5)
		bloodSplash:setPosition(posX, posY)
		bloodSplash:setScale(scale)
		self:addChild(bloodSplash)
		table.insert(self.bloodSplashs, bloodSplash)
	end
	
	self.lifeTimer = Timer.new(650, 1)
	
	self.lifeTimer:addEventListener(Event.TIMER, self.remove, self)
	self.lifeTimer:start()
	
	parent:addChild(self)	
	

end

function SplatterEffect:remove()
	for i, splash in ipairs(self.bloodSplashs) do
		self:removeChild(splash)
	end
	
	self:removeFromParent()
end