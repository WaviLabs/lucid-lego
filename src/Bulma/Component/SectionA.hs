{-|
This is a basic section that takes content for
the title and paragraph and size. 
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Component.SectionA where

import Data.Text
import Lucid
import qualified Bulma.Basic


data Options = Options
  { titleSize :: Bulma.Basic.TitleSize
  , titleText :: Text
  , paragraphText :: Text
  , hasTextCentered :: Bool
  }

render :: Applicative m
       => Monad m
       => Options
       -> HtmlT m ()
render Options{..} = sectionType $ do
      Bulma.Basic.title titleSize $ toHtml titleText
      p_ $ toHtml paragraphText
  where
    sectionType = 
      if hasTextCentered 
      then Bulma.Basic.section 
      else Bulma.Basic.sectionHasTextCentered 
  
