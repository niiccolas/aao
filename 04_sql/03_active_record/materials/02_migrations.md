# Migrations

## Overview

We've discussed SQL databases, so we know that programs can store and pull out data from them. Data fetched from the DB can then be used to populate the attributes of Ruby objects.

As a program is written, the structure of the database will evolve. We would like some way to track the evolution of the database schema, so that this is tracked along with our code in our git repository.

Additionally, because we develop our app on our own machine, with our own local development database, but later deploy our application to a server running a production database, we need a way to record the transformations we've made locally, so that they may be "played back" and performed on the server database when we deploy our code.

Database *migrations* are a solution to these problems. A migration is a file containing Ruby code that describes a set of changes applied to the database. It may create or drop tables; it may add or remove columns from a table. Each new set of changes is written inside a new migration file, which is checked into the repository. ActiveRecord will take responsibility for performing the necessary migrations when you ask it.