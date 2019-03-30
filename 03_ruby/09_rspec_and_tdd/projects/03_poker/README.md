# Poker

- ⏱ 6 hours

Today we will be using TDD to write a poker game, specifically [five card draw](http://en.wikipedia.org/wiki/Five-card_draw).

## Learning Goals

- Be able to define desired functionality, write specs, and then implement
- Know how to follow **red, green, refactor** TDD workflow
- Know how to create and use test doubles
- Know when to use `context` and `describe`

You'll want to use [betterspecs](http://betterspecs.org/) as a cheatsheet/reference. You'll also want to refer to the [reading on test doubles](https://open.appacademy.io/learn/full-stack-online-ruby/test-doubles) for help creating unit tests. Accessing this on GitHub? Use [this link](https://github.com/appacademy/curriculum/blob/master/ruby/readings/test-doubles.md).

## Rules

- Each player is dealt five cards.
- Players bet; each player may fold, see the current bet, or raise.
- In turn, each player can choose to discard up to three cards.
  - They are dealt new cards from the deck to replace their old cards.
- Players bet again.
- If any players do not fold, then players reveal their hands; [strongest hand](http://en.wikipedia.org/wiki/List_of_poker_hands) wins the pot.

## Design

Classes you will want:

- Card
- Deck
  - **Request a TA Code review**
- Hand
  - The logic of calculating pair, three-of-a-kind, two-pair, etc. goes here.
  - Logic of which hand beats which would go here.
- Player
  - Each player has a hand, plus a pot
  - Player has methods to ask the user:
    - Which cards they wish to discard
    - Whether they wish to fold, see, or raise.
- Game
  - Holds the deck
  - Keeps track of whose turn it is
  - Keeps track of the amount in the pot.