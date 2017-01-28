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
import Random


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type Note
    = C
    | D
    | E
    | F
    | G
    | A
    | B


type alias Model =
    { note : Note
    , position : Int
    , correct : Int
    , incorrect : Int
    }



-- The first note initialized in the model is always middle C.


initialModel =
    Model C 4 0 0


init : ( Model, Cmd Msg )
init =
    ( initialModel, renderStaff (newNote initialModel.note initialModel.position) )



-- UPDATE


type Msg
    = NewNote Note
    | Answer Note
    | RandomNote



-- Sends a string representing a note value to Javascript for rendering


port renderStaff : String -> Cmd msg



-- Generates a note corresponding to an integer for random note generation


noteMapping : Int -> Note
noteMapping int =
    case int of
        1 ->
            C

        2 ->
            D

        3 ->
            E

        4 ->
            F

        5 ->
            G

        6 ->
            A

        _ ->
            B



-- Takes a note and a position and returns a string suitable for rendering


newNote : Note -> Int -> String
newNote note position =
    (toString note) ++ (toString position) ++ "/w"



-- Helper for handling NewNote updates. Ensures that a diff note is generated each time


newNoteMsg : Note -> Model -> ( Model, Cmd Msg )
newNoteMsg noteValue model =
    if noteValue == model.note then
        ( model, randomNoteCmd )
    else
        ( { model | note = noteValue }, renderStaff (newNote noteValue model.position) )


answerMsg : Note -> Model -> ( Model, Cmd Msg )
answerMsg noteValue model =
    if noteValue == model.note then
        ( { model | correct = model.correct + 1 }, randomNoteCmd )
    else
        ( { model | incorrect = model.incorrect + 1 }, randomNoteCmd )



-- Generates a random integer mapping to a note via noteMapping


note : Random.Generator Note
note =
    Random.map noteMapping (Random.int 1 7)



-- Generates a NewNote command using the note function to get a random note mapping


randomNoteCmd : Cmd Msg
randomNoteCmd =
    Random.generate NewNote note


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewNote noteValue ->
            newNoteMsg noteValue model

        Answer noteValue ->
            answerMsg noteValue model

        RandomNote ->
            ( model, randomNoteCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ viewStaff
        , viewAnswerButton C
        , viewAnswerButton D
        , viewAnswerButton E
        , viewAnswerButton F
        , viewAnswerButton G
        , viewAnswerButton A
        , viewAnswerButton B
        , viewRandomButton
        , viewCorrect model
        , viewIncorrect model
        ]


viewCorrect : Model -> Html Msg
viewCorrect model =
    div [] [ text ("Correct (" ++ (toString model.correct) ++ ")") ]


viewIncorrect : Model -> Html Msg
viewIncorrect model =
    div [] [ text ("Incorrect (" ++ (toString model.incorrect) ++ ")") ]


viewStaff : Html Msg
viewStaff =
    div [ id "staff" ] []


viewRandomButton : Html Msg
viewRandomButton =
    button
        [ onClick RandomNote ]
        [ text "Random Note" ]


viewAnswerButton : Note -> Html Msg
viewAnswerButton noteValue =
    button
        [ onClick (Answer noteValue)
        ]
        [ text (toString noteValue)
        ]
