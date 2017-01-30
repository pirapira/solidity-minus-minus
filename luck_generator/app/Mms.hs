{-# LANGUAGE TemplateHaskell, DeriveDataTypeable #-}
import System.IO

import Luck.Template
import Test.QuickCheck

import Data.Data

data ContractElement =
  VariableDeclaration Int
  deriving (Data, Show)

stringGen :: Gen (Maybe [ContractElement])
stringGen = $(mkGenQ "minus-minus-solidity.luck") defFlags{_maxUnroll=2} TProxy1

main :: IO ()
main = do
  (mts : _ ) <- sample' stringGen
  case mts of
    Just c -> putStrLn $ show c
    Nothing -> error "Unsuccesful generation"
