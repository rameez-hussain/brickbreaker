
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 550
VIRTUAL_HEIGHT = 361

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
  
 function love.draw()
    
    push:apply('start')

    
    love.graphics.printf('Brick breaker!', 0, 0, VIRTUAL_WIDTH, 'center')

    
    push:apply('end')
end