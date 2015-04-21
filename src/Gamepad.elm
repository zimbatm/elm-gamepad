module Gamepad
  ( gamepads
  , Button
  , Gamepad
  ) where

{-| Library for working with gamepads
-}

import Native.Gamepad
import Signal exposing (Signal)

type alias Button =
  { pressed : Bool
  , value : Float
  }

type alias Gamepad =
  { id : String
  , axes : List Float
  , buttons : List Button
  , mapping : String
  -- connected
  -- index
  -- timestamp
  }

gamepads : Signal (List Gamepad)
gamepads =
  Native.Gamepad.gamepads

