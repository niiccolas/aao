# Heredocs

We know how to format SQL code in a `.sql` file, but what if we mix SQL into our Ruby code? The answer is to use a **heredoc** to write multi-line strings with ease:

```sqlite
query = <<-SQL
SELECT
  *
FROM
  posts
JOIN
  comments ON comments.post_id = posts.id
SQL

db.execute(query)
```

This replaces `<<-SQL` with the text on the next line, up to the closing `SQL`. We could use any string for the start and end of a heredoc; `SQL` is just the convention when we are embedding SQL code.

A heredoc produces a string just like quotes does, and it will return into the place where the opening statement is. For example, this works as well:

```sqlite
db.execute(<<-SQL, post_id)
SELECT
  *
FROM
  posts
JOIN
  comments ON comments.post_id = posts.id
WHERE
  posts.id = ?
SQL
```

Notice the use of the `?` interpolation mark; the Ruby variable `post_id` will be inserted into the query at the `?`.

It is also possible to pass variables to a query using key-value pairs.

```sqlite
db.execute(<<-SQL, post_id: post_id)
SELECT
  *
FROM
  posts
JOIN
  comments ON comments.post_id = posts.id
WHERE
  posts.id = :post_id
SQL
```

In this case, the corresponding value is inserted in the query in place of the symbol `:post_id`.

What's the difference between using a `?` versus a key-value pair? Values bound to the `?` are done so positionally. So the first argument passed to a heredoc corresponds to the first `?` in your SQL query code.

On the other hand in key-value pairs the key acts as the placeholder for its corresponding value variable. The order of key-value pair arguments doesn't matter as a result.

If you use a `?` or key-value pair to pass in variables to a SQL query, SQLite3 will help protect against SQL injection attempts by escaping potentially malicious code for you.

## Reference

- [Source](https://makandracards.com/makandra/1675-using-heredoc-for-prettier-ruby-code)

You can use [heredoc](http://en.wikipedia.org/wiki/Here_document) to avoid endlessly long lines of code that nobody can read. It looks like this:

```ruby
def long_message
  puts(<<-EOT)
    Here goes a very long message...
    Sincerely,
    Dr. Foobear
  EOT
end
```

`<<-EOT` will be somewhat of a placeholder: anything you write in the line after you used it will be its value until you write `EOT` in a single line.

You can use any string to flag your heredocs. To be more verbose you can use something else – your IDE may even be aware of it, for example *RubyMine* understands `<<-SQL`, `<<-HTML`, `<<-XML`, `<<-JSON`, etc and highlights correctly.

### Multiple heredocs in one line

Now what if you want to do this more than once per line? Easy:

```ruby
def long_messages
  html_escape(<<-ONE) + '<hr />' + html_escape(<<-TWO)
    Here goes my first very long message.
    Yeehaw!
  ONE
    This is the second message which is still long.
    It is long indeed.
  TWO
end
```

### `<<-` vs `<<`

You can also omit the dash and just write `<<EOT` – if you do this, your terminating sequence **must** be at the very beginning of the line. It's less pretty:

```ruby
def foo
  stuff do
    something(<<-EOT) + something_else
      Here goes my content.
    EOT
    # vs:
    something(<<EOT) + something_else
      Here goes my content.
EOT
  end
end
```

### Notes & Caveats

- **Important:** I somewhat cheated here. Any spaces from the beginning of a line will be part of the string:

  ```ruby
  puts <<-EOT
    Hello Universe # two empty space at the beginning
  EOT
  # => "  Hello Universe\n" 
  ```

  In many cases this is not a problem, e.g. when you want to pretty up many lines of monstrous SQL you would not care. Whenever you require one very specific string, like in specs, and if indentation causes you trouble, do not indent or just use [a small method to strip leading spaces](https://makandracards.com/makandra/4765-remove-leading-spaces-from-indented-strings) like `#strip`, `#lstrip`, `#squish`, etc.

- Using heredoc you will have a linebreak after the last line. This can cause trouble (again, like when used in specs). You can hack around it by saying `<<-EOT.sub(/\n$/, '')`.

- You can use regular string interpolation inside heredoc:

  ```ruby
  puts <<EOT
  Dear #{user.name},
  ...
  EOT
  ```