# Rolling back migrations

We'll start off this reading with a warning: **We strongly discourage students from ever rolling back. This is because rolling back is not an option when working on something in production.** That being said- this reading exists to teach you about what rolling back is and how it can be used. Occasionally you will make a mistake when writing a migration. If you have already run the migration then you cannot just edit the migration and run the migration again: Rails will think it has already run the migration and so will do nothing when you run `rails db:migrate`. That's because the timestamp is in `schema_migrations`.

You must first *roll back* the migration, which reverses the change (by calling the `down`), if that is possible. This will undo the changes and remove the timestamp from `schema_migrations`.

It is a common mistake to begin editing the migration before rolling it back. Then, when you try to roll back, ActiveRecord tries to rollback the migration **as it is currently written**. This causes problems because the edited migration does not correspond to the migration that was actually previously run. You need to be careful of this: wait until after rollback to edit.

To rollback the most recent migration, run `rails db:rollback`. You may now edit the migration file and rerun.