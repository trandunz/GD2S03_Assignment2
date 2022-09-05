piles = {}
pileCount = 0
function pile.AddPile(newPile)
    pileCount = pileCount + 1
    piles[pileCount] = newPile
end
return piles