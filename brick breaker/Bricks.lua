Bricks = Class{}

function Bricks:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.isCollide = false
end

function Bricks:collides(ball)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > ball.x + ball.width or ball.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > ball.y + ball.height or ball.y > self.y + self.height then
        return false
    end 
    
        self.isCollide = true
    return true
end

function Bricks:update(dt)
   
end


function Bricks:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end