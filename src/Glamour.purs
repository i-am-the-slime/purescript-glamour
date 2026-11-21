-- | Markdown, rendered for the terminal.
-- |
-- |     Glamour.render _ { width = 60 } "# Hello\n\nSome *emphasis*."
module Glamour
  ( Options
  , Theme(..)
  , render
  ) where

import Prelude

import Data.Either (Either(..))

type Options =
  { theme :: Theme
  -- | Wrap lines at this many cells; `0` doesn't wrap.
  , width :: Int
  -- | Turn `:smile:` into 😄.
  , emoji :: Boolean
  -- | Keep the line breaks of paragraphs.
  , preserveNewLines :: Boolean
  }

data Theme = Dark | Light | Dracula | TokyoNight | Pink | Ascii | NoColors

derive instance Eq Theme

-- | Render Markdown, or say why it can't.
render :: (Options -> Options) -> String -> Either String String
render configure markdown = do
  let options = configure { theme: Dark, width: 80, emoji: false, preserveNewLines: false }
  renderImpl Left Right (themeName options.theme) options.width options.emoji options.preserveNewLines markdown
  where
  themeName = case _ of
    Dark -> "dark"
    Light -> "light"
    Dracula -> "dracula"
    TokyoNight -> "tokyo-night"
    Pink -> "pink"
    Ascii -> "ascii"
    NoColors -> "notty"

foreign import renderImpl
  :: forall r
   . (String -> r)
  -> (String -> r)
  -> String
  -> Int
  -> Boolean
  -> Boolean
  -> String
  -> r
