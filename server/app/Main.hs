{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP           #-}
{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies  #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Main where

--servant imports
import           Data.Aeson
import           Data.Time.Calendar
import           GHC.Generics
import           Network.Wai
import           Servant
import           Network.Wai.Handler.Warp
import           Database

--servant endpoint
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
  cards <- runSelectQuery
  run 8081 (app1 cards)