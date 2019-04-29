# Initializing a Rails project with Postgres

This unit begins our foray into ActiveRecord; a component of Rails that is a way for your Ruby code to interact with a SQL database. ActiveRecord is a key component of Rails; after you master it, you will probably find the rest of Rails pretty straightforward.

- Make sure that Rails is installed:

  ```
  gem install rails -v '5.1.2'
  ```

- Generate a new Rails project:

  ```
  rails new demo_project -G
  ```

This will create a folder `demo_project`, with a bunch of Rails directories in them.

**By default, rails will also initialize your new project as a git repository. Adding the `-G` flag will instruct rails to create a project without making a new repository.** This will be useful to us since we'll frequently be creating rails projects inside of the repository for the day's projects and we want to avoid nesting repositories inside of other repositories. If you're making a repository for a single project, however, you can leave this flag off and rails will automatically set one up for you.

**NB**: If you're starting a new rails app and would like to use Postgres, you can specify the database flag when generating the app. This will add the correct gem and have sensible defaults in `config/database.yml`.

```
rails new demo_project -G --database=postgresql
```

- Add helpful gems for development.

  - Open up the `Gemfile` file (located in your new `demo_project` folder). Rails sets you up with a bunch of gems by default, but there are a few other gems we recommend that will make your life **much** easier. You should get in the habit of including the following gems to your `development` group:

  ```ruby
  group :development do
    # Run 'bundle exec annotate' in Terminal to add helpful comments to models.
    gem 'annotate'
  
    # These two give you a great error handling page.
    # But make sure to never use them in production!
    gem 'better_errors'
    gem 'binding_of_caller'
  
    # Gotta have byebug...
    gem 'byebug'
  
    # pry > irb
    gem 'pry-rails'
  end
  ```

  - This will allow us to do things like interact with our Rails project using the `pry`.

- Make sure you are in the `demo_project` directory and run `bundle install`.

  - This will look for `Gemfile` and then install gems listed in it.

## Postgres

As noted above, you can initialize a new Rails app with a Postgres database by using the `--database=postgresql` option. You can also **switch** an existing Rails app from SQLite to Postgres. This is convenient because differences between your development and production databases can be frustrating.

- If you have already created your SQLite database (ran `db:create`), then delete the `.sqlite3` files in `db/`.

- Replace the `gem 'sqlite3'` line in the `Gemfile` with `gem 'pg'`. Don't forget to `bundle install` after.

- Edit `config/database.yml` to use Postrgres.

  - Change the `default` environment:

  ```ruby
  default: &default
    adapter: postgresql
    pool: 5
    timeout: 5000
  ```

  - Create a database with the given name. Name your development, test, and production databases as shown below:

  ```ruby
  development:
    <<: *default
    database: project_name_development
  ```

- Create your new Postgres database

  - Run `bundle exec rails db:create`
  - If you have migrations, run `bundle exec rails db:migrate`
  - If you have seeds, run `bundle exec rails db:seed`