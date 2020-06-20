{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Layout.DoubleColumn
  ( Options(..)
  , render
  ) where

import Lucid


data Options m a = Options
  { isCentered  :: Bool
  , isVCentered :: Bool
  , isReverse   :: Bool
  , slot1       :: HtmlT m a
  , slot2       :: HtmlT m a
  }

render :: Applicative m
       => Monad m
       => Options m a
       -> HtmlT m a
render Options{..} =
    div_ [class_ $ "columns " <> vCenter <> " " <> reverse <> " " <> center] $
        if isReverse
        then do
            div_ [class_ "column is-half"] slot1
            div_ [class_ "column"] slot2
        else do
            div_ [class_ "column is-half"] slot2
            div_ [class_ "column"] slot1
  where
    center = 
        if isCentered 
        then "centered"
        else ""
    reverse =
        if isReverse
        then "reverse-columns"
        else ""
    vCenter =
        if isVCentered
        then "is-vcentered"
        else ""
