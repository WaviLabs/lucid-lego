{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Layout.TripleColumn
  ( Options(..)
  , render
  )
  where

import Lucid


data Options m a = Options
  { isCentered  :: Bool
  , isVCentered :: Bool
  , slot1       :: HtmlT m a
  , slot2       :: HtmlT m a
  , slot3       :: HtmlT m a
  }

render :: Applicative m
       => Monad m
       => Options m a
       -> HtmlT m a
render Options{..} = do
    div_ [class_ $ "columns " <> vCenter <> " " <> center] $ do
        div_ [class_ "column is-one-thirds"] slot1
        div_ [class_ "column"] slot2
        div_ [class_ "column"] slot3
  where
    vCenter =
      if isVCentered
      then "is-vcentered"
      else ""
    center = 
      if isCentered
      then "is-centered"
      else ""

