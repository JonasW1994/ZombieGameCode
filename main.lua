SCREEN_WIDTH = application:getContentWidth()
SCREEN_HEIGHT = application:getContentHeight()

 local currentScreen = nil

function changeToScreen(screen)
	
		if screen == "menu" then
			newScreen = menuScreen
		end
		
		if screen == "game" then
			newScreen = gameScreen
		end
		
		if screen == "gameOver" then
			newScreen = gameOver
		end
		
		if currentScreen then
			stage:removeChild(currentScreen)
			currentScreen:pause()
			
			
		end
		stage:addChild(newScreen)
		newScreen:start()
		currentScreen = newScreen
	
end




menuScreen = Menu.new()

gameOver = GameOverScreen.new()

changeToScreen("menu")






