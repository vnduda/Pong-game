--[[ 
    Pong - 1
    "The Low-Res Update"
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

    -- linha reorganizada (agora também usando uma altura e largura virtuais)
    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    -- termina a renderização
    push:apply('end')
end