# RSPEC and Test Driven Development

## RSpec Syntax & Mechanics

RSpec is distributed in a gem called 'rspec', which is actually a meta-gem that packages three other gems: rspec-core, rspec-expectations, and rspec-mocks. We'll spend most of our time on rspec-core and rspec-expectations.

## File Organization

By convention, tests are kept in the `spec` folder and your application code will be kept in a `lib` folder. Tests for `hello.rb` will be written in a file called `hello_spec.rb`. Your directory structure should look like this:

    my_cool_project
      lib/
        hello.rb
      spec/
        hello_spec.rb

## Requiring Dependencies

Each spec will usually be limited to testing a single file and so will require the file at the top of the spec. It will also have to require the rspec gem.

    # hello_spec.rb

    require 'rspec'
    require 'hello'

    describe '#hello_world' do

    end

Note that RSpec will by default include the `lib/` folder in the require path so that we can use `require` and not `require_relative`. This is another reason to follow the convention of using `lib/` and `spec/` for your code and your tests, respectively.

## Organization & Syntax

Here's what a simple 'Hello, World!' spec might look like.

    # hello_spec.rb

    require 'rspec'
    require 'hello'

    describe "#hello_world" do
      it "returns 'Hello, World!'" do
        expect(hello_world).to eq("Hello, World!")
      end
    end

And the code that would make it pass:

    # hello.rb

    def hello_world
      "Hello, World!"
    end

### `describe` and `it`

`it` is RSpec's most basic test unit. All of your actual individual tests will go inside of an `it` block.

`describe` is RSpec's unit of organization. It gathers together several `it` blocks into a single unit, and, as we'll see, allows you to set up some context for blocks of tests.

Both `describe` and `it` take strings as arguments. For `describe`, use the name of the method you're testing (use "#method" for instance methods, and "::method" for class methods). For `it`, you should describe the behavior that you're testing inside that `it` block.

`describe` can also take a constant that should be the name of the class or module you're testing (i.e. `describe Student do`).

You can nest `describe` blocks arbitrarily deep. When nesting, also consider the use of `context`, which is an alias for `describe` that can be a bit more descriptive. Prefer `context` when it makes sense.

    describe Student do
      context 'when a current student' do
        ...
      end

      context 'when graduated' do
        ...
      end
    end

### expect

`describe` and `it` organize your tests and give them descriptive labels. `expect` will actually be doing the work of testing your code.

Its task is to _match_ between a value your code generates and an expected value. You can specify the way in which it will match.

There are negative and positive constructions:

    expect(test_value).to ...
    expect(test_value).to_not ...

There are two constructions to expect: with an argument and with a block. We'll prefer the argument construction except when the block construction is necessary.

    describe Integer do
      describe '#to_s' do
        it 'returns string representations of integers' do
          expect(5.to_s).to eq('5')
        end
      end
    end

The block construction is necessary when you want to test that a certain method call will throw an error:

    describe '#sqrt' do
      it 'throws an error if given a negative number' do
        expect { sqrt(-3) }.to raise_error(ArgumentError)
      end
    end

RSpec comes with a variety of matchers that come after `expect().to` or `expect().to_not`. The most common and staightforward matchers are straight equality matchers.

`expect(test_value).to eq(expected_value)` will see if `test_value == expected_value`. `expect(test_value).to be(expected_value)` will test if `test_value` is the same object as `expected_value`.

    expect('hello').to eq('hello') # => passes ('hello' == 'hello')
    expect('hello').to be('hello') # => fails (strings are different objects)

At this point, you know the absolute basics of RSpec's syntax. Head on over to the GitHub pages and read both of the READMEs. This is required reading.

