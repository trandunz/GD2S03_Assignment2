-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : PlayerVSPlayer.lua 
-- Description : PlayerVSPlayer Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local PlayerVSPlayer = {Piles = require("Piles"), gameOver = false, playerOne = true};

--
--  Toggles playerOne bool. Equivilent to playerOne = !playerOne in C.
--
function PlayerVSPlayer:TogglePlayerOne()
  if PlayerVSPlayer.playerOne == true then
    PlayerVSPlayer.playerOne = false;
  else
    PlayerVSPlayer.playerOne = true;
  end
end

--
--  Handles the player VS player Gameloop
--
function PlayerVSPlayer:GameLoop()
  -- Print and grab starting pile size
  io.write("Starting Pile Size: ");
  startingPile = tonumber(io.read());
  
  -- Add starting pile to piles table
  PlayerVSPlayer.Piles.AddPile(startingPile);
  
  -- Print piles table
  PlayerVSPlayer.Piles.PrintPiles();

  -- loop while the game is not over
  while (PlayerVSPlayer.gameOver == false) do
    -- Get the users pile to split
    pileToSplit = PlayerVSPlayer.Piles.GetValidPileNumber();
    
    -- Get the users pile split amount
    splitAmount = PlayerVSPlayer.Piles.GetValidSplitAmount(pileToSplit);

    -- Split the pile by the amount
    PlayerVSPlayer.Piles.SplitPile(pileToSplit, splitAmount);
    
    -- if its player ones turn
    if PlayerVSPlayer.playerOne == true then
      io.write("P1: ");
      PlayerVSPlayer.Piles.PrintPiles();
    
    -- Else if its player twos turn
    else
      io.write("P2: ");
      PlayerVSPlayer.Piles.PrintPiles();
    end
    
    -- Switch to other player
    PlayerVSPlayer.TogglePlayerOne();
  
    -- Check for win condition
    if PlayerVSPlayer.Piles.CanSplitAnyPile() == false then
      PlayerVSPlayer.gameOver = true;
    end
  end
  
  -- If game is over, print who wins
  if PlayerVSPlayer.playerOne == true then
    print("Player Two Wins")
  else 
    print("Player One Wins")
  end
end

return PlayerVSPlayer;