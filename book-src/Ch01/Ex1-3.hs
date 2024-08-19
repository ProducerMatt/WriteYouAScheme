module Main where

main :: IO ()
main = do
  input <- getLine
  putText ("You wrote " <> input)
