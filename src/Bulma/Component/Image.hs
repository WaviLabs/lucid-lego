{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Bulma.Component.Image where

import Data.Text
import GHC.Generics
import Dhall
import Lucid


newtype IsRounded = IsRounded { unIsRounded :: Bool }
  deriving (Generic, Show)

instance FromDhall IsRounded where
instance ToDhall IsRounded where

data Size = 
    SixteenPxSquared
  | TwentyFourPxSquared
  | ThirtyTwoPxSquared
  | FourtyEightPxSquared
  | SixtyFourPxSquared
  | NinetySixPxSquared
  | HundredTwentyEightPxSquared
  | ImageIsSquare
  | OneByOne
  | FiveByFour
  | FourByThree
  | ThreeByTwo
  | FiveByThree
  | SixteenByNine
  | TwoByOne
  | ThreeByOne
  | FourByFive
  | ThreeByFour
  | TwoByThree
  | ThreeByFive
  | NineBySixteen
  | OneByTwo
  | OneByThree
  deriving (Generic, Show)

instance FromDhall Size where
instance ToDhall Size where

data Options = Options
  { src :: Text
  , alt :: Text
  , size :: Size
  , isRounded :: IsRounded
  } deriving (Generic, Show)

instance FromDhall Options where
instance ToDhall Options where

-- | For making images of different shapes and sizes
render :: Applicative m
       => Monad m
       => Options
       -> HtmlT m ()
render Options{..} = do
  figure_ [class_ $ "image " <> someClass] $
    img_ $ [src_ src, alt_ alt] <> round
  where
    someClass = case size of
      SixteenPxSquared -> "is-16x16"
      TwentyFourPxSquared -> "is-24x24"
      ThirtyTwoPxSquared -> "is-32x32"
      FourtyEightPxSquared -> "is-48x48"
      SixtyFourPxSquared -> "is-64x64"
      NinetySixPxSquared -> "is-96x96"
      HundredTwentyEightPxSquared -> "is-128x128"
      ImageIsSquare -> "is-square"
      OneByOne -> "is-1by1"
      FiveByFour -> "is-5by4"
      FourByThree -> "is-4by3"
      ThreeByTwo -> "is-3by2"
      FiveByThree -> "is-5by3"
      SixteenByNine -> "is-16by19"
      TwoByOne -> "is-2by1"
      ThreeByOne -> "is-3by1"
      FourByFive -> "is-4by5"
      ThreeByFour -> "is-3by4"
      TwoByThree -> "is-2by3"
      ThreeByFive -> "is-3by5"
      NineBySixteen -> "is-9by16"
      OneByTwo -> "is-1by2"
      OneByThree -> "is-1by3"
  
    round = 
      if unIsRounded isRounded 
      then [class_ "is-rounded"]
      else []

