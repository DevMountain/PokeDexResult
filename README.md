# PokeDexResult

A Pokedex app that allows users to query for Pokemon.
API documentation can be found at `https://pokeapi.co`.

Learning objectives:
1) Locate the correct endpoint API documentation.
2) Know how to structure HTTP request and response model
3) Familiarity with URLSession

## Documentation
* Show students a finished copy of the app, determine which information is needed to create the app (name, ID, image).
* With help from the students and by looking at sample responses, find the correct endpoint.

## Model
* Focus on helping students understand the function of CodingKeys.
* (Decoding additional sprites may give more context to the CodingKeys enum)

## Model Controller
* Ensure students understand why there is no singleton + what `static` means.
* Help students understand the URL as it is being built.
* We call `.resume()` because otherwise the `dataTask` would stay paused.
* Without overwhelming students, you may choose to explain that `@escaping` completion handlers let us run code after the function ends/returns. (We unwrap `data` and `error` *after* `dataTask` returns from the internet. Likewise we update our UI by calling completion *after* uwrapping them.)

## Custom Error
* The custom error isn't a major objective of the lesson.
* Students should understand that we create cases in order to explain to our user what went wrong.
* `errorDescription` allows us to provide additional info to the user.

## UI
* Students need to understand that UI updates can only be made from the main thread.
* Help them understand how to switch on `Result`.

## Programmatic Branch

- This branch pretty much does everything that the normal finished branch does, with the exception of being built with programmatic views
- There is another file added with instruction on how to instruct students on deleting the storyboard and adding a new assigning a new window + scene to enter the app.
  