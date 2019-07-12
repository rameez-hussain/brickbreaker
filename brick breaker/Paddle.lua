

Paddle = Class{}


function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
end

function Paddle:reset()
    self.x = VIRTUAL_WIDTH/2-24
    self.y = VIRTUAL_HEIGHT-20
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Paddle:update(dt)

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
        
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
        
    end
end


function Paddle:render()
    love.graphics.rectangle('line',self.x, self.y, self.width, self.height)
end