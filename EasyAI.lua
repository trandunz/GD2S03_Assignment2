-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : EasyAI.lua 
-- Description : EasyAI Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local EasyAI = {Piles = require("Piles"), gameOver = false, playerOne = true};

--
--  Toggles playerOne bool. Equivilent to playerOne = !playerOne in C.
--
function EasyAI:TogglePlayerOne()
  if EasyAI.playerOne == true then
    EasyAI.playerOne = false;
  else
    EasyAI.playerOne = true;
  end
end

--
--  Handles the EasyAI VS player Gameloop
--
function EasyAI:GameLoop()
  -- Print and grab starting pile size
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  
  -- Add starting pile to piles table
  EasyAI.Piles.AddPile(startingPile);
  
  -- Print piles table
  EasyAI.Piles.PrintPiles();

  -- loop while the game is not over
  while (EasyAI.gameOver == false) do
    local pileToSplit = 0;
    local splitAmount = 0;
    
    -- If its the players turn, 
    if EasyAI.playerOne == true then
      -- Get the users pile to split
      pileToSplit = EasyAI.Piles.GetValidPileNumber();
      -- Get the users pile split amount
      splitAmount = EasyAI.Piles.GetValidSplitAmount(pileToSplit);
      
    -- Else if its the AIs turn
  else
      -- Get the ai's pile to split
      pileToSplit = EasyAI.Piles.GetPileWithFiveOrRandom();
      -- Get the ai's pile split amount
      splitAmount = EasyAI.Piles.SplitPileOfFiveEasyOrRandom(pileToSplit);
    end

    -- Split the pile
    EasyAI.Piles.SplitPile(pileToSplit, splitAmount);
    
    -- Print the list of piles with an identifier for whos turn it is
    if EasyAI.playerOne == true then
      io.write("User: ");
      EasyAI.Piles.PrintPiles();
    else
      io.write("EasyAI: ");
      EasyAI.Piles.PrintPiles();
    end
    
    -- Toggle players turn
    EasyAI.TogglePlayerOne();
  
    -- Check for win condition
    if EasyAI.Piles.CanSplitAnyPile() == false then
      EasyAI.gameOver = true;
    end
  end
  
  -- If game is over, print who wins
  if EasyAI.playerOne == true then
    print("Easy AI Wins")
  else 
    print("Player One Wins")
  end
end

return EasyAI;