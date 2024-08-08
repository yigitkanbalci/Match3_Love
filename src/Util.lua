function GenerateTileQuads(atlas)
    local tiles = {}

    local x = 0
    local y = 0

    local counter = 1

    -- 9 rows of tiles
    for row = 1, 9 do
        
        -- two sets of 6 cols, different tile varietes
        for i = 1, 2 do
            tiles[counter] = {}
            
            for col = 1, 6 do
                table.insert(tiles[counter], love.graphics.newQuad(
                    x, y, 32, 32, atlas:getDimensions()
                ))
                x = x + 32
            end

            counter = counter + 1
        end
        y = y + 32
        x = 0
    end

    return tiles
end

function GenerateBoard(len)
    local tiles = {}

    for y = 1, 8 do
        table.insert(tiles, {})

        for x = 1, 8 do
            table.insert(tiles[y], {
                x = (x - 1) * 32,
                y = (y - 1) * 32,

                gridX = x,
                gridY = y,
                
                tile = math.random(len)
            })
        end
    end

    return tiles
end

function DrawBoard(board, xOffset, yOffset)
    for y = 1, 8 do
        for x = 1, 8 do
            local tile = board[y][x]

            love.graphics.draw(tileSprite, tileQuads[tile.tile], 
            tile.x + xOffset, tile.y + yOffset)

            if highlightedTile then
                if tile.gridX == highlightedX and tile.gridY == highlightedY then
                    love.graphics.setColor(1,1,1,128/255)
                    love.graphics.rectangle('fill', tile.x + xOffset, tile.y + yOffset, 32, 32, 4)
                    love.graphics.setColor(1,1,1,1)
                end
            end
        end
    end

    love.graphics.setColor(1, 0, 0, 234/255)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', selectedTile.x + xOffset, selectedTile.y + yOffset, 32, 32, 4)

end