# ATTAC STAT TRACKER

Welcome to the ATTAC Stat Tracker.

## Short Description
ATTAC is a CLI app that provides a user with the ability to keep track of their basketball performance. The user is enabled with a full CRUD capacity - Create, Read, Update and Delete (their stats).

## User Stories
- As a user, I want to create a game so I can log my stats for that game.
- As a user, I want to update my stats so that they are corrected.
- As a user, I want retrieve my stats so I can assess my performance.
- As a user, I want to delete a my game in case of any input errors.

## Install Instructions
ATTAC uses the following gems: sinatra-activerecord, sqlite3, faker, pry, rake, require_all, csv, colorize. In order to install these gems, just type - "bundle install" in the project folder.

## Project Layout
* app - contains model and instance methods for the models
* bin - contains run file where testing can be done for future contributors
* csv - contains csv files for a few players to load fake data into the CLI app
* db - contains migration information as well as seeds.rb file to upload csv files into the database
* lib - contains two files; one that configures the interaction in the CLI and one that provides methods to facilitate the user interactions

## Run Instructions
In order to run this CLI app, type 'ruby attac.rb' into your terminal within this project folder.

## License
This software is available under the following licenses:
 * MIT
