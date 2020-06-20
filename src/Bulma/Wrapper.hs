{-# LANGUAGE OverloadedStrings #-}

module Bulma.Wrapper where

import Lucid


container_ :: Term arg result
           => arg
           -> result
container_ = termWith "div" [class_ "container "]

bulmaSection_ :: Term arg result
              => arg
              -> result
bulmaSection_ = termWith "section" [class_ "section "]

centerCol35_ :: Applicative m
             => Monad m
             => HtmlT m a
             -> HtmlT m a
centerCol35_ =
    div_ [class_ "columns is-centered"] .
    div_ [class_ "column is-three-fifths"]