*   [rspec-core](https://github.com/rspec/rspec-core)
*   [rspec-expectations](https://github.com/rspec/rspec-expectations) (note the variety of expectation matchers available to you)

Head back here once you're done.

### before

Welcome back! Hope you've learned a lot more about what RSpec allows you to do.

One thing that we often want to do is set up the context in which our specs will run. We usually do this in a `before` block.

    describe Chess do
      let(:board) { Board.new }

      describe '#checkmate?' do
        context 'when in checkmate' do
          before(:each) do
            board.make_move([3, 4], [2, 3])
            board.make_move([1, 2], [4, 5])
            board.make_move([5, 3], [5, 1])
            board.make_move([6, 3], [2, 4])
          end

          it 'should return true' do
            expect(board.checkmate?(:black)).to be true
          end
        end
      end
    end

`before` can be used as either `before(:each)` or `before(:all)`. You'll almost always use `before(:each)`. `before(:each)` will execute the block of code before each spec in that `describe` block. The nice thing about it is that state is not shared - that is, you start fresh on every spec, even if inside your spec (i.e. in your `it` block) you manipulate some object that the `before` block set up for you.

`before(:all)` on the other hand does share state across specs and for that reason, we avoid using it. It makes our tests a bit brittle by making specs dependent on one another (and dependent on the order in which specs are run).

There are also `after(:each)` and `after(:all)` counterparts.

### Pending Specs

Sometimes, you may want to write out a bunch of descriptions for specs without actually writing the bodies of those specs. If you simply leave the test bodies empty, it'll look like they're all passing. If you fail them, then it'll look like you actually have test code written that is currently failing.

What to do? Make the specs pending.

How?

Leave off the `do...end` from the `it`.

    describe '#valid_move?' do
      it 'should return false for wrong colored pieces'
      it 'should return false for moves that are off the board'
      it 'should return false for moves that put you in check'
    end

## Additional Notes

Don't use `!=`. Rspec does not support `expect(actual) != expected`. Instead use `expect(actual).to eq expected` or `expect(actual).to_not eq expected`.

On predicate syntatic sugar: With all predicates, you can strip off the ? and tack on a "be_" to make an expectation. For example, `expect(Array.empty?).to be true` is equivalent to `expect(Array).to be_empty`.

Note that RSpec can even conjugate verbs when necessary. For instance, to test that a Hash `has_key?`, you can simplify:

    expect(my_hash.has_key?(my_key)).to eq(true)

to:

    expect(my_hash).to have_key(my_key)

## Intro Assessment Spec

Go back to the spec from the intro assessment. Read the spec file and make sure everything makes sense to you.

## Additional Resources

*   The [RSpec docs](https://www.relishapp.com/rspec/rspec-core/v/2-4/docs) are a good resource. Knowing RSpec well will let you write beautiful specs. Note that the RSpec docs are specs themselves.

# subject and let

## `subject` and `it`

To test a class, you will often want to instantiate an instance of the object to test it out. In this case, you may want to define a `subject` for your tests.

    describe Robot do
      subject { Robot.new }

      it "satisfies some expectation" do
        expect(subject).to # ...
      end
    end

You can also declare a `subject` with a name:

    describe Robot do
      subject(:robot) { Robot.new }

      it "position should start at [0, 0]" do
        expect(robot.position).to eq([0, 0])
      end

      describe "move methods" do
        it "moves left" do
          robot.move_left
          expect(robot.position).to eq([-1, 0])
        end
      end
    end

In addition to the name, `subject` also accepts a block that constructs the subject. You can do any necessary setup inside the block.

The `it` block is a test. It runs the code, and the test fails if the `expect` fails. In the first test, we `expect` that the position is `[0, 0]`. In the second test we move the robot, and then expect the position to have changed.

## let

`subject` lets us define the subject of our tests. Sometimes we also want to create other objects to interact with the subject. To do this, we use `let`. `let` works just like `subject`, but whereas `subject` is the focus of the test, `let` defines helper objects. Another difference is that there can only be one (unnamed) `subject` (if you declare a second `subject`, the value of `subject` inside of your `it` blocks will use the more recent definition). On the other hand, you can define many helper objects through `let`.

    describe Robot do
      subject(:robot) { Robot.new }
      let(:light_item) { double("light_item", :weight => 1) }
      let(:max_weight_item) { double("max_weight_item", :weight => 250) }

      describe "#pick_up" do
        it "does not add item past maximum weight of 250" do
          robot.pick_up(max_weight_item)

          expect do
            robot.pick_up(light_item)
          end.to raise_error(ArgumentError)
        end
      end
    end

`let` defines a method (e.g. `light_item`, `max_weight_item`) that runs the block provided once for each spec in which it is called.

You may see that you have the option of using instance variables in a `before` block to declare objects accessible to specs, but we'll avoid defining instance variables in specs. Always prefer `let`. Here's a [SO post](http://stackoverflow.com/questions/5359558/when-to-use-rspec-let) that clearly describes why that is.

Here's a [blog post](http://benscheirman.com/2011/05/dry-up-your-rspec-files-with-subject-let-blocks/) with some nice examples using `let` - note how the author uses it in conjunction with `subject` (some fancy and clean stuff).

### `let` does not persist state

You might read that `let` memoizes its return value. Memoization means that the first time the method is invoked, the return value is cached and that same value is returned every subsequent time the method is invoked within the same scope. Since every `it` is a different scope, `let` does not persist state between those specs.

An example:

    class Cat
      attr_accessor :name

      def initialize(name)
        @name = name
      end
    end

    describe "Cat" do
      let(:cat) { Cat.new("Sennacy") }

      describe "name property" do
        it "returns something we can manipulate" do
          cat.name = "Rocky"
          expect(cat.name).to eq("Rocky")
        end

        it "does not persist state" do
          expect(cat.name).to eq("Sennacy")
        end
      end
    end

    # => All specs pass

# RSpec Order of Operations

RSpec is particular about the order in which we invoke its various methods. Look at this code:

    RSpec.describe Deck do
      describe '#initialize' do
        it 'initializes with 52 cards' do
          subject(:deck) { Deck.new } # nope
          expect(deck.count).to eq(52)
        end
      end
    end

Seems reasonable enough, right? But this won't run, and it doesn't give us a very helpful error message, either:

    1) Deck#initialize initializes with 52 cards
         Failure/Error: subject(:deck) { Deck.new }
         ArgumentError:
           wrong number of arguments (1 for 0)

The problem is that we are trying to declare our subject at the top of our `it` block; RSpec requires that the subject be declared outside of your `it` blocks. This test will run successfully:

    RSpec.describe Deck do
      describe '#initialize' do
        subject(:deck) { Deck.new } # yup

        it 'initializes with 52 cards' do
          expect(deck.count).to eq(52)
        end
      end
    end

This sort of ordering requirement applies to all of RSpec's methods; you can't just toss in a `describe`, `it`, `expect`, `subject`, `let`, or `before` block wherever you might naturally want to put it. RSpec enforces a hierarchy/ordering of its methods, and you need to arrange your blocks within the context of that structure. If you simply keep this in mind and emulate the patterns illustrated in previous chapters, you will be fine.

Below is an example of RSpec written with the correct order of operations:
```
RSpec.describe Sloth do
      subject(:sloth) { Sloth.new("Herald") }

      describe "#run" do
        context "when a valid direction is given" do
          it "returns a string that includes the direction" do
            expect(sloth.run("north")).to include("north")
          end
        end

        context "when an incorrect direction is given" do
          it "raises ArgumentError" do
            expect { sloth.run("somewhere") }.to raise_error(ArgumentError)
          end
        end

      end
    end
```
# Test Doubles

## A Preface of Great Interest

When we write unit tests, we want each of our specs to test just one thing. This can be a little complicated when we write classes that interact with other classes. For example, imagine:
```
    class Order
      def initialize(customer)
        @customer = customer
      end

      def send_confirmation_email
        email(
          to: @customer.email_address,
          subject: "Order Confirmation",
          body: self.summary
        )
      end
    end
```
Here an `Order` object needs a `Customer` object; the associated `Customer` object is used, for instance, when we try to call the `#send_confirmation_email`. In particular, if we want to test `#send_confirmation_email`, it looks like we'll have to supply `Order` a `Customer` object.
```
    RSpec.describe Order do
      subject(:order) do
        customer = Customer.new(
          :first_name => "Ned",
          :last_name => "Ruggeri",
          :email_address => "ned@appacademy.io"
        )
        Order.new(customer)
      end

      it "sends email successfully" do
        expect do
          subject.send_confirmation_email
        end.not_to raise_exception
      end
    end
```
This is troublesome because a spec for `#send_confirmation_email` should only test the `#send_confirmation_email` method, not `Customer#email_address`. But the way we've written this spec, if there's a problem with `Customer#email_address`, a spec for `Order#send_confirmation_email` will also break, even though it should have nothing to do with `Customer#email_address`. This will clutter up your log of spec failures.

Another problem is if `Order` and `Customer` both have methods that interact with the other. If we write the `Customer` specs and methods first, then we'll need a functioning `Order` object first for our `Customer` to interact with. But we're supposed to TDD `Order`; we'll need to have written specs for `Order`, but this requires a `Customer`...

Finally, it can be a pain to construct a `Customer` object; we had to specify a bunch of irrelevant fields here. Other objects can be even harder to construct, which means we can end up wasting a lot of time building an actual `Customer`, when an object that merely "looks like" a `Customer` would have been sufficient.

We want to write our tests in isolation of other classes: their bugs or whether they've even been implemented yet. The answer to this is to use **doubles**.

## Test doubles

A test double (also called a **mock**) is a fake object that we can use to create the desired isolation. A double takes the place of outside, interacting objects, such as `Customer`. We could write the example above like so:
```
    #IMPLEMENTATION
    class Order
        def initialize(customer, product)
            @customer = customer
            @product = product
        end

        def charge_customer
            @customer.debit_account(@product.cost)
        end
    end

    #RSPEC FILE
    RSpec.describe Order do
      let(:customer) { double("customer") }
      subject(:order) { Order.new(customer) }

      it "sends email successfully" do
        allow(customer).to receive(:email_address).and_return("ned@appacademy.io")

        expect do
          order.send_confirmation_email
        end.to_not raise_exception
      end
    end
```
We create the double by simply calling the `double` method (we give it a name for logging purposes). This creates an instance of `RSpec::Mocks::Mock`. The double is a blank slate, waiting for us to add behaviors to it.

A method **stub** stands in for a method; `Order` needs `customer`'s `email_address` method, so we create a stub to provide it. We do this by calling `allow(double).to receive(:method)`, passing a symbol with the name of the method that we want to stub. The `and_return` method takes the return value that the stubbed method will return when called as its parameter.

The `customer` double simulates the `Customer#email_address` method, without actually using any of the `Customer` code. This totally isolates the test from the `Customer` class; we don't use `Customer` at all. We don't even need to have the `Customer` class defined.

The `customer` object is not a real `Customer`; it's an instance of `Mock`. But that won't bother the `Order#send_confirmation_email` method. As long as the object that we pass responds to an `email_address` message, everything will be fine.

There's also a one-line version of creating a double and specifying stub methods.

    let(:customer) { double("customer", :email_address => "ned@appacademy.io") }

## Method Expectations

If the tested object is supposed to call methods on other objects as part of its functionality, we should test that the proper methods are called. To do this, we use method expectations. Here's an example:
```
    RSpec.describe Order
      let(:customer) { double('customer') }
      let(:product) { double('product', :cost => 5.99) }
      subject(:order) { Order.new(customer, product) }

      it "subtracts item cost from customer account" do
        expect(customer).to receive(:debit_account).with(5.99)
        order.charge_customer
      end
    end
```
Here we want to test that when we call `charge_customer` on an `Order` object, it tells the `customer` to subtract the item price from the customer's account. We also specify that we should check that we have passed `#debit_account` the correct price of the product.

Notice that we set the message expectation before we actually kick off the `#charge_customer` method. Expectations need to be set up in advance.

## Integration tests

Mocks let us write unit tests that isolate the functionality of a single class from other outside classes. This lets us live up to the philosophy of unit tests: in each spec, test one thing only.

Unit tests specify how an object should interact with other objects. For instance, our `Order#charge_customer` test made sure that the order sends a `debit_account` message to its customer.

What if the `Customer` class doesn't have a `#debit_account` method? Perhaps instead the method is called `Customer#subtract_funds`. Then in real life, with a real `Customer` object, our `Order#charge_customer` method will crash when it tries to call `#debit_account`. What spec is supposed to catch this error?

The problem here is a mismatch in the interface expected by `Customer` and the interface provided by `Order`. This kind of error won't be caught by a unit test, because the purpose of unit test is to test classes in isolation.

We need a higher level of testing that's intended to verify that `Order` and `Customer` are on the same page: that `Order` tries to call the right method on `Customer`, which does the thing that `Order` expects.

This kind of test is called an **integration test**. In integration tests, we use real objects instead of mocks, so that we can verify that all the classes interact correctly. A thorough test suite will have both unit and integration tests. The unit tests are very specific and are meant to isolate logical problems within a class; the integration tests are larger in scope and are intended to check that objects interact properly.

## Resources

*   The double facilities are provided in the submodule of RSpec called rspec-mocks. You can check out their [github](https://github.com/rspec/rspec-mocks) which has a useful README.
    