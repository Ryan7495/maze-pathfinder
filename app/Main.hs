{- 
-- Authors: Ryan
--
-- Date: 	2020-02-19
-}

module Main where

-- import Lib
import Maze
import Path
import DFS
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as BS
import Data.Maybe

main :: IO ()
main = do
    args <- getArgs
    case args of
        [inFileName, outFileName] -> rd inFileName outFileName
        _          -> usage

usage :: IO ()
usage = Prelude.putStrLn "USAGE: solveMaze <input file name> <output file name>"

rd :: String -> String -> IO ()
rd inFileName outFileName = do
    file <- (BS.readFile inFileName)
    let pList = pathToList $ findPath $ mazeFromMaybe $ decodeMaze file
    printCList pList outFileName

printCList  :: [Coord] -> String -> IO ()
printCList  [] _ = return ()
printCList  c outFileName = do
    writeFile outFileName ""
    printCList' c outFileName
  
printCList' :: [Coord] -> String -> IO ()
printCList' [] _ = return ()
printCList' c outFileName = do
    appendFile outFileName (( show $ (fst (head c))-1)
                           ++ " "
                           ++ (show $ (snd (head c))-1)
                           ++ "\n")
    printCList' (tail c) outFileName