-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : HardAI.lua 
-- Description : HardAI Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local HardAI = {Piles = require("Piles"), gameOver = false, playerOne = true};

--
--  Toggles playerOne bool. Equivilent to playerOne = !playerOne in C.
--
function HardAI:TogglePlayerOne()
  if HardAI.playerOne == true then
    HardAI.playerOne = false;
  else
    HardAI.playerOne = true;
  end
end

--
--  Handles the HardAI VS player Gameloop
--
function HardAI:GameLoop()
  -- Print and grab starting pile size
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  
  -- Add starting pile to piles table
  HardAI.Piles.AddPile(startingPile);
  
  -- Print piles table
  HardAI.Piles.PrintPiles();

  -- loop while the game is not over
  while (HardAI.gameOver == false) do
    local pileToSplit = 0;
    local splitAmount = 0;
    
    -- If its the players turn, 
    if HardAI.playerOne == true then
      -- Get the users pile to split 
      pileToSplit = HardAI.Piles.GetValidPileNumber();
      -- Get the users pile split amount
      splitAmount = HardAI.Piles.GetValidSplitAmount(pileToSplit);
    else
      -- Get Ai pile to split
      pileToSplit = HardAI.Piles.GetPilesFiveAnd3OrRandom();
      -- Get AI pile split amount
      splitAmount = HardAI.Piles.SplitPileOfFiveHardOrRandom(pileToSplit);
    end

    -- Split the pile
    HardAI.Piles.SplitPile(pileToSplit, splitAmount);
    
    -- Print the list of piles with an identifier for whos turn it is
    if HardAI.playerOne == true then
      io.write("User: ");
      HardAI.Piles.PrintPiles();
    else
      io.write("HardAI: ");
      HardAI.Piles.PrintPiles();
    end
    
    -- Toggle players turn
    HardAI.TogglePlayerOne();
  
    -- Check for win condition
    if HardAI.Piles.CanSplitAnyPile() == false then
      HardAI.gameOver = true;
    end
  end
  
  -- If game is over, print who wins
  if HardAI.playerOne == true then
    print("Hard AI Wins")
  else 
    print("Player One Wins")
  end
end

return HardAI;