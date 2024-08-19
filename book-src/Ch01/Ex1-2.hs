module Main where

main :: IO ()
main = do
  args <- getArgs
  let result = case getIntegers args of
        Just (x, y) ->
          xs ++ " + " ++ ys ++ " = " ++ xys
          where
            xy = x + y
            xs = show x
            ys = show y
            xys = show xy
        Nothing -> "expected 2 numbers"
  putStrLn result

getIntegers :: [[Char]] -> Maybe (Integer, Integer)
getIntegers [a, b] = do
  x <- readMaybe a :: Maybe Integer
  y <- readMaybe b :: Maybe Integer

  Just (x, y)
getIntegers _ = Nothing
