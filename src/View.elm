module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Material.Color as Color
import Material.Scheme
import Material.Color
import Material.Options exposing (Style, css)
import Material.Layout as Layout
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Wheel
import Html.Events exposing (on)
import Json.Decode as Json


view : Model -> Html Msg
view model =
    div
        [ Wheel.onWheel (\event -> Scrolling event.deltaY)
        ]
        [ display model
        ]


display : Model -> Html Msg
display model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = []
        , drawer = []
        , tabs = ( [], [] )
        , main =
            [ additionalCSS
            , div
                [ Html.Attributes.style [ ( "height", "100%" ), ( "width", "100%" ), ( "outline", "none" ), ( "background-color", "black" ) ]
                , Html.Attributes.id "maindiv"
                ]
                [ mainDrawingArea model ]
            ]
        }
        |> Material.Scheme.topWithScheme Material.Color.Blue Material.Color.LightBlue


mainDrawingArea : Model -> Svg.Svg msg
mainDrawingArea model =
    Svg.svg
        [ Svg.Attributes.width "100%"
        , Svg.Attributes.height "100%"
        , Svg.Attributes.style "background-color: none"
        , Svg.Attributes.viewBox "0 0 1000 1000"
        ]
        (renderSolarBodies model)


renderSolarBodies : Model -> List (Svg.Svg msg)
renderSolarBodies model =
    List.map (\e -> renderCircle model e) model.solarBodies


renderCircle : Model -> SolarBody -> Svg.Svg msg
renderCircle model solarBody =
    circle
        [ cx (toString (((solarBody.distanceFromSun) * model.scale) + (xPositionAdjustment model * model.scale * 1000) ))
        , cy (toString (yPositionAdjustment model))
        , r (toString ((solarBody.diameter / 2) * model.scale))
        , Html.Attributes.id solarBody.name
        , fill solarBody.colour
        , fillOpacity "1"
        ]
        [ Svg.title [] [ Html.text solarBody.name ] ]


xPositionAdjustment : Model -> Float
xPositionAdjustment model =
    model.position.x


yPositionAdjustment : Model -> Float
yPositionAdjustment model =
    (toFloat (model.layout.height) / 2) + model.position.y


additionalCSS : Html Msg
additionalCSS =
    Material.Options.stylesheet """
    .mdl-layout__content {
        height: 100% !important;
    }
  """
