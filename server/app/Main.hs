{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Simple
import Database.MySQL.Simple.QueryResults
import Database.MySQL.Simple.Result
import Lib

data Card = Card { idCards :: Int, question :: String, answer :: String, deckId :: Int} deriving Show

instance QueryResults Card where
  convertResults [fic,fq, fa, fdi] [vic,vq, va, vdi] = Card { idCards = ic, question = q, answer = a, deckId = di}
    where ic = convert fic vic
          q = convert fq vq
          a = convert fa va
          di = convert fdi vdi
  convertResults fs vs  = convertError fs vs 2



select :: IO [Card]
select = do
  conn <- connect defaultConnectInfo { connectUser = "readapp", connectPassword = "readapp", connectDatabase = "flashCardsdb" }
  query_ conn "select * from Card"


main :: IO ()
main = do
  cards <- select
  _     <- putStrLn $ show cards
  return ()
