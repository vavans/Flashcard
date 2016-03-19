{-# LANGUAGE Arrows #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}

module Database where

import Prelude hiding (sum)

import Opaleye (Column, Nullable, matchNullable, isNull,
               Table(Table), required, queryTable,
               Query, QueryArr, restrict, (.==), (.<=), (.&&), (.<),
               (.===),
               (.++), ifThenElse, pgString, aggregate, groupBy,
               count, avg, sum, leftJoin, runQuery,
               showSqlForPostgres, Unpackspec,
               PGInt4, PGInt8, PGText, PGDate, PGFloat8, PGBool)
import Data.Profunctor.Product (p2, p3,p4)
import Data.Profunctor.Product.Default (Default)
import Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import Data.Time.Calendar (Day)
import Control.Arrow (returnA, (<<<))
import           Data.Aeson
import           Data.Time.Calendar
import           GHC.Generics

import qualified Database.PostgreSQL.Simple as PGS

--types

data Card' a b c d = Card' { idcard :: a, question :: b, answer :: c, iddeck :: d} deriving (Show, Generic)
type Card = Card' Int String String Int
type CardColumn = Card' (Column PGInt4) (Column PGText) (Column PGText) (Column PGInt4)
$(makeAdaptorAndInstance "pCard" ''Card')

--cardTable :: Table ( Column PGInt4, Column PGText, Column PGText, Column PGInt4 )
--                   ( Column PGInt4, Column PGText, Column PGText, Column PGInt4 )
--cardTable = Table "Card" (p4 (required "idcard", required "question", required "answer", required "iddeck" ))
cardTable :: Table CardColumn CardColumn
cardTable = Table "Card"
                  (pCard Card' { idcard = required "idcard", question = required "question", answer = required "answer", iddeck = required "iddeck"} )


select :: Query CardColumn
select = queryTable cardTable

runSelectQuery :: IO [Card]
runSelectQuery =
  do
    conn <- PGS.connect PGS.defaultConnectInfo { PGS.connectHost = "192.168.1.45", PGS.connectUser = "readapp", PGS.connectPassword = "readapp", PGS.connectDatabase = "flashcards" }
    runSelectQuery' conn select

runSelectQuery' :: PGS.Connection -> Query CardColumn -> IO [Card]
runSelectQuery' conn q = runQuery conn q
