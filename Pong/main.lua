--[[
    Pong - 5
    "The Class Update"
]]

-- push é uma biblioteca que nos permite desenhar nosso jogo
-- em uma resolução mais virtual, fornecendo uma estética retrô
-- https://github.com/Ulydev/push
push = require 'push'

-- a biblioteca Class que usamos permite representar qualquer coisa do nosso
-- jogo em forma de código, ao invés de acompanhar muitas variáveis e métodos
-- diferentes
Class = require 'class'

-- nossa classe Paddle, que armazena posição e dimensão para cada barra
-- e a lógica para renderiza-las
require 'Paddle'

-- nossa classe Ball, que não é muito diferente de uma estrutura de barras
-- mas que funcionará de maneira muito diferente
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- velocidade que vamos mover as barras
PADDLE_SPEED = 200

--[[
    Irá rodar quando o jogo 1 começar, apenas uma vez.
    love.load() é usado para inicializar o jogo no estado
    inicial da execução do programa
]]
function love.load()
    -- evita o embaçamento do texto, deixando ele mais pixelado
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- gera o RNG para que as chamadas sejam sempre aleatórias
    math.randomseed(os.time())

    -- fonte que dá mais aspecto de retrô para qualquer texto
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- define smallFont para todo objeto
    love.graphics.setFont(smallFont)

    -- substitui a chamada love.window.setMode.
    -- essa nova chamada não leva em consideração a dimensão da janela real
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

  -- inicializa as barras dos jogadores, faz delas globais, para servem
  -- detectadas por outras funções e módulos
  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

  -- inicia nossa bola no centro da tela
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  -- variável de estado do jogo que é usada para fazer a transição entre diferentes
  -- partes do jogo (usada no início, menus, jogo principal etc)
  -- usaremos para determinar o comportamento durante a renderização e atualização
  gameState = 'start'
end

--[[
    Executa cada frame, com 'dt' passado, o nosso delta em segundos,
    desde o último frame, que o LOVE2D fornece
]]
function love.update(dt)
  -- movimento do player 1
  if love.keyboard.isDown('w') then
      player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
      player1.dy = PADDLE_SPEED
  else
      player1.dy = 0
  end

  -- movimento do player 2
  if love.keyboard.isDown('up') then
      player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
      player2.dy = PADDLE_SPEED
  else
      player2.dy = 0
  end

  -- atualiza nossa bola baseada no DX e DY apenas se estivermos no estado de jogar
  -- dimensiona a velocidade por dt para que o movimento seja independentemente do framerate
  if gameState == 'play' then
      ball:update(dt)
  end

    player1:update(dt)
    player2:update(dt)
end

--[[
    Manipulação de teclado, chamada por LÖVE2D em cada quadro
    love.keypressed() função de retorno de chamada que é executada
    sempre que pressionamos uma tecla
]]
function love.keypressed(key)
    if key == 'escape' then
        -- love.event.quit() finaliza a aplicação
        love.event.quit()
    -- se pressionarmos enter no estado inicial do jogo, entraremos em modo de jogo
    -- durante o modo de jogo, a bola se moverá em uma direção aleatória
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- novo método de reset da bola
            ball:reset()
        end
    end
end

--[[
    Chamada após a atualização by LÖVE2D, usado para desenhar qualquer
    coisa na tela, atualizado ou não.

    love.draw() chamada de cada quadro por LÖVE
    após atualização para desenhar coisas na tela uma vez que eles mudaram

    love.graphics.printf() função de impressão versátil que pode alinhar texto à esquerda,
    à direita ou ao centro na tela.
]]
function love.draw()
    -- começa a renderização na resolução virtual
    push:apply('start')

    -- "limpa" a tela com uma cor específica
    -- nesse caso, com uma cor semelhante ao Pong original
    love.graphics.clear(40, 45, 52, 255)

    -- agora desenha o texto de boas vindas no topo da tela
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- renderiza as barras, agora usando o método de sua classe
    player1:render()
    player2:render()

    -- renderiza a bola, agora usando o método de sua classe
    ball:render()

    -- termina a renderização
    push:apply('end')
end
