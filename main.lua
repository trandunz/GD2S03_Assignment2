-- Bachelor of Software Engineering 
-- Media Design School 
-- Auckland 
-- New Zealand 
-- (c) Media Design School
-- File Name : Main.lua 
-- Description : Main Implementation File
-- Author : William Inman
-- Mail : william.inman@mds.ac.nz

local PlayerVSPlayer = require("PlayerVSPlayer");
local EasyAI = require("EasyAI");
local MediumAI = require("MediumAI");
local HardAI = require("HardAI");

--
--  Prints out the menu options
--
function PrintMenuOptions()
  print("");
  print("Grundys Game By Will Inman");
  print("Please Select An Option");
  print("A : Player VS Player");
  print("B : Player VS AI (easy)");
  print("C : Player VS AI (medium)");
  print("D : Player VS AI (hard)");
end

--
--  Checks if the specified input is valid
--
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

--
--  Initial menu selection loop. 
--  Prints the menu options and waits for valid option selection
--
function MenuSelection()
  local validSelection = false;
  local input;
  
  -- Loop while input is invalid
  while (validSelection == false) do
    -- Print Menu Options
    PrintMenuOptions();
    
    -- Grab player input
    input = io.read();
    
    -- Check if input is valid
    validSelection = IsValidMenuSelection(input);
  end
  return input;
end

--
--  Main thread function
--
function Main()
  -- Print and grab menu input
  local menuSelection = MenuSelection();
  
  -- If menu input is "a" then start player vs player game loop
  if menuSelection == "A" 
  or menuSelection == "a" then
    PlayerVSPlayer.GameLoop();
  
    -- If menu input is "b" then start easyAI vs player game loop
  elseif menuSelection == "B" 
  or menuSelection == "b" then
    EasyAI.GameLoop();
  
    -- If menu input is "c" then start mediumAI vs player game loop
  elseif menuSelection == "C" 
  or menuSelection == "c" then
    MediumAI.GameLoop();
  
    -- If menu input is "d" then start hardAI vs player game loop
  elseif menuSelection == "D" 
  or menuSelection == "d" then
    HardAI.GameLoop();
  end
  
end

-- Start the main thread
Main();