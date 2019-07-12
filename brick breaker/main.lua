
push = require 'push'

Class = require 'class'

require 'Ball'

require 'Paddle'

require 'Bricks'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
local background = love.graphics.newImage('background.png')
PADDLE_SPEED = 150

local bricks = {}

lastWidth = 40

local count1 = 6


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
   
for i = 1,count1
do 
if i > 1 then
  lastWidth = bricks[i-1].x + 60
  end
  table.insert(bricks, Bricks(lastWidth,(VIRTUAL_HEIGHT/2 - 10), 50, 5))
end

    math.randomseed(os.time())
      
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
        
    })
  

    playerX = Paddle(VIRTUAL_WIDTH/2-24 ,VIRTUAL_HEIGHT-20,50,5)
    
    
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT -28, 6, 6)

end

function love.update(dt)
  
  for i = 1,count1 do
 if bricks[i]:collides(ball) then
    if count1 >= 1 then
   count1 = count1 - 1
end
   
   ball.dy = ball.dy
            ball.y = bricks[i].y+bricks[i].height

            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 0 then
                ball.dy = math.random(100, 150)
            else
                ball.dy = -math.random(100, 150)
            end
   
   end
 
  end
  
  if ball:collides(playerX) then
            ball.dy = ball.dy  * 1.03
            ball.y = playerX.y - 5
            
        if ball.x < playerX.x + (playerX.width / 2) and playerX.dx < 0 then
            ball.dx = -50 + -(8 * (playerX.x + playerX.width / 2 - ball.x))
        
        -- else if we hit the paddle on its right side while moving right...
        elseif ball.x > playerX.x + (playerX.width / 2) and playerX.dx > 0 then
            ball.dx = 50 + (8 * math.abs(playerX.x + playerX.width / 2 - ball.x))
        end

            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 0 then
                ball.dy = math.random(100, 150)
            else
                ball.dy = -math.random(100, 150)
                
            end
        end

        -- detect upper and lower screen boundary collision and reverse if collided
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        -- -4 to account for the ball's size
        if ball.x >= VIRTUAL_WIDTH - 6 then
            ball.x = VIRTUAL_WIDTH- 6
            ball.dx = -ball.dx
        end
        
        if ball.x <= 0 then
          ball.x = 0
          ball.dx = -ball.dx
        end
    
    if love.keyboard.isDown('a') then
      playerX.dx = -PADDLE_SPEED
      
    elseif love.keyboard.isDown('d') then
      playerX.dx = PADDLE_SPEED
    else
        playerX.dx = 0
    end
    
    for j, brick in pairs(bricks) do
           if brick.isCollide == true then
        table.remove(bricks, j)
    end
end
    
    if gameState == 'play' then
        ball:update(dt)
        playerX:update(dt)
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
            ball:reset()
            Paddle:reset()
        end
    end
end


 function love.draw()

     push:apply('start')
     love.graphics.draw(background, 0, 0)
     if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end
     
     for k, brick in pairs(bricks) do
 
        brick:render()

    end
    playerX:render()
    ball:render()
    
    push:apply('end')
end