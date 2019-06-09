--[[
    Pong - 4
    "The Ball Update"
]]

-- push é uma biblioteca que nos permite desenhar nosso jogo
-- em uma resolução mais virtual, fornecendo uma estética retrô
-- https://github.com/Ulydev/push
push = require 'push'

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

    -- fonte maior para desenhar o placar
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- define smallFont para todo objeto
    love.graphics.setFont(smallFont)

    -- substitui a chamada love.window.setMode.
    -- essa nova chamada não leva em consideração a dimensão da janela real
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

  -- inicializa o placar e acompanha para mostrar o vencedor
  player1Score = 0
  player2Score = 0

  -- posições das barras no eixo Y (elas só podem subir ou descer)
  player1Y = 30
  player2Y = VIRTUAL_HEIGHT - 50

  -- variáveis de velocidade e posição para a bola quando o jogo inicia
  ballX = VIRTUAL_WIDTH / 2 - 2
  ballY = VIRTUAL_HEIGHT / 2 - 2

  -- função math.random retorna um valor aleatório entre o número da esquerda e da direita
  ballDX = math.random(2) == 1 and 100 or -100
  ballDY = math.random(-50, 50)

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
      -- adiciona velocidade negativa na barra ao Y atual dimensionado por DeltaTime (dt)
      -- agora nós "apertamos" nossa posição entre os limites da tela
      -- função math.max retorna o maior entre dois valores; 0 e o jogador Y
      -- irá garantir que não iremos acima dele
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
      -- adiciona velocidade positiva na barra ao Y atual dimensionado por DeltaTime (dt)
      -- math.min retorna o menor de dois valores; parte inferior da borda menos a altura da barra
      -- também vai garantir que não iremos abaixo dele
      player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
  end

  -- movimento do player 2
  if love.keyboard.isDown('up') then
      -- adiciona velocidade negativa na barra ao Y atual dimensionado por DeltaTime (dt)
      player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
      -- adiciona velocidade positiva na barra ao Y atual dimensionado por DeltaTime (dt)
      player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
  end

  -- atualiza nossa bola baseada no DX e DY apenas se estivermos no estado de jogar
  -- dimensiona a velocidade por dt para que o movimento seja independentemente do framerate
  if gameState == 'play' then
      ballX = ballX + ballDX * dt
      ballY = ballY + ballDY * dt
  end
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

            -- inicia a bola no meio da tela
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            -- da um valor inicial aleatório a velocidade x e y da bola
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
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

    -- Aqui começaremos a desenhar as barras , que são retângulos na tela em certos pontos
    -- assim como a bola

    -- renderiza a primeira barra, do lado esquerdo
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- renderiza a segunda barra, lado direito
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- renderiza a bola no centro
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- termina a renderização
    push:apply('end')
end
