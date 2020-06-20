{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Component.Level where

import Lucid


data Options m a = Options
  { left  :: HtmlT m a
  , right :: HtmlT m a
  }

render :: Applicative m
       => Monad m
       => Options m a
       -> HtmlT m a
render Options{..} =
    div_ [class_ "level"] $ do
        div_ [class_ "level-left"] left
        div_ [class_ "level-right"] right
