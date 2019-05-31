--[[ 
    Pong - 0
    "The Day-0 Update"
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    Irá rodar quando o jogo 1 começar, apenas uma vez.
    love.load() é usado para inicializar o jogo no estado
    inicial da execução do programa
]]  
function love.load() 
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
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
    love.graphics.printf(
        'Oi pong!',
        0,
        WINDOW_HEIGHT / 2 -6,
        WINDOW_WIDTH,
        'center')
end