
# Scope

[Scope](http://en.wikipedia.org/wiki/Scope_(computer_science)) is the context in which a variable name is valid and can be used.

A name is **in scope** (accessible) if the name has been previously defined in the current method (called a **local variable**) or at a higher level of the current method. A new level starts whenever we begin a class, a method, or a block.

We can't use a variable before it is defined:

    def pow(base, exponent)
      i = 0
      while i < exponent
        result = result * base  # Error: result is being used before it has been defined.

        i += 1
      end

      result
    end

We can't use a variable from a deeper scope. In the below example, `cat_age` is defined inside `extract_cat_age` and not available at the top-level scope.

    # defines a cat variable name in the global scope
    cat = {
      :name => "Breakfast",
      :age => 8
    }

    def extract_cat_age
      # creates a new local variable inside this method; won't add
      # variable to global scope; variable will be lost when method is
      # over

      cat_age = cat[:age]
    end

    extract_cat_age
    cat_age # ERROR: variable out of scope

Sometimes things are subtle:

    def fourth_power(i)
      square(i) * square(i)   # wait, isn't square not defined yet?
    end

    def square(i)
      i * i
    end

    # Ah, but by the time we _call_ `fourth_power` and run the
    # interior code, `square` will have been defined.

    fourth_power(2)

## Global variables

**_NOTE:_** This last bit about global variables is not essential.

While you shouldn't typically create global variables, you can do so with the `<section class="sc-ipXKqB eevSDq sc-hEsumM fwPWBm" prefix.

You can also create file-local global variables by defining a variable without `<section class="sc-ipXKqB eevSDq sc-hEsumM fwPWBm" at the top-level (outside any block, method, class). However, file-local global variable won't be accessible to other Ruby files that load the file.
