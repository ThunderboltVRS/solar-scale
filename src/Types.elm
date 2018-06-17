module Types exposing (..)

import Material
import Time exposing (Time, second, millisecond)


type Msg
    = Mdl (Material.Msg Msg)
    | Scrolling Float
    | KeyPress Int
    | Tick Time


type alias Vector =
    { x : Float
    , y : Float
    }


type alias Model =
    { mdl : Material.Model
    , solarBodies : List SolarBody
    , scale : Float
    , position : Vector
    , zoomScaleFactor : Float
    , moveScaleFactor : Float
    , movementVector : Vector
    , movementDragFactor : Float
    , layout : Layout
    }


type alias SolarBody =
    { name : String
    , diameter : Float
    , distanceFromSun : Float
    , colour : String
    }


type alias Layout =
    { height : Int
    , width : Int
    }
