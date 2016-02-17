{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP           #-}
{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies  #-}
{-# LANGUAGE TypeOperators #-}

module Main where

--servant imports
import           Data.Aeson
import           Data.Time.Calendar
import           GHC.Generics
import           Network.Wai
import           Servant
import           Network.Wai.Handler.Warp
--simple sql imports
import Database.MySQL.Simple
import Database.MySQL.Simple.QueryResults
import Database.MySQL.Simple.Result

data Card = Card { idCards :: Int, question :: String, answer :: String, deckId :: Int} deriving (Show, Generic)


--sql types converter
instance QueryResults Card where
  convertResults [fic,fq, fa, fdi] [vic,vq, va, vdi] = Card { idCards = ic, question = q, answer = a, deckId = di}
    where ic = convert fic vic
          q = convert fq vq
          a = convert fa va
          di = convert fdi vdi
  convertResults fs vs  = convertError fs vs 2

--sql request select all cards
select :: IO [Card]
select = do
  conn <- connect defaultConnectInfo { connectUser = "readapp", connectPassword = "readapp", connectDatabase = "flashCardsdb" }
  query_ conn "select * from Card"


--sevant endpoint
type CardsAPI = "cards" :> Get '[JSON] [Card]

instance ToJSON Card

server1 :: [Card] -> Server CardsAPI
server1 cards = return cards

cardAPI :: Proxy CardsAPI
cardAPI = Proxy

app1 :: [Card] -> Application
app1 cards = serve cardAPI (server1 cards)

main :: IO ()
main = do
  cards <- select
  run 8081 (app1 cards)

-- main :: IO ()
-- main = do
--   cards <- select
--   _     <- putStrLn $ show cards
--   return ()
