port module Notes exposing (..)

{-| Notes implemented in Elm, an app for learning the notes on the musical staff.

This application is broken up into three key parts:

  1. Model  - a full definition of the application's state
  2. Update - a way to step the application state forward
  3. View   - a way to visualize our application state with HTML

This clean division of concerns is a core part of Elm. You can read more about
this in <http://guide.elm-lang.org/architecture/index.html>
-}

import Html exposing (..)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { note : String
    , position : Int
    }



-- The first note initialized in the model is always middle C.


initialModel =
    Model "C" 4


init : ( Model, Cmd Msg )
init =
    ( initialModel, renderStaff (newNote initialModel.note initialModel.position) )



-- UPDATE


type Msg
    = NewNote String


port renderStaff : String -> Cmd msg


newNote : String -> Int -> String
newNote note position =
    note ++ (toString position) ++ "/w"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewNote noteValue ->
            ( { model | note = noteValue }, renderStaff (newNote noteValue model.position) )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ viewStaff
        , viewButton "C"
        , viewButton "D"
        , viewButton "E"
        , viewButton "F"
        , viewButton "G"
        ]


viewStaff : Html Msg
viewStaff =
    div [ id "staff" ] []


viewButton : String -> Html Msg
viewButton noteValue =
    button
        [ onClick (NewNote noteValue)
        ]
        [ text noteValue
        ]
