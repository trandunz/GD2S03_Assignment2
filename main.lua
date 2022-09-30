local piles = {};
local pileCount = 0;
local gameOver = false;
local playerOne = true;

function GetTableSize(_table)
  local size = 0;
  for _ in pairs(_table) do 
    size = size + 1;
  end
  return size
end

function AddPile(_newPile)
  pileCount = pileCount + 1;
  piles[pileCount] = _newPile;
end

function AddToPile(_pile, _value)
  _pile[GetTableSize(_pile)] = _value;
end

function SplitPile(_pile, _amount)
  AddPile(piles[_pile] - _amount);
  piles[_pile] = _amount;
end

function PrintTable(_table, _tableSize)
  for key,val in pairs(_table) do
    io.write(" | ");
    io.write(val);
  end
  print(" | ");
end

function GetValidPileNumber()
  local input = -1;
  while (IsValidPileNumber(input) == false) do
    io.write("Pile To Split: ");
    input = tonumber(io.read());
  end
  return input;
end

function IsValidPileNumber(_pileNumber)
  if _pileNumber == nil or piles[_pileNumber] == nil then
    return false;
  elseif _pileNumber <= pileCount and _pileNumber >= 1 and piles[_pileNumber] > 2 then
    return true;
  else
    return false;
  end
end

function GetValidSplitAmount(_pileNumber)
  local input = -1;
  while (IsValidSplitAmount(_pileNumber, input) == false) do
    io.write("Split Amount: ");
    input = tonumber(io.read());
  end
  return input;
end

function IsValidSplitAmount(_pileNumber, _splitAmount)
  if piles[_pileNumber] == nil or _splitAmount == nil then
    return false;
  elseif piles[_pileNumber] > _splitAmount
    and _splitAmount >= 1
    and piles[_pileNumber] > 2
    and (piles[_pileNumber] - _splitAmount) ~= _splitAmount then
    return true;
  else
    return false;
  end
end

function TogglePlayerOne()
  if playerOne == true then
    playerOne = false;
  else
    playerOne = true;
  end
end
    
function CanSplitAnyPile()
local canSplitAnyPile = true
  for key,val in pairs(piles) do
    if IsValidPileNumber(key) == false then
      canSplitAnyPile = false;
    end
  end
  return canSplitAnyPile;
end

function GetRandomPile()
  local validPiles = {};
  for key,val in pairs(piles) do
    if IsValidPileNumber(key) then
      AddToPile(validPiles, key);
    end
  end
  
  randomIndex = math.random(1, GetTableSize(validPiles));
  return validPiles[randomIndex];
end

function GetRandomSplitAmount(_pile)
  local validSplitAmounts = {};
  local splitAmount = 1;
  while splitAmount < GetTableSize(piles) do
    splitAmount = splitAmount + 1;
    if IsValidSplitAmount(_pile, splitAmount) then
        AddToPile(validSplitAmounts, splitAmount);
    end
  end
  
  randomIndex = math.random(1, GetTableSize(validSplitAmounts));
  return validSplitAmounts[randomIndex];
end

function PlayerVSPlayerLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  AddPile(startingPile);
  PrintTable(piles);

  while (gameOver == false) do
    pileToSplit = GetValidPileNumber();
    splitAmount = GetValidSplitAmount(pileToSplit);

    SplitPile(pileToSplit, splitAmount);
    PrintTable(piles);
    TogglePlayerOne();
  
    if CanSplitAnyPile() == false then
      gameOver = true;
    end
  end
  if playerOne == true then
    print("Player Two Wins")
  else 
    print("Player One Wins")
  end
end

function PlayerVSAIEasyLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  AddPile(startingPile);
  PrintTable(piles);

  while (gameOver == false) do
    pileToSplit = 0;
    splitAmount = 0;
    if playerOne == true then
      pileToSplit = GetValidPileNumber();
      splitAmount = GetValidSplitAmount(pileToSplit);
    else
      pileToSplit = GetRandomPile();
      splitAmount = GetRandomSplitAmount(pileToSplit);
    end

    SplitPile(pileToSplit, splitAmount);
    PrintTable(piles);
    TogglePlayerOne();
  
    if CanSplitAnyPile() == false then
      gameOver = true;
    end
  end
  if playerOne == true then
    print("Player Two Wins")
  else 
    print("Player One Wins")
  end
end

function PlayerVSAIMediumLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  AddPile(startingPile);
  PrintTable(piles);

  while (gameOver == false) do
    pileToSplit = GetValidPileNumber();
    splitAmount = GetValidSplitAmount(pileToSplit);

    SplitPile(pileToSplit, splitAmount);
    PrintTable(piles);
    TogglePlayerOne();
  
    if CanSplitAnyPile() == false then
      gameOver = true;
    end
  end
  if playerOne == true then
    print("Player Two Wins")
  else 
    print("Player One Wins")
  end
end

function PlayerVSAIHardLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  AddPile(startingPile);
  PrintTable(piles);

  while (gameOver == false) do
    pileToSplit = GetValidPileNumber();
    splitAmount = GetValidSplitAmount(pileToSplit);

    SplitPile(pileToSplit, splitAmount);
    PrintTable(piles);
    TogglePlayerOne();
  
    if CanSplitAnyPile() == false then
      gameOver = true;
    end
  end
  if playerOne == true then
    print("Player Two Wins")
  else 
    print("Player One Wins")
  end
end

function PrintMenuOptions()
  print("");
  print("Grundys Game By Will Inman");
  print("Please Select An Option");
  print("A : Player VS Player");
  print("B : Player VS AI (easy)");
  print("C : Player VS AI (medium)");
  print("D : Player VS AI (hard)");
end

function IsValidMenuSelection(_input)
  if _input == "A" 
  or _input == "a" 
  or _input == "B" 
  or _input == "b" 
  or _input == "C" 
  or _input == "c" 
  or _input == "D" 
  or _input == "d" then
    return true;
  else
    return false
  end
end

function MenuSelection()
  local validSelection = false;
  local input;
  while (validSelection == false) do
    PrintMenuOptions();
    input = io.read();
    validSelection = IsValidMenuSelection(input);
  end
  return input;
end

function Main()
  local menuSelection = MenuSelection();
  
  if menuSelection == "A" 
  or menuSelection == "a" then
      PlayerVSPlayerLoop();
  
  elseif menuSelection == "B" 
  or menuSelection == "b" then
    PlayerVSAIEasyLoop();
  
  elseif menuSelection == "C" 
  or menuSelection == "c" then
    PlayerVSAIMediumLoop();
  
  elseif menuSelection == "D" 
  or menuSelection == "d" then
    PlayerVSAIHardLoop();
  end
end

Main();