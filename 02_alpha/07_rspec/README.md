# Introduction to Testing

## Why do we use (automated) testing?

Currently, we manually test our code. For example, we create our own test cases by printing and checking the output of our functions. This can be tedious, repetitive, and **worst of all, it is a method vulnerable to both false positives and false negatives.** The larger your code base is, the more chances there are for both of these to occur. Because of this, relying on manual testing alone is not a sustainable solution when you start working on larger code projects written by multiple people.

Enter automated testing.

## What is automated testing?

When using automated testing, developers will code _test suites_, a collection of test cases that are intended to show that a program demonstrates some specified set of behaviours. There are many languages dedicated to doing this, with the most popular one for Ruby being **RSpec**.

Though we spend more time upfront writing and updating code for our test suite, the advantage is that we can instantly and easily test that code at any time from then on, in a way that will be simpler and more robust than doing it manually.

## Why is testing important?

Testing is important because we can ensure our code works the way we intended, and that our code does not break/interfere with pre-existing code.

The benefit of manual testing is that it allows a human mind to draw insights from a test that might otherwise be missed by an automated testing program. Automated testing is well-suited for large projects; projects that require testing the same areas over and over; and projects that have already been through an initial manual testing process. In the industry, a mixture of automated testing and manual testing is used to ensure the product behaves the way it was intended.

## Alpha Curriculum and Testing

Testing is a huge topic that we'll more fully introduce during the main course, but the core concept is simple: the test sets up some expectation of behavior, and then checks that your code meets that expectation.

At this time, you will not need to learn how to write these tests (writing tests will comprise the bonus section of some of the projects). For now, it is more important to be able to quickly interpret the errors you receive when running these tests and modify your code so that you can pass them. Remember to make use of the valuable debugging skills listed in the **Debugging** section!

All of the following exercises we provide come with **RSpec** files: Ruby scripts that are used to test your code. You'll need to run these to make sure your code functions exactly as expected; they're super convenient, and help account for edge cases you may not have considered.

## Full Time Curriculum and Testing

In the full time course, you will be taking a total of 6 timed, in-class assessments. These assessments are created so that we can assess whether you are ready for the next part of this fast-paced curriculum. We have found that students end up with a deeper understanding of the material as a result of the extra time they put into studying for these assessments.

We will primarily be using test suites written with RSpec to grade these assessments. It would be valuable for you to practice reading and adapting your code based on the error messages and stack traces provided by RSpec, so that you will be prepared to hit the ground running during the full time course.

<br />

# Introduction to RSpec

## What is RSpec?

RSpec is a language written in Ruby to test Ruby.

We will be using RSpec regularly for the rest of this curriculum, both to guide your coding on projects and to test your knowledge on assessments.

## Why do we use RSpec?

RSpec is the most frequently used testing tool for Ruby. RSpec is very easy to read and intrepret.

We use RSpec to help make sure that our code does what we want it to. RSpec is made up of statements describing the expected functionality of a piece of code.

## RSpec Example

We will now look into the anatomy of a piece of code that uses RSpec tests. You do not need to know how to run these files _yet_ because you will learn that in the next section. The goal of this section is to introduce you to how RSpec files are broken down and their output.

### File Structure

When using RSpec, all of the code you are writing will be located in the project directory's `lib` directory. Meanwhile, all of the testing code will be located in the project directory's `spec` directory. This follows RSpec convention.

For future a/A projects, you will be given specification tests listed in the `spec` directory while the files in the `lib` directory will be empty. Instructions and hints will be written in the `spec` directory to help you write the code in `lib` directory.

    project_directory
        |__ lib
        |    |__ 00_hello.rb
        |__ spec
            |__ 00_hello_spec.rb

### Code Snippets

    # lib/00_hello.rb
    # This is an example file you will be coding

    def hello
      # These methods will be empty so you can code them out
    end

Here's what a simple `hello` spec might look like.

    # spec/00_hello_spec.rb
    # This will be provided for you.
    # There is no need to change these specs.

    require "00_hello" # This will include code from the previous code snippet.

    # the `describe` statement names the function that is tested
    describe "the hello function" do

      # the `it` statement names the piece of functionality being tested
      it "says hello" do

          # the `expect` statement below provides an equality check between the
          # return value of hello function and its expected output "Hello!"

          # We can interpret the following code as 'We expect the return value
          # of hello to be equal to the string "Hello!"'
          expect(hello).to eq("Hello!")
      end
    end

### Terminal Output

When we run the test suite in terminal, we will see a screen that looks like the following:

