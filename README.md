# Movie app

## Overview

* The Movie App is a straightforward application that presents a curated list of movies across four genres: Popular, Top Rated, Upcoming, and Now Playing. It leverages the The Movie Database (TMDB) API to fetch and display movie information.

## Features

* Multilingual Support: The app supports three languages - English, Russian, and French. Simply click on the flag to switch between languages.
* Genre Selection: Choose from four genres to tailor your movie preferences.
* Search Functionality: Easily search for specific movies within the app.

## Project Structure

* Constants

 consts.dart:_This file holds constant values such as language headers for API calls._
* Fetch

fetchData.dart: _Main file for initiating API calls upon app launch._

fetchMovie.dart: _API call for retrieving details of a specific movie, triggered by tapping on a movie on the main or search page._

fetchPictures.dart: 
_API call for fetching images related to a selected movie._

fetchActors.dart: _API call to gather information about the cast of a chosen movie, primarily utilized for obtaining their images._

fetchActorImages.dart: _API call to take pictures of an actor_

fetchActorData.dart: _API call to gather information about an actor_

* Pages

mainPage.dart: _Contains the core code, API calls, and other elements necessary for the main page, which is the default landing page when opening the app._

moviePage.dart: _Comprises the essential code and API calls required to display detailed information about a specific movie._

searchPage.dart: _Encompasses the necessary code and API calls for the search page to function seamlessly._

actorPage.dart: _Contains API call to take all the info about the actors e.g. their birth date, death date, biography_

* Main
main.dart: _The main entry point that launches all the code and files, initializing the application._