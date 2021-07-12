{- 
-- Authors: Ryan
--
-- Date:    2020-02-19
-}

module Maze
    ( Maze(..)
    , decodeMaze
    , mazeFromMaybe
    ) where

import Data.Binary.Get
import Data.Matrix
import qualified Data.ByteString.Lazy as BS ( ByteString
                                            , null
                                            , head
                                            , tail
                                            , take
                                            , drop
                                            )
import Data.Word (Word8)
import Data.Bits
import Data.Maybe (fromMaybe)

data Maze = Maze
  { height  :: Int
  , width   :: Int
  , mazeMat :: Matrix Int
  } deriving (Show)

decodeMaze :: BS.ByteString -> Maybe Maze
decodeMaze bs = Just (Maze w h m)
  where
    w = (byteStringToInt $ BS.take 4 bs) 
    h = (byteStringToInt $ BS.take 4 (BS.drop 4 bs))
    m = (fromList w h $ getMazeStructure $ BS.drop 8 bs)

mazeFromMaybe :: Maybe Maze -> Maze
mazeFromMaybe (Just m) = m

-- Converts the rest of the ByteString to a list onf Int
getMazeStructure :: BS.ByteString -> [Int]
getMazeStructure bs = if (BS.null bs) then [] else l ++ p 
  where
    l = getMazeStructure' (BS.head bs)
    p = getMazeStructure  (BS.tail bs)

getMazeStructure' :: Word8 -> [Int]
getMazeStructure' w = [ get1stInt w
                      , get2ndInt w
                      , get3rdInt w
                      , get4thInt w
                      ]

-- The following 4 functions are used to extract the wall information of the maze
get4thInt :: Word8 -> Int
get4thInt w = fromMaybe 0 (toIntegralSized $ shiftR (w .&. 192) 6)

get3rdInt :: Word8 -> Int
get3rdInt w = fromMaybe 0 (toIntegralSized $ shiftR (w .&. 48) 4)

get2ndInt :: Word8 -> Int
get2ndInt w = fromMaybe 0 (toIntegralSized $ shiftR (w .&. 12) 2)

get1stInt :: Word8 -> Int
get1stInt w = fromMaybe 0 (toIntegralSized $ (w .&. 3))

-- Used to convert the height and width bytes to ints
byteStringToInt :: BS.ByteString -> Int
byteStringToInt bs = fromIntegral (runGet getInt32le bs) :: Int
