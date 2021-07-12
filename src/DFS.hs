{- 
-- Authors: Ryan
--
-- Date:    2020-02-19
-}

module DFS 
    ( findPath
    ) where

import Maze
import Path
import Data.Matrix

--find the path to a given maze using depth first search
findPath :: Maze -> Maybe Path
findPath maze = Just (dfs maze [(Path Nothing (1,1))])

--Does a Depth First Search on a maze using the supplied stack
dfs :: Maze -> [Path] -> Path
dfs maze stack
    | (currCoord currPath) == (mh, mw) = currPath --Check if we are at end tile (last element in path)
    | otherwise                        = dfs maze newStack
  where
    mh       = (height maze)
    mw       = (width  maze)
    currPath = head stack
    newStack = appendToStack (getNewPaths maze currPath) (tail stack)

--Filters out the Nothings and extracts the paths from their Just
appendToStack :: [Maybe Path] -> [Path] -> [Path]
appendToStack p s = p' ++ s
  where
    p' = map (getPath) (filter (\n -> n /= Nothing) p)

--Runs Up, Down, Left, Right on the current path and returns a list of Nothing or the paths that are to be added to the stack
getNewPaths :: Maze -> Path -> [Maybe Path]
getNewPaths maze currPath = map ($ (maze, currPath)) [up, down, left, right]

--Checks to see if the position above should be added to the stack
up :: (Maze, Path) -> Maybe Path
up (maze, path)
    | cRow == 1                                                     = Nothing
    | (parent path) /= Nothing && cRow == (pRow+1) && cCol == pCol  = Nothing
    | (mazeMat maze) ! (cRow-1, cCol) == 0                          = Just (Path (Just path) (cRow-1, cCol))
    | (mazeMat maze) ! (cRow-1, cCol) == 1                          = Just (Path (Just path) (cRow-1, cCol)) 
    | otherwise                                                     = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))

--Checks to see if the position below should be added to the stack
down :: (Maze, Path) -> Maybe Path
down (maze, path)
    | cRow == mh                                                    = Nothing
    | (parent path) /= Nothing && cRow == (pRow-1) && cCol == pCol  = Nothing
    | (mazeMat maze) ! (cRow, cCol) == 0                            = Just (Path (Just path) (cRow+1, cCol))
    | (mazeMat maze) ! (cRow, cCol) == 1                            = Just (Path (Just path) (cRow+1, cCol)) 
    | otherwise                                                     = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))
    mh   = (height maze)

--Checks to see if the position to the left should be added to the stack
left :: (Maze, Path) -> Maybe Path
left (maze, path)
    | cCol == 1                                                     = Nothing
    | (parent path) /= Nothing && cRow == pRow && cCol == (pCol+1)  = Nothing
    | (mazeMat maze) ! (cRow, cCol-1) == 0                          = Just (Path (Just path) (cRow, cCol-1))
    | (mazeMat maze) ! (cRow, cCol-1) == 2                          = Just (Path (Just path) (cRow, cCol-1)) 
    | otherwise                                                     = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))

--Checks to see if the position to the right should be added to the stack
right :: (Maze, Path) -> Maybe Path
right (maze, path)
    | cCol == mw                                                    = Nothing
    | (parent path) /= Nothing && cRow == pRow && cCol == (pCol-1)  = Nothing
    | (mazeMat maze) ! (cRow, cCol) == 0                            = Just (Path (Just path) (cRow, cCol+1))
    | (mazeMat maze) ! (cRow, cCol) == 2                            = Just (Path (Just path) (cRow, cCol+1)) 
    | otherwise                                                     = Nothing
  where
    cRow = fst (currCoord path)
    cCol = snd (currCoord path)
    pRow = fst (getCoord (parent path))
    pCol = snd (getCoord (parent path))
    mw   = (width maze)
