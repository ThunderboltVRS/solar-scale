module Update exposing (..)

import Types exposing (..)
import Char
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.Mdl msg ->
            Material.update Mdl msg model

        Tick dt ->
            ( step dt model, Cmd.none )

        Types.Scrolling scrollAmount ->
            ( updateScale model scrollAmount, Cmd.none )

        KeyPress key ->
            ( handleKeyboardEvent model key, Cmd.none )


updateScale : Model -> Float -> Model
updateScale model scrollAmount =
    let
        updatedScale =
            model.scale + (scrollAmount * model.zoomScaleFactor)
    in
        if (not (isNaN updatedScale) && not (isInfinite updatedScale)) then
            { model | scale = clamp 0.00001 0.01 updatedScale }
        else
            model


updatePosition : Model -> Vector -> Model
updatePosition model changeVector =
    { model | position = addVectors model.position changeVector }


updateMovementVector : Model -> Vector -> Model
updateMovementVector model changeVector =
    { model | movementVector = addVectors model.movementVector changeVector }


addVectors : Vector -> Vector -> Vector
addVectors vectorA vectorB =
    { vectorA | x = vectorA.x + vectorB.x, y = vectorA.y + vectorB.y }


scaleVector : Float -> Vector -> Vector
scaleVector scaleFactor vector =
    { vector | x = scaleFactor * vector.x, y = scaleFactor * vector.y }


handleKeyboardEvent : Model -> Int -> Model
handleKeyboardEvent model key =
    let
        _ =
            Debug.log "Value: " ((toString (Char.fromCode key)))
    in
        case Char.fromCode key of
            -- 'w' ->
            --     updateMovementVector model { x = 0, y = model.moveScaleFactor }
            'a' ->
                updateMovementVector model { x = model.moveScaleFactor, y = 0 }

            'd' ->
                updateMovementVector model { x = -model.moveScaleFactor, y = 0 }

            -- 's' ->
            --     updateMovementVector model { x = 0, y = -model.moveScaleFactor }
            'q' ->
                updateScale model -50

            'e' ->
                updateScale model 50

            _ ->
                model


step : Float -> Model -> Model
step dt model =
    updatePosition (applyDrag dt model) (scaleVector dt model.movementVector)


applyDrag : Float -> Model -> Model
applyDrag dt model =
    { model | movementVector = applyDragToVector dt model.movementDragFactor model.movementVector }


applyDragToVector : Float -> Float -> Vector -> Vector
applyDragToVector dt dragFactor vector =
    { vector | x = (1 - (dt * dragFactor)) * vector.x, y = (1 - (dt * dragFactor)) * vector.y }
