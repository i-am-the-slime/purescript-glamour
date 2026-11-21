module Test.Main where

import Prelude

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Newtype (un)
import Data.String (Pattern(..), contains, length, split)
import Data.Array (all)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Glamour (Theme(..))
import Glamour as Glamour
import Test.Exit (exit)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (fail, shouldSatisfy)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (defaultConfig, evalSpecT)
import Test.Spec.Summary (successful)

main :: Effect Unit
main = launchAff_ do
  results <- un Identity (evalSpecT (defaultConfig { exit = false }) [ consoleReporter ] specs)
  unless (successful results) (exit 1 # liftEffect)

specs :: Spec Unit
specs = describe "Glamour" do
  it "renders the README example" do
    rendered (Glamour.render _ { theme = Dracula, width = 60 } "# Hello\n\nSome *emphasis* and `code`.") \text ->
      text `shouldSatisfy` contains (Pattern "Hello")

  it "renders headings, emphasis and lists" do
    rendered (Glamour.render _ { theme = NoColors } "# Groceries\n\n- *Bread*\n- Butter") \text -> do
      text `shouldSatisfy` contains (Pattern "# Groceries")
      text `shouldSatisfy` contains (Pattern "• *Bread*")

  it "styles text in color themes" do
    rendered (Glamour.render _ { theme = Dracula } "**bold**") \text ->
      text `shouldSatisfy` contains (Pattern "\x1b[")

  it "wraps at the width" do
    rendered (Glamour.render _ { theme = NoColors, width = 20 } "one two three four five six seven eight nine ten") \text ->
      split (Pattern "\n") text `shouldSatisfy` all (\line -> lengthOf line <= 20)

  it "turns emoji codes into emoji" do
    rendered (Glamour.render _ { theme = NoColors, emoji = true } "hi :wave:") \text ->
      text `shouldSatisfy` contains (Pattern "👋")
  where
  rendered result check = case result of
    Right text -> check text
    Left problem -> fail problem
  lengthOf = length
