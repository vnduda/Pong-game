--[[
    Pong - 2
    "The Rectangle Update"
]]

-- push é uma biblioteca que nos permite desenhar nosso jogo
-- em uma resolução mais virtual, fornecendo uma estética retrô
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    Irá rodar quando o jogo 1 começar, apenas uma vez.
    love.load() é usado para inicializar o jogo no estado
    inicial da execução do programa
]]
function love.load()
    -- evita o embaçamento do texto, deixando ele mais pixelado
    love.graphics.setDefaultFilter('nearest', 'nearest')

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
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

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
