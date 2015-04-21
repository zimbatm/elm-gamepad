-- Copied from http://www.elm-lang.org/edit/examples/Intermediate/Mario.elm
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Keyboard
import Debug
import Gamepad exposing (..)
import Time exposing (..)
import Window

-- MODEL
mario = { x=0, y=0, vx=0, vy=0, dir="right" }


-- UPDATE -- ("m" is for Mario)
--jump {y} m = if y > 0 && m.y == 0 then { m | vy <- 5 } else m
jump {y} m = if y > 0 then { m | vy <- 5 } else m
gravity t m = if m.y > 0 then { m | vy <- m.vy - t/4 } else m
physics t m = { m | x <- m.x + t*m.vx , y <- max 0 (m.y + t*m.vy) }
walk {x} m = { m | vx <- (toFloat x) * 2
                 , dir <- if x < 0 then "left" else
                          if x > 0 then "right" else m.dir }

step (dt, keys) =
  jump keys >> gravity dt >> walk keys >> physics dt

-- DISPLAY
render (w',h') mario =
  let (w,h) = (toFloat w', toFloat h')
  in collage w' h'
      [ rect w h  |> filled (rgb 174 238 238)
      , rect w 50 |> filled (rgb 74 163 41)
                  |> move (0, 24 - h/2)
      , toForm (image 100 100 "/assets/gorilla.png")
                  |> move (mario.x, mario.y + 62 - h/2)
      ]

-- I'm sure there is a better way to this staircase from hell
gamepadsToArrows : List Gamepad -> { x : Int, y : Int }
gamepadsToArrows gamepads =
  case List.head gamepads of
    Nothing -> {x=0, y=0}
    Just gamepad ->
      case List.head gamepad.axes of
        Nothing -> Debug.crash "No x axis"
        Just x ->
          case List.tail gamepad.axes of
            Nothing -> Debug.crash "No y axis"
            Just rest ->
              case List.head rest of
                Nothing -> Debug.crash "No y axis2"
                -- I would prefer to keep the floats to be honest
                Just y -> Debug.log "gamepad" { x=(round x), y=(-1 * round y) }

delta = Signal.map (\t -> t/20) (fps 60)

-- MARIO
input = let keyboardArrows = (Signal.map2 (,) delta Keyboard.arrows)
            gamepadArrows = (Signal.map2 (,) delta (Signal.map gamepadsToArrows Gamepad.gamepads))
        -- couldn't make that first bit work
        --in  Signal.sampleOn delta (Signal.merge gamepadArrows keyboardArrows)
        in  Signal.sampleOn delta gamepadArrows
        --in  Signal.sampleOn delta keyboardArrows

main = Signal.map2 render Window.dimensions (Signal.foldp step mario input)

