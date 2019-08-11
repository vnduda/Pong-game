--[[
  Representa a bola que irá bater para frente e para trás entre as barras
  e paredes até que passe do limite demarcado, marcando ponto para o adversário
]]

Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- essas variáveis servem para manter o controle da velocidade nos eixos X e Y
    -- já que a bola pode se mover em duas dimensões

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
end


function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end 
    return true
end

  -- Coloca a bola no meio da tela, com uma velocidade inicial random
  -- nos dois eixos
function Ball:reset()
      self.x = VIRTUAL_WIDTH / 2 - 2
      self.y = VIRTUAL_HEIGHT / 2 - 2
      self.dy = math.random(2) == 1 and -100 or 100
      self.dx = math.random(-50, 50)
  end

 --  Aplica velocidade a posição, escalada por deltaTime
 function Ball:update(dt)
     self.x = self.x + self.dx * dt
     self.y = self.y + self.dy * dt
 end

 function Ball:render()
     love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
 end
