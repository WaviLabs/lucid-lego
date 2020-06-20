module Extra where

import Data.Text


showT :: Show a => a -> Text
showT = pack . show
