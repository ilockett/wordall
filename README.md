# WordAll

### Description

The app uses the 2309 possible Wordle answers to display a random word. The user can choose to view more info on this word (definition, synonyms) or select a different random word.

### Running the App

The app needs an API key to obtain word details. This can be supplied on request. Add the API key into `WordService.swift` where indicated.

### Data/API Notes

* The Wordle words included were obtained from [this public repository](https://dagshub.com/arjvik/wordle-wordlist). These are stored in a text file included in the app's bundle.

* Definitions and synonyms are obtained using the [WordsAPI](https://www.wordsapi.com). As mentioned, this will only work when you add an API key into the app code.

### App Features

* Built using SwiftUI
* MVVM-C architecture
* SwiftUI-based Coordinator pattern
* Modern Swift features such as the `Observable` macro and `environment` modifier, `NavigationStack` and `async`/`await`.
* Includes Unit and UI tests
* Dark mode support
* Some accessibility consideration added (voice-over and dynamic font support)
* Consideration for layout on iPad
* No third-party dependecies user

### Other Notes

* The API Key would be handled differently in a "real" app and not just embedded as a default parameter. This could be obtained from a remote source such as Firebase Remote Config rather than being embedded in the app at all.

* There is reasonable amount of unit test coverage of the core stack (view models, repo and API service). There are a couple of UI tests that reference the two main screens in the app, but could be expanded much more.

* Some code to be able to use mock data in UI tests unfortunately has to be included in the main app code (albeit behind `#if DEBUG` statements so would not be compiled into the release binary). This is is not ideal, but have not found an alternative to this.

* Features I would expect to see in a production app have not been added. Features such as dependency injection, crash reporting, analytics, linting and CI.
