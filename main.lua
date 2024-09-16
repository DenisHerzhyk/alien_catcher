-- sprite data
local viruses = {}
local bombs = {}
local diamonds = {}
local menuAliens = {}
local scoreAlienImage = love.graphics.newImage('static/virus.png')
-- amount of each sprite
local numVirus = 10
local numAliens = 10
local numBombs = 3
local numDiamonds = 1
-- sprite size and speed
local speed = 230
local size = 0.09
-- total socre
local score = 0
-- text info
local font = love.graphics.newFont(35)
local fontMenu = love.graphics.newFont(20)
local fontPoints = love.graphics.newFont(23)
local fontButton = love.graphics.newFont(28)
local whiteColor = {1, 1, 1} 
local blackColor = {0, 0, 0}
local blackЕransparentColor = {0, 0, 0, 0.5}
local blueColor = {68/255, 140/255, 255/255}
local yellowColor = {245/255, 240/255, 19/255}
local greenColor = {0, 1, 0}
local redColor = {1, 0, 0}
local totalColor = whiteColor
local colorTimer = 0
local colorDuration = 3
local colorChanged = false
-- timer
local timeLeft = 10
local timerText = "00:"
-- menu-button info
local buttonText = "Restart Game"
local buttonWidth = 300
local buttonHeight = 70
local buttonX = (love.graphics.getWidth() - buttonWidth) / 2
local buttonY = (love.graphics.getHeight() - buttonHeight) / 2
local isButtonVisible = true
-- menu text info
local menuText = "Total Score: "
local menuWidth = 300
local menuHeight = 40
local menuX = (love.graphics.getWidth() - menuWidth) / 2
local menuY = 40
-- freezing info
local freezeDuraction = 3
local timeFreeze = 0
local isDiamond = false
-- background image
local background

function love.load() 
    local getVirus = love.graphics.newImage('static/virus.png')
    local getBomb = love.graphics.newImage('static/bomb.png')
    local getDiamond = love.graphics.newImage('static/diamond.png')
    background = love.graphics.newImage('static/background.png')
    
    for i=1, numVirus do
        local virus = {
            x = math.random(40, love.graphics.getWidth()-40),
            y = math.random(-700, -30),
            speed = math.random(speed, speed + math.random(0,50)),
            width = getVirus:getWidth() * size, 
            height = getVirus:getHeight() * size,
            scale = size + math.random() * 0.05,
            image = getVirus,
            pointText = "+1", 
            pointTimer = 0.15,
            isPointVisible = false
        }
        table.insert(viruses, virus)
    end

    for i=1, numAliens do 
        local alien = {
            x = math.random(40, love.graphics.getWidth()-40),
            y = math.random(50, love.graphics.getHeight()-40),
            image = getVirus,
            scale = size + math.random() * 0.3
        }
        table.insert(menuAliens, alien)
    end

    for i=1, numBombs do
        local bomb = {
            x = math.random(40, love.graphics.getWidth()-40),
            y = math.random(-700, -30),
            speed = math.random(speed, speed + math.random(0,50)),
            width = getBomb:getWidth() * size,
            height = getBomb:getHeight() * size,
            scale = size + math.random() * 0.05,
            image = getBomb,
            pointText = "-10", 
            pointTimer = 0.15,
            isPointVisible = false
        }
        table.insert(bombs, bomb)
    end

    for i=1, numDiamonds do
        local diamond = {
            x = math.random(40, love.graphics.getWidth()-40),
            y = math.random(-3000, -800),
            speed = math.random(speed, speed + math.random(0, 50)),
            width = getDiamond:getWidth() * size,
            height = getDiamond:getHeight() * size,
            scale = size + math.random() * 0.05,
            image = getDiamond,
            pointText = "+0", 
            pointTimer = 0.15,
            isPointVisible = false
        }
        table.insert(diamonds, diamond)
    end
end

function love.update(dt)
    if isDiamond then
        timeFreeze = timeFreeze + dt

        if timeFreeze > freezeDuraction then
            timeFreeze = 0
            isDiamond = false
        end
    else
        if timeLeft > 0 then
            timeLeft = timeLeft - dt
            if timeLeft > 10 then
                timerText = "00:"
            elseif timeLeft < 9 and timeLeft > 0 then
                timerText = "00:0"
            end
        else
            timeLeft = 0
            isButtonVisible = true
        end
        for i, virus in ipairs(viruses) do
            virus.y = virus.y + virus.speed * dt
            if virus.isPointVisible then
                virus.pointTimer = virus.pointTimer - dt

                if virus.pointTimer <= 0 then
                    virus.isPointVisible = false
                    virus.pointTimer = 0.15
                    virus.x = math.random(40, love.graphics.getWidth()-40)
                    virus.y = math.random(-700, -30)
                end
            else
                if virus.y > love.graphics.getHeight() + 25 then
                    virus.x = math.random(40, love.graphics.getWidth()-40)
                    virus.y = math.random(-700, -30)
                end
            end
        end

        for i, bomb in ipairs(bombs) do
            bomb.y = bomb.y + bomb.speed * dt
            
            if bomb.isPointVisible then 
                bomb.pointTimer = bomb.pointTimer - dt

                if bomb.pointTimer <= 0 then
                    bomb.isPointVisible = false
                    bomb.pointTimer = 0.15
                    bomb.x = math.random(40, love.graphics.getWidth()-40)
                    bomb.y = math.random(-700, -30)
                end
            else
                if bomb.y > love.graphics.getHeight() + 25 then
                    bomb.x = math.random(40, love.graphics.getWidth()-40)
                    bomb.y = math.random(-700, -30)
                end
            end
        end

        for i, diamond in ipairs(diamonds) do 
            diamond.y = diamond.y + diamond.speed * dt

            if diamond.isPointVisible then
                diamond.pointTimer = diamond.pointTimer - dt
                
                if diamond.pointTimer <= 0 then
                    diamond.isPointVisible = false
                    diamond.pointTimer = 0.15
                    diamond.x = math.random(40, love.graphics.getWidth()-40)
                    diamond.y = math.random(-3000, -800)
                end
            else
                if diamond.y > love.graphics.getHeight() + 25 then
                    diamond.x = math.random(40, love.graphics.getWidth()-40)
                    diamond.y = math.random(-3000, -800)
                end
            end
        end
    end

    if colorChanged then
        colorTimer = colorTimer + dt

        if colorTimer > colorDuration then
            totalColor = whiteColor
            colorChanged = false
            colorTimer = 0
        end
    end
