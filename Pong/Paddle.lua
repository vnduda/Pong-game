--[[
  Representa a barra que podemos mover para baixo e para cima.
  Usada no programa main para desviar a bola de volta para o adversário
]]

Paddle = Class{}

--[[

 A função `init` em nossa classe é chamada apenas uma vez, quando o objeto é criado
 pela primeira vez. Usado para configurar todas as variáveis ​​na classe e prepará-lo para uso.
 Nossa barra deve levar um X e um Y, para posicionamento, bem como largura e altura para suas dimensões.
]]
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
  -- calcula a posição Y atual quando pressiona para que não entremos nos negativos;
  -- o cálculo do movimento é simplesmente a nossa velocidade de pás anteriormente definida dimensionada por dt
  if self.dy < 0 then
      self.y = math.max(0, self.y + self.dy * dt)
  -- usamos math.min para garantir que não iremos mais longe que a parte inferior da tela menos a altura da raquete
  -- (ou então ela ficará parcialmente abaixo, já que a posição é baseada no canto superior esquerdo)
  else
      self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

--[[
  Para ser chamado pela nossa função principal em `love.draw`, idealmente. Usa a função `rectangle` do LÖVE2D,
  que recebe um modo de desenho como o primeiro argumento, bem como a posição e as dimensões do retângulo.
  Para mudar a cor, deve-se chamar `love.graphics.setColor`.
  A partir da versão mais recente do LÖVE2D, podemos até desenhar retângulos arredondados!
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
