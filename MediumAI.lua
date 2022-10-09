-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : MediumAI.lua 
-- Description : MediumAI Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local MediumAI = {Piles = require("Piles"), gameOver = false, playerOne = true};

--
--  Toggles playerOne bool. Equivilent to playerOne = !playerOne in C.
--
function MediumAI:TogglePlayerOne()
  if MediumAI.playerOne == true then
    MediumAI.playerOne = false;
  else
    MediumAI.playerOne = true;
  end
end

--
--  Handles the MediumAI VS player Gameloop
--
function MediumAI:GameLoop()
  -- Print and grab starting pile size
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  
  -- Add starting pile to piles table
  MediumAI.Piles.AddPile(startingPile);
  
  -- Print piles table
  MediumAI.Piles.PrintPiles();

  -- loop while the game is not over
  while (MediumAI.gameOver == false) do
    local pileToSplit = 0;
    local splitAmount = 0;
    
    -- If its the players turn, 
    if MediumAI.playerOne == true then
      -- Get the users pile to split 
      pileToSplit = MediumAI.Piles.GetValidPileNumber();
      -- Get the users pile split amount
      splitAmount = MediumAI.Piles.GetValidSplitAmount(pileToSplit);
    else
      -- Get Ai pile to split
      pileToSplit = MediumAI.Piles.GetRandomPile();
      -- Get AI pile split amount
      splitAmount = MediumAI.Piles.GetRandomSplitAmount(pileToSplit);
    end

    -- Split the pile
    MediumAI.Piles.SplitPile(pileToSplit, splitAmount);
    
    -- Print the list of piles with an identifier for whos turn it is
    if MediumAI.playerOne == true then
      io.write("User: ");
      MediumAI.Piles.PrintPiles();
    else
      io.write("MediumAI: ");
      MediumAI.Piles.PrintPiles();
    end
    
    -- Toggle players turn
    MediumAI.TogglePlayerOne();
  
    -- Check for win condition
    if MediumAI.Piles.CanSplitAnyPile() == false then
      MediumAI.gameOver = true;
    end
  end
  
  -- If game is over, print who wins
  if MediumAI.playerOne == true then
    print("Medium AI Wins")
  else 
    print("Player One Wins")
  end
end

return MediumAI;