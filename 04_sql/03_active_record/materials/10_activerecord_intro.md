# Intro to Active Record

## Model classes and `ActiveRecord::Base`

For each table, we define a Ruby **model** class; an instance of the model will represent an individual row in the table. For instance, a `physicians` table will have a corresponding `Physician` model class; when we fetch rows from the `physicians` table, we will get back `Physician` objects. All model classes extend `ApplicationRecord`, which in turn extends `ActiveRecord::Base`. Methods in `ActiveRecord::Base` will allow us to fetch and save Ruby objects from/to the table.

Rails comes with the following `application_record.rb` in our `models` folder:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

Our `ApplicationRecord` will act as an intermediary class that we use to extend our model classes with `ActiveRecord::Base`. (Rails uses this intermediary class to avoid being in situations where we would have to include modules directly on `ActiveRecord::Base`. `ApplicationRecord` essentially keeps `ActiveRecord::Base` clean.)

If we had a table named `physicians`, we would create a model class like so:

```ruby
# app/models/physician.rb
class Physician < ApplicationRecord
end
```

By convention, we define this class in `app/models/physician.rb`. The `app/models` directory is where Rails looks for model classes.

The `ActiveRecord::Base` class has lots of magic within it. For one, the name of the class is important; ActiveRecord is able to infer from the class name `Physician` that the associated table is `physicians`. Model classes are always singular (just like tables are always plural): respect the connection so ActiveRecord knows how to make the connection between the two worlds.

### `::find` and `::all`

The first methods we'll learn are for fetching records from the DB:

```ruby
# return an array of Physician objects, one for each row in the physicians table
Physician.all

# lookup the Physician with primary key (id) 101
Physician.find(101)
```

### `::where` queries

Often we want to look up records by some criteria other than primary key. To do this, we use `::where`:

```ruby
# return an array of Physicians based in La Jolla
Physician.where('home_city = ?', 'La Jolla')

# Executes:
#   SELECT *
#     FROM physicians
#    WHERE physicians.home_city = 'La Jolla'
```

Note the **SQL fragment** that is passed to `::where`. This condition will form the `WHERE` SQL condition. We continue to use the `?` interpolation character so as to avoid the Bobby Tables (colloquially called **SQL injection**) attack.

#### WHERE Rails = Magic

ActiveRecord lets you query without SQL fragments:

```ruby
Physician.where(
  home_city: 'La Jolla'
)
```

ActiveRecord will look at the hash and construct a `WHERE` fragment requiring `home_city = 'La Jolla'`. Here's some other cool versions:

```ruby
# physicians at any of these three schools
Physician.where(college: ['City College', 'Columbia', 'NYU'])
# => SELECT * FROM physicians WHERE college IN ('City College', 'Columbia', 'NYU');

# physicians with 3-9 years experience
Physician.where(years_experience: (3..9))
# => SELECT * FROM physicians WHERE years_experience BETWEEN 3 AND 9
```

These extra features are really handy when you need to dynamically generate complex queries, but they can get a little crazy, so there's no shame in writing SQL fragments instead; just be sure you interpolate properly!

### Updating and inserting rows

By extending `ActiveRecord::Base` through `ApplicationRecord`, your model class will automatically receive getter/setter methods for each of the database columns. This is convenient, since you won't have to write `attr_accessor` for each column. Here we construct a new `Physician` and set some appropriate fields:

```ruby
# create a new Physician object
jonas = Physician.new

# set some fields
jonas.name = 'Jonas Salk'
jonas.college = 'City College'
jonas.home_city = 'La Jolla'
```

Great! As you know from your previous AA Questions project, this will not have saved `jonas` to the Database. To do so, we need to call the `ActiveRecord::Base#save!` method:

```ruby
# save the record to the database
jonas.save!
```

Notice that I use `#save!`; you may have also seen the plain ol' `#save`. The difference between the two is that `#save!` will warn you if you fail to save the object, whereas `#save` will quietly return `false` (it returns `true` on success).

To save some steps of `#save!`, we can use `#create!` to create a new record and immediately save it to the db:

```ruby
Physician.create!(
  name: 'Jonas Salk',
  college: 'City College',
  home_city: 'La Jolla'
)
```

### Destroying data

Finally, we can destroy a record and remove it from the table through `#destroy`:

```
physician.destroy
```

## The Rails consoles

Okay! Let's say you want to start playing with your Rails application. In other applications, we started up a REPL by running the `pry` command.

To do likewise in Rails, run `rails console` (or `rails c` for the impatient). I've told you to add the `pry-rails` gem so you still get the `pry` sweetness you've become accustomed to.

The only big difference between `rails console` and `pry`/`irb` is that the console will take care of loading your Rails application so you won't have to `require` your model classes manually. It will also open up a connection to the DB for you. This is handy, because you can immediately start playing with your app, rather than first requiring and loading a bunch of supporting classes.

Another trick: you're used to using `load` to re-load source code from the console. In the Rails console, run the `reload!` command; this will re-load all the model classes.

If you want to access a SQL console, you may conveniently run `rails dbconsole`.