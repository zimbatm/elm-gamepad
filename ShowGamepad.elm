import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Graphics.Element exposing (..)
import Gamepad

main : Signal Element
main =
  Signal.map show Gamepad.gamepads
