{-|
This section type if for sections that have an image at the
top of the section title and section content.
-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Component.SectionB where

import Data.Text
import Dhall
import GHC.Generics (Generic)
import Lucid
import qualified Bulma.Basic
import qualified Bulma.Component.Image

data Options = Options
  { imageOptions :: Bulma.Component.Image.Options
  , titleSize :: Bulma.Basic.TitleSize
  , titleText :: Text
  , paragraphText :: Text
  , hasTextCentered :: Bool
  } deriving (Generic, Show)

instance FromDhall Options
instance ToDhall Options

render :: Applicative m
       => Monad m
       => Options
       -> HtmlT m ()
render Options{..} = do
  Bulma.Component.Image.render imageOptions
  sectionType $ do
    Bulma.Basic.title titleSize $ toHtml titleText
    p_ $ toHtml paragraphText
  where
    sectionType = 
      if hasTextCentered 
      then Bulma.Basic.section 
      else Bulma.Basic.sectionHasTextCentered 

