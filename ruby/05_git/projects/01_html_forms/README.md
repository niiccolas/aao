# HTML Forms Exercise

  - ⏱ 30 minutes

  **N.B.** Remember that forms make a request upon submission to the provided action URI. Since we don't have a server to handle the request, our form won't really do anything on submission. Still, this exercise will help practice coding the structure of our form element.

  Take [yesterday's solution](http://assets.aaonline.io/fullstack/html-css/micro-projects/html-containers/solution.zip) from HTML Containers Exercise and add a review form:

  1. Make a `section` element before your footer and after the directions section

  2. Create a `form` element in the section

  3. Inside the `form` element make a `label` and text `input` for the name of the reviewer. Use the 'for' and 'id' attributes to link the label to the input.

  4. Create a label for "Rating" and 5 radio inputs with corresponding value attributes. Have the radio buttons default to checking '1'.

  5. Create a "Cooking Expertise" label that corresponds to a

      

     ```
     select
     ```

     element containing 5

      

     ```
     option
     ```

      

     elements, don't forget their value attributes:

     - Select Cooking Expertise (make this disabled and selected by default)
     - Sometimes Cook
     - Cook Everyday
     - Cooking is a Hobby
     - Professional Chef

  6. Code a `label` element for "Review" but this time place the corresponding `textarea` element inside the label element instead of using for/id.

  After coding your recipe page, compare your html to [this example](http://assets.aaonline.io/fullstack/html-css/micro-projects/html-forms/solution.html).