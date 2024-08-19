module Main where

main :: IO ()
main = do
  args <- getArgs
  let s = case args of
            [a, b] -> "Hello, " ++ a ++ " " ++ b
            _ -> "I don't understand"
  putStrLn s
