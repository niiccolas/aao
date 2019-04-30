# Indexing

Suppose we have a simple query:

```sqlite
SELECT *
FROM Users
WHERE Name = 'Mike'
```

Now think back to our Big-O discussion from last week and consider the time complexity for this query. If we have a table of 100 rows, it's going to have to check every one of those rows for the name `'Mike'`. This is referred to as a "table scan" and is `O(n)` time complexity. Now imagine that we actually have ten million users, and that we're making that query 100 times/sec. Our database is going to crash, our website will go down in flames, and our bosses will fire our sorry, non-optimizing behinds.

This is why it's important to index columns that are heavily used for lookups in queries. When you index a column, it creates a sorted data structure with pointers to the actual table. Since it's sorted, lookups can use binary search, which as you recall runs in `O(log n)` time. Log base 2 of 10 million is about 23, so as you can imagine, this improves database performance (and our career prospects) *dramatically*.

Remember though, before you go all index happy, that indices do have a cost. They make writes (`INSERT`s, `DELETE`s, and `UPDATE`s) a little more taxing because the index must be updated. Furthermore, optimizations made outside of the bottleneck are no optimizations at all. So it's important to index the *right* things, or you might as well have indexed *nothing*.

On that note, **foreign keys** are pretty much always a good choice for indexing because they're frequently used in both `WHERE` clauses and in `JOIN` conditions, both of which can be incredibly taxing when not indexed.

## Indexing a Foreign Key

Now let's consider a practical example.

```ruby
class User < ApplicationRecord
  has_many :conversations, foreign_key: :user_id
end

class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
end   
```

Given a `Conversation`, we can quickly lookup a `User` because `users.id` is the primary key, and the `primary key` is indexed by definition. But what about `User#conversations`?

`#conversations` is matching on the foreign key column `conversations.user_id`. Only primary keys come indexed out of the box, so the generated query (`SELECT * FROM conversations WHERE user_id = ?`) will require a full table scan. With a lot of conversations, this could prove perilous for our career.

The solution is to add an index in an ActiveRecord migration. We'll use the [`add_index`](http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index) method:

```ruby
class AddUserIdIndexToConversations < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, :user_id
  end
end
```

Indexing can be useful for more than just speeding up our queries, however. If we want to ensure that a column only holds unique values, we can provide the `unique` option to an index.

```ruby
class MakeUsernamesUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :username, unique: true
  end
end
```

We can even ensure the uniqueness of *combinations* of values, by passing an array instead of a single column name:

```ruby
class EnsureUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, [:user_id, :title], unique: true
  end
end
```

This ensures that there can be no more than one entry in the `conversations`table with the same `user_id` and `title` - useful if you want to allow multiple conversations to have the same title, but not for the same user.

Go on and harness the power of indexing!