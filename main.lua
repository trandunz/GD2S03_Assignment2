local Piles = require("Piles");
local gameOver = false;
local playerOne = true;

function TogglePlayerOne()
  if playerOne == true then
    playerOne = false;
  else
    playerOne = true;
  end
end

function PlayerVSPlayerLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  Piles.AddPile(startingPile);
  Piles.PrintPiles();

  while (gameOver == false) do
    pileToSplit = Piles.GetValidPileNumber();
    splitAmount = Piles.GetValidSplitAmount(pileToSplit);

    Piles.SplitPile(pileToSplit, splitAmount);
    Piles.PrintPiles();
    TogglePlayerOne();
  
    if Piles.CanSplitAnyPile() == false then
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
  Piles.AddPile(startingPile);
  Piles.PrintPiles();

  while (gameOver == false) do
    pileToSplit = 0;
    splitAmount = 0;
    if playerOne == true then
      pileToSplit = Piles.GetValidPileNumber();
      splitAmount = Piles.GetValidSplitAmount(pileToSplit);
    else
      pileToSplit = Piles.GetRandomPile();
      splitAmount = Piles.GetRandomSplitAmount(pileToSplit);
    end

    Piles.SplitPile(pileToSplit, splitAmount);
    Piles.PrintPiles();
    TogglePlayerOne();
  
    if Piles.CanSplitAnyPile() == false then
      gameOver = true;
    end
  end
  
  if playerOne == true then
    print("Easy AI Wins")
  else 
    print("Player One Wins")
  end
end

function PlayerVSAIMediumLoop()
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  Piles.AddPile(startingPile);
  Piles.PrintPiles();

  while (gameOver == false) do
    pileToSplit = Piles.GetValidPileNumber();
    splitAmount = Piles.GetValidSplitAmount(pileToSplit);

    Piles.SplitPile(pileToSplit, splitAmount);
    Piles.PrintPiles();
    TogglePlayerOne();
  
    if Piles.CanSplitAnyPile() == false then
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
  Piles.AddPile(startingPile);
  Piles.PrintPiles();

  while (gameOver == false) do
    pileToSplit = Piles.GetValidPileNumber();
    splitAmount = Piles.GetValidSplitAmount(pileToSplit);

    Piles.SplitPile(pileToSplit, splitAmount);
    Piles.PrintPiles();
    TogglePlayerOne();
  
    if Piles.CanSplitAnyPile() == false then
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