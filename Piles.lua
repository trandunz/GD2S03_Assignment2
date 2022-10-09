-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : Piles.lua 
-- Description : Piles Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local piles = {{},pileCount = 0};

--
--  Adds a pile to the table of piles and increments the pile count
--
function piles.AddPile(_newPile)
  piles.pileCount = piles.pileCount + 1;
  piles[1][piles.pileCount] = _newPile;
end

--
--  Returns the size of a given table
--
function piles.GetTableSize(_table)
  local size = 0;
  for _ in pairs(_table) do 
    size = size + 1;
  end
  return size
end

--
--  Returns the size of the piles table
--
function piles.GetPilesSize()
  local size = 0;
  for _ in pairs(piles[1]) do 
    size = size + 1;
  end
  return size
end

--
--  add a value too the specified table
--
function piles.AddToPile(_pile, _value)
  _pile[piles.GetTableSize(_pile)] = _value;
end

--
--  Split the specified pile by the amount
--
function piles.SplitPile(_pile, _amount)
  piles.AddPile(piles[1][_pile] - _amount);
  piles[1][_pile] = _amount;
end

--
--  Print the specified table
--
function piles.PrintTable(_table, _tableSize)
  for key,val in pairs(_table) do
    io.write(" | ");
    io.write(val);
  end
  print(" | ");
end

--
--  Print the piles table
--
function piles.PrintPiles()
  for key,val in pairs(piles[1]) do
    io.write(" | ");
    io.write(val);
  end
  print(" | ");
end

--
--  Input loop for player pile input and returns the valid pile
--
function piles.GetValidPileNumber()
  local input = -1;
  while (piles.IsValidPileNumber(input) == false) do
    io.write("Pile To Split: ");
    input = tonumber(io.read());
  end
  return input;
end

--
--  returns true or false depending on if the pile number is valid
--
function piles.IsValidPileNumber(_pileNumber)
  -- If the pile number or the pile and the pile number is nil then return false
  if _pileNumber == nil or piles[1][_pileNumber] == nil then
    return false;
  elseif _pileNumber <= piles.pileCount and _pileNumber >= 1 and piles[1][_pileNumber] > 2 then
    return true;
  else
    return false;
  end
end

--
--  Input loop for player split input and returns the valid split amount
--
function piles.GetValidSplitAmount(_pileNumber)
  local input = -1;
  while (piles.IsValidSplitAmount(_pileNumber, input) == false) do
    io.write("Split Amount: ");
    input = tonumber(io.read());
  end
  return input;
end

--
--  returns true or false if the specified pile can be split by the specified amount
--
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

--
--  Checks if any of the piles can be split
--
function piles.CanSplitAnyPile()
  local canSplitAnyPile = false

  for key,val in pairs(piles[1]) do
    if piles.IsValidPileNumber(key) == true then
      canSplitAnyPile = true;
    end
  end
  return canSplitAnyPile;
end

--
--  returns a random valid pile available to split
--
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

--
--  Loops over all piles, if any of them are of size 5 then return that pile else return a random valid pile
--
function piles.GetPileWithFiveOrRandom()
  local validPiles = {};
  
  for key,val in pairs(piles[1]) do
    if piles.IsValidPileNumber(key) then
      piles.AddToPile(validPiles, key);
    end
  end
  
  for key,val in pairs(validPiles) do
    if piles[1][val] == 5 then
      return val;
    end
  end
  
  randomIndex = math.random(0, piles.GetTableSize(validPiles) - 1);
  return validPiles[randomIndex];
end

--
--  returns true or false based on if there is a pile of size five and a pile of size three
--
function piles.HasPileOfThreeAndFive()
  local validPiles = {};
  
  for key,val in pairs(piles[1]) do
    if piles.IsValidPileNumber(key) then
      piles.AddToPile(validPiles, key);
    end
  end
  
  local hasAThree = false;
  local hasAFive = false;
  
  for key,val in pairs(validPiles) do
    if piles[1][val] == 5 then
      hasAFive = true;
    elseif piles[1][val] == 3 then
      hasAThree = true;
    end
  end
  
  if hasAThree == true and hasAFive == true then
    return true;
  else
    return false;
  end
end

--
--  returns a random valid split amount for the specified pile
--
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

--
--  if the specified pile has a size of 5 then return 2 as a split value else just return a random valid split amount
--
function piles.SplitPileOfFiveEasyOrRandom(_pile)
  if piles[1][_pile] == 5 then
    return 2;
  else
    return piles.GetRandomSplitAmount(_pile);
  end
end

--
--  if the specified pile has a size of 5 then return 1 as a split value else just return a random valid split amount
--
function piles.SplitPileOfFiveHardOrRandom(_pile)
  if piles[1][_pile] == 5 then
    return 1;
  else
    return piles.GetRandomSplitAmount(_pile);
  end
end

--
--  if there is both a pile of three and a pile of five then return 2 as a split value else just return a random split amount
--
function piles.SplitPileOfFiveWhenThreeOrRandom(_pile)
  if piles.HasPileOfThreeAndFive() == true then
    return piles.SplitPileOfFiveEasyOrRandom(_pile);
  else
    return piles.GetRandomSplitAmount(_pile);
  end
end

return piles;