![hello_spec_fail](https://assets.aaonline.io/fullstack/alpha-curriculum/rspec/images/01_rspec_fail.png)

So, what can we tell from this error message?

1.  We wanted the `hello` function to say hello.
2.  Specifically, we expected `hello` to return the string `"Hello!"`.
3.  It actually returned `nil`, giving us a failure.
4.  The test itself can be found in the `00_hello_spec.rb` file on line 5.

Make sure you are able to find all of this information in the screenshot above before moving on.

### Passing the spec

Currently, the `hello` function returns nil because we do not have any code in the method. In order to pass this spec, we need to return `"Hello!"` in the `hello` method.

    # lib/00_hello.rb

    def hello
      "Hello!"
    end

Now, when we run the specs in terminal, we will see the following image:

![hello_spec_pass](https://assets.aaonline.io/fullstack/alpha-curriculum/rspec/images/02_rspec_pass.png)

Yay! Now you have passed all of the tests! Now that you have seen an example of the output of RSpec tests, let's install RSpec on your machine.

<br />

# How to Install RSpec

When you download each set of exercises, you'll find that they come packaged in a particular folder structure. In your file system, it should look something like this:

    rspec-1/
     |- lib/
     |- spec/
     |- Gemfile
     |- Gemfile.lock

The `lib/` directory contains your actual code and the `spec/` directory holds all the test files. Structuring the directories in this way makes it simple to run all the tests in the `spec/` directory with one command (which you'll learn at the end of this reading).

Before we run the tests, we'll have to make sure we have the right gems installed. Gems are just Ruby code bundled in a self-contained format (this is commonly referred to as a **library**). After downloading the exercises, navigate into the directory and run the following commands (see the Introduction's [Command Line & Atom task](../introduction/command-line-atom) if you need a refresher on using the command line).

    ~$ gem install bundler
    ~$ bundle install

Here's what's happening:

1.  `gem install bundler` will do what it says: install the `Bundler` gem. `Bundler` is a tool for managing the development environment for a project; essentially, it "locks" you into using a particular version of each gem in the Gemfile. This makes it easy for someone to download our project and get exactly the same results when running it. We only need to run this once to install bundler. To learn more about `Bundler`, check out their [documentation](https://bundler.io/)

2.  `bundle install` will download and install the gems from the Gemfile, including `rspec`. We will have to run this command every time we start on a new project. After this step, we're ready to run the tests locally.

After you've gone through this setup process, you're ready to test some exercises!

# Running your first RSpec tests

Before we complete our first Ruby project with rspec tests, let's be sure that we have our development environment setup correctly.

Before we continue, quickly hop over and download the [RSpec Practice 1](./rspec-practice-1) project.

In terminal, head to the root directory of the project directory. If you are not sure you are in the right directory, type into terminal `pwd`, short for print working directory. It should be the directory with the `README`, the `lib` folder, and the `spec`.

Then, run the following commands:

1.  `bundle install`

2.  `bundle exec rspec --color`: `bundle exec` will run the rspec version specified on the Gemfile instead of the rspec version installed globally on your computer. This command will only run correctly if you are in the project root directory. If you are executing this command while in the `spec` or `lib` directory, this will not work. The `--color` flag will color the statements red if failing and green if passing.

If you can successfully download the project task and run these two commands, please feel free to mark this task as complete. In the next reading, you'll be reading about other important configuration flags that make RSpec easier to read, similar to `--color`.

If you run into trouble, this is a quick screencast with some of the most common bugs we have seen in ruby/rbenv environment setup. If you are still having trouble running the bundle commands after watching this video please contact App Academy for assistance through the [forum](http://appacademy-online.trydiscourse.com/) or the _Discuss_ tab at the top of the page.

[Video](https://player.vimeo.com/video/255818770)

# Useful RSpec Flags

The follow table contains the 3 rspec flags we use as we run our testing suites.

<table>

<thead>

<tr>

<th>Flag</th>

<th>Description</th>

</tr>

</thead>

<tbody>

<tr>

<td>`--color`</td>

<td>Failing tests will be colored red while passing tests will be colored green.</td>

</tr>

<tr>

<td>`--order=default`</td>

<td>Tests will run in-order, from top to bottom</td>

</tr>

<tr>

<td>`--format documentation`</td>

<td>Will print the full descriptions for each spec in a hierarchical format</td>

</tr>

</tbody>

</table>

If we want to run all of these flags in the project root directory, we can run `bundle exec rspec --color --order=default --format documentation`

Now, thats a long command to execute _every_ time we want to run our testing suite. The good news is, we can actually modify a rspec file so that the flags will be added automatically!

## Adding RSpec default flags

In terminal, run `atom ~/.rspec`. This will open the `.rspec` file in your root directory.

Paste and save the following code to the `.rspec` file.

    --color
    --format documentation
    --order=default

Now, any time you run `bundle exec rspec` in your future projects, it will run `bundle exec rspec --color --order=default --format documentation` under the hood.

### --format documentation vs. --format progress

The default `--format` flag is `progress`, which is not as helpful. The output looks like this:

`....F.....*.....`

*   `.` represents a passing example
*   `F` is failing example
*   `*` is pending example.

If you see the above output from any future rspec tests, it is because you are missing the `--format documentation` flag.

More about flags can be found in the RSpec [command line docs](https://relishapp.com/rspec/rspec-core/v/2-5/docs/command-line)