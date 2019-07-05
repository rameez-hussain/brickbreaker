
push = require 'push'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    math.randomseed(os.time())
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
  
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT - 30
    
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)
    
    gameState = 'start'
    
end

function love.update(dt)
  
  if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
    
    if ballY <= 0 then
            ballY = 0
            ballDY = -ballDY
        end
        
        -- -4 to account for the ball's size
        if ballY >= VIRTUAL_HEIGHT - 4 then
            ballY = VIRTUAL_HEIGHT - 4
            ballDY = -ballDY
        end
        
         if ballX <= 0 then
            ballX = 0
            ballDX = -ballDX
        end
        
        -- -4 to account for the ball's size
        if ballX >= VIRTUAL_HEIGHT - 10 then
            ballX = VIRTUAL_HEIGHT - 10
            ballDX = -ballDX
        end
  
end
  
 function love.keypressed(key)
    
    if key == 'escape' then
       
        love.event.quit()
    
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            
            
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT - 30
            
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

 function love.draw()
    
    push:apply('start')

    love.graphics.printf('Brick breaker!', 0, 0, VIRTUAL_WIDTH, 'center')

    love.graphics.rectangle('fill', ballX, ballY, 6,6)
    
    push:apply('end')
end