{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import Relude

main :: IO ()
main = do
  args <- getArgs
  putStrLn ("Hello, " ++ fromMaybe "Nameless One" (args !!? 0))
