piles = {{}};
pileCount = 0;

function piles.AddPile(_newPile)
  pileCount = pileCount + 1;
  piles[1][pileCount] = _newPile;
end

function piles.GetTableSize(_table)
  local size = 0;
  for _ in pairs(_table) do 
    size = size + 1;
  end
  return size
end

function piles.GetPilesSize()
  local size = 0;
  for _ in pairs(piles[1]) do 
    size = size + 1;
  end
  return size
end

function piles.AddToPile(_pile, _value)
  _pile[piles.GetTableSize(_pile)] = _value;
end

function piles.SplitPile(_pile, _amount)
  piles.AddPile(piles[1][_pile] - _amount);
  piles[1][_pile] = _amount;
end

function piles.PrintTable(_table, _tableSize)
  for key,val in pairs(_table) do
    io.write(" | ");
    io.write(val);
  end
  print(" | ");
end

function piles.PrintPiles()
  for key,val in pairs(piles[1]) do
    io.write(" | ");
    io.write(val);
  end
  print(" | ");
end

function piles.GetValidPileNumber()
  local input = -1;
  while (piles.IsValidPileNumber(input) == false) do
    io.write("Pile To Split: ");
    input = tonumber(io.read());
  end
  return input;
end

function piles.IsValidPileNumber(_pileNumber)
  if _pileNumber == nil or piles[1][_pileNumber] == nil then
    return false;
  elseif _pileNumber <= pileCount and _pileNumber >= 1 and piles[1][_pileNumber] > 2 then
    return true;
  else
    return false;
  end
end

function piles.GetValidSplitAmount(_pileNumber)
  local input = -1;
  while (piles.IsValidSplitAmount(_pileNumber, input) == false) do
    io.write("Split Amount: ");
    input = tonumber(io.read());
  end
  return input;
end

function piles.IsValidSplitAmount(_pileNumber, _splitAmount)
  if piles[1][_pileNumber] == nil or _splitAmount == nil then
    return false;
  elseif piles[1][_pileNumber] > _splitAmount
    and _splitAmount >= 1
    and piles[1][_pileNumber] > 2
    and (piles[1][_pileNumber] - _splitAmount) ~= _splitAmount then
    return true;
  else
    return false;
  end
end

function piles.CanSplitAnyPile()
local canSplitAnyPile = false
  for key,val in pairs(piles[1]) do
    if piles.IsValidPileNumber(key) == true then
      canSplitAnyPile = true;
    end
  end
  return canSplitAnyPile;
end

function piles.GetRandomPile()
  local validPiles = {};
  for key,val in pairs(piles[1]) do
    if piles.IsValidPileNumber(key) then
      piles.AddToPile(validPiles, key);
    end
  end
  
  randomIndex = math.random(0, piles.GetTableSize(validPiles) - 1);
  return validPiles[randomIndex];
end

function piles.GetRandomSplitAmount(_pile)
  local validSplitAmounts = {};
  local splitAmount = 1;
  while splitAmount < piles.GetPilesSize() do
    splitAmount = splitAmount + 1;
    if piles.IsValidSplitAmount(_pile, splitAmount) then
        piles.AddToPile(validSplitAmounts, splitAmount);
    end
  end
  
  randomIndex = math.random(0,  piles.GetTableSize(validSplitAmounts) - 1);
  return validSplitAmounts[randomIndex];
end

return piles;