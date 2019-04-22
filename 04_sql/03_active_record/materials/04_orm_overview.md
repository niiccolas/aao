# Object Relational Mapping

## Overview

### Motivation

We've discussed how to manage changes to a SQL database through migrations. Now we'd like to start using the records stored in that database.

We've previously worked directly with a database by writing SQL. One downside was that this embedded SQL code is in our Ruby code. Though this works, it would be nice to use Ruby syntax as much as possible.

Also, when we fetched data from our SQL database, the data was returned in generic `Hash` objects. For instance, if our database was setup like this:

```
  CREATE TABLE cars (make VARCHAR(255), model VARCHAR(255), year INTEGER);
  INSERT INTO cars (model, make, year)
    ("Toyota", "Camry", 1997),
    ("Toyota", "Land Cruiser", 1989),
    ("Citroen", "DS", 1969);
```

And we wrote the following ruby code to fetch the data:

```
require 'sqlite3'
db = SQLite3::Database.new('cars.db')
db.results_as_hash = true
db.type_translation = true

cars = db.execute('SELECT * FROM cars')
# => [
#  {"make" => "Toyota", "model" => "Camry", "year" => 1997},
#  {"make" => "Toyota", "model" => "Land Cruiser", "year" => 1989},
#  {"make" => "Citroen", "model" => "DS", "year" => 1969}
# ]
```

That works nicely, but what if we wanted to store and load objects of a `Car`class? Instead of retrieving generic `Hash` objects, we want to get back instances of our `Car` class. Then we could call `Car` methods like `go` and `vroom`. How would we translate between the world of Ruby classes and rows in our database?

### What is an ORM?

An *object relational mapping* is the system that translates between SQL records and Ruby (or Java, or Lisp...) objects. The ActiveRecord ORM translates rows from your SQL tables into Ruby objects on fetch, and translates your Ruby objects back to rows on save. The ORM also empowers your Ruby classes with convenient methods to perform common SQL operations: for instance, if the table `physicians` contains a foreign key referring to `offices`, ActiveRecord will be able to provide your `Physician` class a method, `#office`, which will fetch the associated record. Using ORM, the properties and relationships of the objects in an application can be easily stored and retrieved from a database without writing SQL statements directly and with less overall database access code.