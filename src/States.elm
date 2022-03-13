module States exposing (..)

import Types exposing (..)
import Material
import Keyboard exposing (..)
import AnimationFrame


initialModel : ( Model, Cmd Msg )
initialModel =
    ( defaultModel, Cmd.none )


defaultModel : Model
defaultModel =
    { mdl = Material.model
    , solarBodies = [ sun, mercury, venus, earth, moon, mars, jupiter, saturn, uranus, neptune, pluto ]
    , scale = 0.001
    , position = { x = 0, y = 0 }
    , zoomScaleFactor = 0.000001
    , moveScaleFactor = 0.5
    , movementDragFactor = 0.0015
    , layout = layout
    , movementVector = { x = 0, y = 0 }
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs Tick
        , Keyboard.presses KeyPress
        ]


layout : Layout
layout =
    { width = 1000
    , height = 1000
    }



-- List Of Bodies --


sun : SolarBody
sun =
    { name = "The Sun"
    , diameter = 696000
    , distanceFromSun = 0
    , colour = "yellow"
    }


mercury : SolarBody
mercury =
    { name = "Mercury"
    , diameter = 4879
    , distanceFromSun = 500000
    , colour = "grey"
    }


venus : SolarBody
venus =
    { name = "Venus"
    , diameter = 12104
    , distanceFromSun = 1000000
    , colour = "yellow"
    }


earth : SolarBody
earth =
    { name = "Earth"
    , diameter = 12756
    , distanceFromSun = 1500000
    , colour = "blue"
    }


moon : SolarBody
moon =
    { name = "The Moon"
    , diameter = 3475
    , distanceFromSun = 1700000
    , colour = "grey"
    }


mars : SolarBody
mars =
    { name = "Mars"
    , diameter = 6792
    , distanceFromSun = 2000000
    , colour = "red"
    }


jupiter : SolarBody
jupiter =
    { name = "Jupiter"
    , diameter = 142984
    , distanceFromSun = 2500000
    , colour = "orange"
    }


saturn : SolarBody
saturn =
    { name = "Saturn"
    , diameter = 120536
    , distanceFromSun = 3000000
    , colour = "gold"
    }


uranus : SolarBody
uranus =
    { name = "Uranus"
    , diameter = 51118
    , distanceFromSun = 3500000
    , colour = "blue"
    }


neptune : SolarBody
neptune =
    { name = "Neptune"
    , diameter = 49528
    , distanceFromSun = 4000000
    , colour = "blue"
    }


pluto : SolarBody
pluto =
    { name = "Pluto"
    , diameter = 2370
    , distanceFromSun = 4500000
    , colour = "brown"
    }
