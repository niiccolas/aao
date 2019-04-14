-- FOREIGN KEY CONSTRAINT FOR DATA INTEGRITY
PRAGMA foreign_keys = ON;

-- ERASE PREVIOUS TABLES, IF ANY
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

-- SEED DB
-- users (HAS MANY questions)
CREATE TABLE users (
  id    INTEGER      PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Wendy', 'Glover'),
  ('Gina', 'Ratke'),
  ('Owen', 'Greenholt'),
  ('Arlie', 'Russel');

-- questions (BELONGS TO users)
CREATE TABLE questions (
  id        INTEGER      PRIMARY KEY,
  title     VARCHAR(255) NOT NULL,
  body      TEXT         NOT NULL,
  author_id INTEGER      NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Gina: Ruby stil relevant?',
   "Hi everyone. My name is Gina. Why are we learning Ruby since it is dead?",
   (SELECT id FROM users WHERE fname = 'Gina' AND lname = 'Ratke')),

  ('Gina: NodeJS FTW',
   "I mean, everyone is doing it right?",
   (SELECT id FROM users WHERE fname = 'Gina' AND lname = 'Ratke')),

  ('Wendy: Mentorship plan?',
   "Kind of curious what your experiences are with the plan",
   (SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover')),

  ('Owen: Roommates',
   "Hey guys! My name is Owen and I’m looking to move to SF from Arizona if I get accepted into App Academy. I'm looking for roommates who love accuracy and use tabs",
   (SELECT id FROM users WHERE fname = 'Owen' AND lname = 'Greenholt'));

-- question_follows (MANY questions TO MANY followers)
CREATE TABLE question_follows (
  id          INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id     INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
   (SELECT id FROM questions WHERE title = 'Owen: Roommates')),

  ((SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
   (SELECT id FROM questions WHERE title = 'Gina: NodeJS FTW')),

  ((SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
   (SELECT id FROM questions WHERE title = 'Gina: Ruby stil relevant?')),

  ((SELECT id FROM users WHERE fname = 'Gina' AND lname = 'Ratke'),
   (SELECT id FROM questions WHERE title = 'Owen: Roommates')),

  ((SELECT id FROM users WHERE fname = 'Arlie' AND lname = 'Russel'),
   (SELECT id FROM questions WHERE title = 'Owen: Roommates')),

  ((SELECT id FROM users WHERE fname = 'Owen' AND lname = 'Greenholt'),
   (SELECT id FROM questions WHERE title = 'Gina: Ruby stil relevant?'));

-- replies
CREATE TABLE replies (
  id              INTEGER PRIMARY KEY,
  question_id     INTEGER NOT NULL,
  parent_reply_id INTEGER, -- first reply has no parent_reply, hence NULL
  user_id         INTEGER NOT NULL,
  body            TEXT    NOT NULL,

  FOREIGN KEY (question_id)     REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id)         REFERENCES users(id)
);

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  (
    (SELECT id FROM questions WHERE title = 'Owen: Roommates'),
    NULL,
    (SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
    "Hi Owen, not to pick a fight here, but if you really care about precision, wouldn’t you use spaces? But whatever. Once it goes through the compiler, it’s the same thing. Right?"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Owen: Roommates'),
    1,
    (SELECT id FROM users WHERE fname = 'Gina' AND lname = 'Ratke'),
    "An analysis of the top 400,000 GitHub repositories showed that spaces were by far the most popular method of indenting, in every language. Except Go and C."
  ),
  (
    (SELECT id FROM questions WHERE title = 'Owen: Roommates'),
    1,
    (SELECT id FROM users WHERE fname = 'Owen' AND lname = 'Greenholt'),
    "I do not get why anyone would use spaces over tabs. I mean why not just use Vim over Emacs!!!"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Owen: Roommates'),
    3,
    (SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
    "I do use Vim over Emacs"
  );

-- question_likes
CREATE TABLE question_likes (
  id          INTEGER PRIMARY KEY,
  user_id     INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id)     REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Wendy' AND lname = 'Glover'),
   (SELECT id FROM questions WHERE title = 'Owen: Roommates')),

  ((SELECT id FROM users WHERE fname = 'Gina' AND lname = 'Ratke'),
   (SELECT id FROM questions WHERE title = 'Wendy: Mentorship plan?')),

  ((SELECT id FROM users WHERE fname = 'Arlie' AND lname = 'Russel'),
   (SELECT id FROM questions WHERE title = 'Owen: Roommates'));