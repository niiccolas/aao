# Homework

**Let's create a simple Rails project and try out what we've learned so far!**

In this project we'll be creating a simple Rails project to model the relationships between people and houses. By the end of this project, each `Person` will live in a house and each `House` will have an `address`. You will be able to call `House.residents` and get a list of the `people` that live in that `House`. You will also be able to call `Person.house` and get the `House` that that `Person`lives in. **Pro Tip: Refer to the Readings Often**

## Phase 1: `rails new`

- Create a new rails project using PostgreSQL
  - Remember to create the database!
  - Remember that you need to have Postgres running in the background!

## Phase 2: Create Models and Migrations

- Create a `Person` model and a `people` table (each `Person` should have a `name` and a `house_id`)

  - You will need to create and run a Migration for each model. (Refer to the Migration Reading if you need a reminder!)
  - You will need to create a file called `model_name.rb` in `/app/models/` for each model.
  - For each model, you should validate the presence of each of the attributes that model can have. (Refer to the Basic Validations Readings if you would like to see an example)

- Create a `House` model and a `houses` table (each `House` should have an `address`).

## Phase 3: Create associations

- Create Associations for `Houses` with `People` such that `Houses` can have many `#residents` and each `Person` belongs to a `#house`. (Refer to the readings for belongs_to and has_many.)

  - This relies on you specifying the correct `primary_key`, `foreign_key`, and `class_name`; otherwise, when you call `House.residents`, Rails will assume you are following conventions and look for a `residents` table rather than a `people` table!

## Phase 4: Try it out!

- Use the [`rails console`](https://open.appacademy.io/learn/full-stack-online/full-stack-online-sql/orm-review-and-intro-to-active-record) (Search this reading for `rails console`) to create some data and run some basic queries. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/sql/readings/orm.md).

- You should be able to run the following:

  ```ruby
  house = House.new(address: '308 Negra Arroyo Lane')
  person = Person.new(name: 'Walter White', house_id: house.id)

  house.save!
  person.save!
  ```