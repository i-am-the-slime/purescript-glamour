-- | A PureScript wrapper for `github.com/charmbracelet/glamour` — render
-- | Markdown into ANSI-styled terminal text.
module Glamour
  ( Style(..)
  , styleString
  , render
  , renderWithWidth
  ) where

import Data.Either (Either)
import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)

data Style
  = Auto
  | Ascii
  | Dark
  | Light
  | Dracula
  | TokyoNight
  | Pink
  | NoTTY

foreign import styleAuto :: String
foreign import styleAscii :: String
foreign import styleDark :: String
foreign import styleLight :: String
foreign import styleDracula :: String
foreign import styleTokyoNight :: String
foreign import stylePink :: String
foreign import styleNoTTY :: String

styleString :: Style -> String
styleString = case _ of
  Auto -> styleAuto
  Ascii -> styleAscii
  Dark -> styleDark
  Light -> styleLight
  Dracula -> styleDracula
  TokyoNight -> styleTokyoNight
  Pink -> stylePink
  NoTTY -> styleNoTTY

foreign import renderImpl :: Fn2 String String (Either String String)

-- | Render Markdown to styled terminal text. `Left` carries glamour's
-- | error message; `Right` carries the rendered string.
render :: Style -> String -> Either String String
render style input = runFn2 renderImpl input (styleString style)

foreign import renderWithWidthImpl :: Fn3 String String Int (Either String String)

-- | Same as `render` but wraps lines at the given width.
renderWithWidth :: Style -> Int -> String -> Either String String
renderWithWidth style width input = runFn3 renderWithWidthImpl input (styleString style) width