end

function love.mousepressed(mx, my, button)
    if button == 1 then
        if isButtonVisible and mx>=buttonX and mx<=buttonX+buttonWidth and my>=buttonY and my<=buttonY+buttonHeight then
            timeLeft = 59
            score = 0
            isButtonVisible = false
            for i, virus in ipairs(viruses) do
                virus.x = math.random(40, love.graphics.getWidth()-40)
                virus.y = math.random(-700, -30)
            end
            for i, bomb in ipairs(bombs) do
                bomb.x =math.random(40, love.graphics.getWidth()-40)
                bomb.y = math.random(-700, -30)
            end
            for i, diamond in ipairs(diamonds) do
                diamond.x = math.random(40, love.graphics.getWidth()-40)
                diamond.y = math.random(-3000, -800)
            end
        end
        for i, virus in ipairs(viruses) do
            if mx>=virus.x and mx<=virus.x+virus.width and my>=virus.y and my<=virus.y+virus.height then
                score = score + 1
                virus.isPointVisible = true
            end
        end

        for i, bomb in ipairs(bombs) do
            if mx>=bomb.x and mx<=bomb.x+bomb.width and my>=bomb.y and my<=bomb.y+bomb.height then
                if score - 10 <= 0 then
                    score = 0
                else 
                    score = score - 10
                end
                colorChanged = true
                totalColor = redColor
                bomb.isPointVisible = true
            end
        end

        for i, diamond in ipairs(diamonds) do
            if mx>=diamond.x and mx<=diamond.x+diamond.width and my>=diamond.y and my<=diamond.y+diamond.height then
                isDiamond = true
                colorChanged = true
                totalColor = blueColor
                diamond.isPointVisible = true
            end
        end
    end
end 


function love.draw()
    love.graphics.draw(background, 0, 0)
    
    love.graphics.setColor(greenColor)
    love.graphics.setFont(fontMenu)
    for i, virus in ipairs(viruses) do
        love.graphics.draw(virus.image, virus.x, virus.y, 0, virus.scale, virus.scale)
        if virus.isPointVisible then
            love.graphics.setColor(yellowColor)
            love.graphics.print(virus.pointText, virus.x + 40, virus.y - 20)
            love.graphics.setColor(whiteColor)
        end
    end

    love.graphics.setColor(whiteColor)
    for i, bomb in ipairs(bombs) do
        love.graphics.draw(bomb.image, bomb.x, bomb.y, 0, bomb.scale, bomb.scale)
        if bomb.isPointVisible then
            love.graphics.setColor(redColor)
            love.graphics.print(bomb.pointText, bomb.x + 40, bomb.y - 20)
            love.graphics.setColor(whiteColor)
        end
    end

    for i, diamond in ipairs(diamonds) do
        love.graphics.draw(diamond.image, diamond.x, diamond.y, 0, diamond.scale, diamond.scale)
        if diamond.isPointVisible then
            love.graphics.setColor(blueColor)
            love.graphics.print(diamond.pointText, diamond.x + 40, diamond.y - 20)
            love.graphics.setColor(whiteColor)
        end
    end

    love.graphics.setFont(font)
    love.graphics.setColor(yellowColor)
    love.graphics.print(timerText .. math.ceil(timeLeft), 30, 20)
    love.graphics.rectangle('line', 10, 15, 140, 50, 20, 20)

    love.graphics.setFont(font)
    love.graphics.draw(scoreAlienImage, love.graphics.getWidth() - 110, 15, 0, size, size)
    love.graphics.setColor(totalColor)
    love.graphics.print(score, love.graphics.getWidth() - 60, 20)

    if isButtonVisible then
        love.graphics.setColor(blackColor)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        
        love.graphics.setColor(greenColor)
        for i, alien in ipairs(menuAliens) do
            love.graphics.draw(alien.image, alien.x, alien.y, 0, alien.scale, alien.scale)
        end

        love.graphics.setColor(blackЕransparentColor)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(whiteColor)
        love.graphics.rectangle('fill', (love.graphics.getWidth() - buttonWidth) / 2, (love.graphics.getHeight() - buttonHeight)/2, buttonWidth, buttonHeight, 20, 20)
        love.graphics.setFont(fontButton)
        love.graphics.setColor(blackColor)
        love.graphics.printf(buttonText, buttonX, buttonY + (buttonHeight / 4), buttonWidth, 'center') 
        love.graphics.setFont(fontMenu)
        love.graphics.setColor(yellowColor)
        love.graphics.printf(menuText .. score, menuX, menuY + (menuHeight / 4) - 10, menuWidth, 'center')
        love.graphics.draw(scoreAlienImage, love.graphics.getWidth()/2, 10, 0, 0.05, 0.05)
    end
end