{- 
-- Authors: Ryan
--
-- Date: 	2020-02-19
-}

module Path 
    ( Path  (..)
    , Coord (..)
    , pathToList
    , getParent
    , getCoord
    , getPath
    ) where

import Data.Maybe

type Coord = (Int, Int)

data Path = Path
  { parent    :: Maybe Path
  , currCoord :: Coord
  } deriving (Show, Eq)

-- Converts a path to a list of Coords in O(n) time by starting 
-- at the last element of the path and making it's way up by prepending
-- to the list.
pathToList :: Maybe Path -> [Coord]
pathToList p = pathToList' p []

pathToList' :: Maybe Path -> [Coord] -> [Coord]
pathToList' p l
    | ((getParent p) == Nothing) = ((getCoord p):l)
    | otherwise  = pathToList' (getParent p) ((getCoord p):l)

-- Helper function to extract the parent Path node from a Path node that
-- is wrapped in a Maybe
getParent :: Maybe Path -> Maybe Path
getParent (Just p) = (parent p)

-- Helper function to remove the Just of a Just Path
-- Is only used after a check that the path is not Nothing
getPath :: Maybe Path -> Path
getPath (Just p) = p

-- Helper function to get the Coords of a Maybe Path
-- Is only used after a check that the path is not Nothing
getCoord :: Maybe Path -> Coord
getCoord (Just p) = (currCoord p)
