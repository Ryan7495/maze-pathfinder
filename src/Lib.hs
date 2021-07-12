{- 
-- Authors: Ryan
--
-- Date:    2020-02-19
-}

module Lib
    ( --dfs
    --dfs
    {-
    , check_up
    , check_down
    , check_left
    , check_right
    -}
    ) where


import Maze
import Path
import Data.Matrix

--findPath :: Maze -> Maybe Path
--findPath maze = Just (dfs maze [(Path Nothing (0,0))])



--     Maze    Stack    CurPos -> Path (List of coords)
dfs :: Maze -> [Path] -> Path
dfs maze stack = undefined

testFunc :: Maze -> [Path] -> [Maybe Path]
testFunc maze stack = map ($ (maze, head stack)) [up, down, left, right]

  -- 1 pop path off of stack

  -- 2 check if were at the end tile (last element in path)

  -- 3 compute valid neihbors and append to new pathes

  -- 4 append new pathes to stack

  -- 5 recurse on DFS again

-- getAdjacentTiles :: Maze -> Path -> [Path]
-- getAdjacentTiles maze p = map ($ [maze, pos, p_pos]) [up, down, left, right]


up :: (Maze, Path) -> Maybe Path
up (maze, path)
    | cRow == 1                             = Nothing
    | cRow == (pRow+1) && cCol == pCol      = Nothing
    | (mazeMat maze) ! (cRow-1, cCol) == 0  = Just (Path (Just path) (cRow-1, cCol))
    | (mazeMat maze) ! (cRow-1, cCol) == 1  = Just (Path (Just path) (cRow-1, cCol)) 
    | otherwise                             = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))


down :: (Maze, Path) -> Maybe Path
down (maze, path)
    | cRow == mh                          = Nothing
    | cRow == (pRow-1) && cCol == pCol    = Nothing
    | (mazeMat maze) ! (cRow, cCol) == 0  = Just (Path (Just path) (cRow+1, cCol))
    | (mazeMat maze) ! (cRow, cCol) == 1  = Just (Path (Just path) (cRow+1, cCol)) 
    | otherwise                           = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))
    mh   = (height maze)


left :: (Maze, Path) -> Maybe Path
left (maze, path)
    | cRow == 1                             = Nothing
    | cRow == pRow && cCol == (pCol+1)      = Nothing
    | (mazeMat maze) ! (cRow, cCol-1) == 0  = Just (Path (Just path) (cRow, cCol-1))
    | (mazeMat maze) ! (cRow, cCol-1) == 2  = Just (Path (Just path) (cRow, cCol-1)) 
    | otherwise                             = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))


right :: (Maze, Path) -> Maybe Path
right (maze, path)
    | cRow == mw                          = Nothing
    | cRow == pRow && cCol == (pCol-1)    = Nothing
    | (mazeMat maze) ! (cRow, cCol) == 0  = Just (Path (Just path) (cRow, cCol+1))
    | (mazeMat maze) ! (cRow, cCol) == 2  = Just (Path (Just path) (cRow, cCol+1)) 
    | otherwise                           = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))
    mw   = (width maze)



makeMaze :: Maze
makeMaze = Maze 7 7 (fromLists([[2, 0, 0, 3, 1, 1, 0],[1, 3, 0, 3, 0, 1, 1],[2, 0, 0, 3, 0, 0, 1],[1, 3, 0, 3, 2, 2, 0],[0, 1, 1, 0, 3, 1, 0],[0, 0, 3, 0, 2, 2, 1],[2, 0, 2, 2, 0, 0, 0]]))

getPP :: Int -> Path
getPP 0 = p5 where
    p5 = Path (Just p4) (1,3) where
        p4 = Path (Just p3) (1,2) where
            p3 = Path (Just p2) (2,2) where
                p2 = Path (Just p1) (2,1) where
                    p1 = Path Nothing   (1,1)  
