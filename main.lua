-- IMPORTS

push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Bricks'
require 'Ball'

-- WINDOW SIZE

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
lastWidth = 20 
local background = love.graphics.newImage('background.png')
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

local bricksl1 = {}
local bricksl2 = {}
local bricksl3 = {}

PADDLE_SPEED = 200

function love.load()

for i = 1,5
do 
if i > 1 then
  lastWidth = bricksl1[i-1].x + 60
  end
table.insert(bricksl1, Bricks(lastWidth,(VIRTUAL_HEIGHT/2 - 10), 50, 5))

 end
    

love.graphics.setDefaultFilter('nearest', 'nearest')
	player = Paddle(10, VIRTUAL_HEIGHT-20, 20, 5)

ball = Ball(player.x/2 -2, player.y + 5, 4, 4)

flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

 push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
           canvas = false
    })
end

function love.keypressed(key)
	if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
    -- if we press enter during the start state of the game, we'll go into play mode
    -- during play mode, the ball will move in a random direction
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- ball's new reset method
            ball:reset()
        end
    end

end

function love.update(dt)

for i = 1,5 do
 if bricksl1[i]:collides(ball) then
   love.graphics.print("Collide")
   
   ball.dy = ball.dy
            ball.y = bricksl1[i].y+bricksl1[i].height

            -- keep velocity going in the same direction, but randomize it
            if ball.dy < 0 then
                ball.dy = math.random(100, 150)
            else
                ball.dy = -math.random(100, 150)
            end
   
   end
 
  end
 
 if ball:collides(player) then
            ball.dy = ball.dy
            ball.y = player.y - 5

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



           if ball.x <= 0 then
            ball.x = 0
            ball.dx = -ball.dx
        end


              -- -4 to account for the ball's size
        

        -- -4 to account for the ball's size
        if ball.x >= VIRTUAL_WIDTH - 4 then
            ball.x = VIRTUAL_WIDTH - 4
            ball.dx = -ball.dx
        end



	if love.keyboard.isDown('right') then

player.dx = PADDLE_SPEED 

elseif love.keyboard.isDown('left') then
	player.dx = -PADDLE_SPEED

else
	 player.dx = 0
end

 ball:update(dt)
	player:update(dt)
end

function love.draw()
push:start()
love.graphics.draw(background, 0, 0)
	    love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
         for k, brick in pairs(bricksl1) do
           if brick.isCollide == false then
        brick:render()
        end
        
    end
	    player:render()
	    ball:render()
push:finish()
end