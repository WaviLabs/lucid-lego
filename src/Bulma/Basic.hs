{-|
This module cotains Bulma HTML components or wrappers that take
some content/HTML and wrap them in one of Bulma's many container
components.
-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Basic where

import Data.Text
import Dhall
import GHC.Generics (Generic)
import Extra
import Lucid


-- | TODO: What's the reason for the space after/before the class names?
-- | Wraps @arg@ in a Bulma container.
container :: Term arg result
          => arg
          -> result
container = termWith "div" [class_ " container "]

-- | Wraps @arg@ in a Bulma section.
section :: Term arg result
        => arg
        -> result
section = termWith "section" [class_ " section "]

-- | For when you want a section with centered text
-- | Is there a way to describe below in terms of section
sectionHasTextCentered 
  :: Term arg result
  => arg
  -> result
sectionHasTextCentered = termWith "section" [class_ " section has-text-centered "]

-- | Should probably be moved to @Bulma.Layout@.
-- Puts HTML inside a center column that takes up 3/5 of the
-- space.
centerColumnThreeFifths 
  :: Applicative m
  => Monad m
  => HtmlT m a
  -> HtmlT m a
centerColumnThreeFifths = 
  div_ [class_ "columns is-centered"] . 
  div_ [class_ "column is-three-fifths"]

-- | For creating the Bulma h1, h2, etc.
data TitleSize = TitleSizeOne | TitleSizeTwo | TitleSizeThree | TitleSizeFour | TitleSizeFive | TitleSizeSix
  deriving (Generic, Show)

instance FromDhall TitleSize
instance ToDhall TitleSize

{- | Actually liking this implementation better
data TitleOptions = TitleOptions 
  { titleSize :: TitleSize
  , titleText :: Text
  }

title :: Applicative m
      => Monad m
      => TitleOptions
      -> HtmlT m ()
title TitleOptions{..} = titleType $ toHtml titleText
  where
    titleType = case titleSize of
      TitleSizeOne -> h1_ [class_ "title is-1"]
      TitleSizeTwo -> h2_ [class_ "title is-2"]
      TitleSizeThree -> h3_ [class_ "title is-3"]
      TitleSizeFour -> h4_ [class_ "title is-4"]
      TitleSizeFive -> h5_ [class_ "title is-5"]
      TitleSizeSix -> h6_ [class_ "title is-6"]
-}

title :: Term arg result
      => TitleSize
      -> arg
      -> result
title = \titleSize -> case titleSize of
  TitleSizeOne -> termWith "h1" [class_ " title is-1 "]
  TitleSizeTwo -> termWith "h2" [class_ " title is-2 "]
  TitleSizeThree -> termWith "h3" [class_ " title is-3 "]
  TitleSizeFour -> termWith "h4" [class_ " title is-4 "]
  TitleSizeFive -> termWith "h5" [class_ " title is-5 "]
  TitleSizeSix -> termWith "h6" [class_ " title is-6 "]

{-
-- | Bulma reccomends making the subtitle two less size smaller than the title.
-- This function will reinforce that. This will take a title size and give back the
-- corresponding subtitle size.
subtitle :: Term arg result
         => TitleOptions
         -> result
subtitle = \titleSize -> case titleSize of
  TitleSizeOne -> termWith "h3" [class_ "subtitle is-3 "]
  TitleSizeTwo -> termWith "h4" [class_ "subtitle is-4 "]
  TitleSizeThree -> termWith "h5" [class_ "subtitle is-5 "]
  TitleSizeFour -> termWith "h6" [class_ "subtitle is-6 "]
  TitleSizeFive -> termWith "h6" [class_ "subtitle is-6 "]
  TitleSizeSix -> termWith "h6" [class_ "subtitle is-6 "]
-}

