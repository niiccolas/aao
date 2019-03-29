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
