# Validations

## Overview

This guide teaches you how to validate that objects are correctly filled out before they go into the database. Validations are used to ensure that only valid data is saved into your database. For example, it may be important to your application to ensure that every user provides a valid email address and mailing address. Validations keep garbage data out.

### Validations vs. Constraints

We need to make an important distinction here. Rails **validations** are **not** the same as database **constraints**, though they are conceptually similar. Both try to ensure data integrity and consistency, but **validations** operate in your Ruby code, while **constraints** operate in the database. So the basic rule is:

- **Validations** are defined inside **models**.
- **Constraints** are defined inside **migrations**.

#### Use Constraints

We've seen how to write some database constraints in SQL (`NOT NULL`, `FOREIGN KEY`, `UNIQUE INDEX`). These are enforced by the database and are very strong. Not only will they keep bugs in our Rails app from putting bad data into the database, they'll also stop bad data coming from other sources (SQL scripts, the database console, etc). We will frequently use simple DB constraints like these to ensure data consistency.

However, for complicated validations, DB constraints can be tortuous to write in SQL. Also, when a DB constraint fails, a generic error is thrown to Rails (`SQLException`). In general, Rails will not handle errors like these, and a web user's request will fail with an ugly `500 Internal Server Error`.

#### Use Validations

For this reason, DB constraints are not appropriate for validating user input. If a user chooses a previously chosen username, they should not get a 500 error page; Rails should nicely ask for another name. This is what *model-level validations* are good at.

Model-level validations live in the Rails world. Because we write them in Ruby, they are very flexible, database agnostic, and convenient to test, maintain and reuse. Rails provides built-in helpers for common validations, making them easy to add. Many things we can validate in the Rails layer would be very difficult to enforce at the DB layer.

#### Use Both!

Often you will use both together. For example, you might use a `NOT NULL`constraint to guarantee good data while also taking advantage of the user messaging provided by a corresponding `presence: true` validation.

Perhaps a better example of this would be uniqueness. A `uniqueness: true`validation is good for displaying useful feedback to users, but it cannot actually guarantee uniqueness. It operates inside a single server process and doesn't know what any other servers are doing. Two servers could submit queries to the DB with conflicting data at the same time and the validation would not catch it (This happens *surprisingly often*). Because a `UNIQUE` constraint operates in the database and not in the server, it will cause one of those requests to fail (albeit gracelessly), preserving the integrity of your data.

## When does validation happen?

Whenever you call `save`/`save!` on a model, ActiveRecord will first run the validations to make sure the data is valid to be persisted permanently to the DB. If any validations fail, the object will be marked as invalid and Active Record will not perform the `INSERT` or `UPDATE` operation. This keeps invalid data from being inserted into the database.

To signal success saving the object, `save` will return `true`; otherwise `false` is returned. `save!` will instead raise an error if the validations fail.