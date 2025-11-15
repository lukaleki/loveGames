local score = 0

function love.load()
    require "mainCharacter"
    require "enemyUnit"

    mainCharacter.load()  
    enemyUnit.load() 

    enemyUnit.spawn(300, 50)
    enemyUnit.spawn(400, 50)
    enemyUnit.spawn(200, 100)

    love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.update(dt)
    mainCharacter.update(dt) 
    enemyUnit.update(dt)   
    score = score + 1

    checkCollisions()
end

function love.draw()
    mainCharacter.draw()

    time = math.floor(love.timer.getTime())
    standardPadding = 10

    scoreText = "SCORE: " .. score
    font = love.graphics.getFont()
    scoreTextWidth = (font:getWidth(scoreText)) * 2

    timeText = "TIME: " .. time
    TimeTextWidth = (font:getWidth(timeText)) * 2

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    scoreTextX = standardPadding
    scoreTextY = standardPadding

    timeTextX = windowWidth - TimeTextWidth - standardPadding
    timeTextY = standardPadding

    love.graphics.print(scoreText, scoreTextX, scoreTextY, 0, 2 )
    love.graphics.print(timeText , timeTextX, timeTextY, 0, 2)
end


function checkCollisions()
    local playerRadius = 3
    local enemyRadius = 3
    local collisionRadiusSumSquared = (playerRadius + enemyRadius) * (playerRadius + enemyRadius)

    if player.invincible == false then
        
        for i = #enemyUnit.enemies, 1, -1 do
            local e = enemyUnit.enemies[i] 

            local dx = player.x - e.x
            local dy = player.y - e.y
            local distanceSquared = (dx * dx) + (dy * dy)

            if distanceSquared < collisionRadiusSumSquared then
                
                player.health = player.health - e.dmg
                if player.health < 0 then
                    player.x = 32
                    player.y = 32
                    player.health = 100
                end
                
                player.invincible = true
                player.invincibleTimer = player.iframeDuration

                break 
            end
        end
    end
end
