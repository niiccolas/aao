# CSS: A brief non-technical overview

## What is CSS?

CSS is an abbreviation of Cascading Style Sheets, a style sheet language for markup (XML, HTML, XHTML). It empowers developers to separate document content from presentation.

Style sheets are collections of stylistic rules; they have been used by editors and typographers since long before the web. A style sheet language describes the presentation of structured documents, like an HTML document. CSS is 'Cascading' because multiple files can be combined to style one page.

## A Brief History of CSS

![netscape-relic](http://assets.aaonline.io/fullstack/html-css/readings/netscape96.png) Netscape October 20, 1996

*   Early 1990's: HTML popularity was increasing and developers were frustrated with its limited styling abilities.
*   October 1994: Hakon Wium Lie released the first draft of “Cascading HTML Style Sheets”
*   August 1996: Microsoft Internet Explorer became the first browser to support CSS
*   December 1996: CSS 1 release
    *   Included: font properties, text attributes, alignment of text, tables, images, colors of text and backgrounds, spacing of words, letters and lines, margins, borders, padding and positioning, unique identification and classification of groups of attributes.
*   Early 1997: The W3C formed the [CSS and Formatting Properties Working Group](https://en.wikipedia.org/wiki/CSS_Working_Group) to focus solely on CSS standards. (Browsers used to display styling much less consistently)
*   1998: CSS 2 release
    *   Added: z-index, media types, bidirectional text, absolute, relative and fixed positioning
*   June 2011 and June 2012: CSS 3 capabilities were separated into modules.
    *   Four new modules were added: color, selectors level 3, namespaces, media queries

## Adding Style to HTML: Inline, Internal, and External CSS

There are three ways a developer may add style to an HTML document. External CSS is most often preferred, but you will undoubtedly encounter inline and internal styles in the wild. They are discussed in order of specificity: inline > internal > external

### Inline Style Attribute

Exactly what the title suggests: style attributes added directly on an HTML element inside of the element's opening HTML tag.

    <h2 style="color: #000000; font-size: 2em;"> Hi </h2>

Pros:

*   Highest specificity: Ensures the style will be applied to the element

Cons:

*   Highest specificity: will overwrite any other styles in an internal or external sheet
*   Redundant; not DRY
*   Cluttered, unreadable HTML markup
*   Difficult to manage
*   Impossible to style pseudo-elements and classes like `visited`, `hover`, and `active`

Extra note: When you change an element's style using Javascript, it affects the element's inline style and can overwrite existing inline styles permanently.

### Internal: Embedded style tag

Styles for many elements are collected between `<style>` tags in the `<head>` section of an HTML document. This is referred to as an internal style sheet or embedded style tag because it is a complete stylesheet embedded inside of an HTML document.

    <head>
      <style type="text/css">

       h2 {
         color: #000000;
         font-size: 2em;
       }

       h3 {
         color: #FF69B4;
         font-size: 1em;
       }

      </style>
    </head>

Pros:

*   Cleaner HTML markup than inline styles: all styles are in one section of the document
*   Selectors apply styles to multiple elements on a page
    *   Smaller page size than using all inline styles
    *   More DRY than inline styles
*   Apply styles to the document they are embedded within; not globally

Cons:

*   Loaded with the HTML page and not cached by the browser

### External file: linked stylesheet

    <link rel="stylesheet" type="text/css" href="styles.css" />

Pros:

*   Can be cached by browsers for improved performance
*   Global: can be used across pages in your site

Cons:

*   Global: the developer must structure the CSS so that styles are not applied to elements they are not intended for.

## Popular CSS Pre-Processors

A pre-processor is a program that converts data to conform with the input requirements of another program. For example, [Haml](http://haml.info/tutorial.html) is a markup language that describes HTML, but is not supported by browsers. Haml requires use of a pre-processor to translate it into HTML. On the CSS end, SCSS, Sass, Less, and Stylus are languages which describe CSS and require their own pre-processors for translation.

Example:

This haml

    %strong.code#message Hello, World!

is processed into this HTML

    <strong class="code" id="message">Hello, World!</strong>

CSS pre-processors extend CSS's functionality with variables, nesting, functions, mixins, operators, and more. They help with style sheet maintenance and allow developers to write DRY-er, more extensible code.

### SCSS and Sass

[SCSS/Sass](http://sass-lang.com/) are the most widely used CSS pre-processors.

SCSS (Sassy CSS) is a superset of CSS3, which means that every valid CSS3 stylesheet is also valid SCSS. It retains CSS brackets and semi-colons; a developer can add SCSS to a CSS file by simply changing the extension to `.scss`.

Sass is the older version of SCSS. It uses line indentation rather than brackets and semi-colons to specify blocks. Many developers prefer this syntax because it feels cleaner and more concise.

SCSS/Sass support while/ each loops and if/then/else statements, custom function declaration, nested selectors, variables, mixins, extends, and many more features that allow it to be used more like a complete programming language. SCSS/Sass has gained a large following from designers and appears to be preferred by many developers ([according to this small survey](https://www.keycdn.com/blog/sass-vs-less/)).

SCSS and Sass are Ruby-based, so they require that Ruby be installed before use.

Example:

SCSS

    $spacing: 0

    nav {
      ul {
        margin: $spacing;
        padding: $spacing;
        list-style: none;
      }
      li { display: inline-block; }
    }

Sass

    $spacing: 0

    nav
      ul
        margin: $spacing
        padding: $spacing
        list-style: none
      li
        display: inline-block

CSS

    nav ul {
      margin: 0;
      padding: 0;
      list-style: none;
    }

    nav li { display: inline-block; }

### Less

[Less](http://lesscss.org/) is inspired by and very similar to Sass. It is preferred by some designers and developers because of its gentle learning curve: it has less features than Sass and relies mainly on mixins for custom functionality. Less includes "guarded mixins" which take place conditionally. Mixins can also call themselves recursively with updated values. It does not support `while` or `each` loops. Some of Less's popularity can be attributed to its past use by Bootstrap, a popular CSS framework.

Less is Javascript-based and run by NodeJS.

Example:

Less

    @base: #f938ab;
    .box {
      color: saturate(@base, 5%);
      border-color: lighten(@base, 30%);
    }

CSS

    .box {
      color: #fe33ac;
      border-color: #fdcdea;
    }

### Stylus

[Stylus](http://stylus-lang.com/) syntax uses line indentation and white space instead of semi-colons and brackets. Of the popular CSS pre-processors it behaves the most like a complete programming language. Some of its special features include splats, converting files to base64, hashes, and color blending. Because of its comparative power and complexity, Stylus is perceived as less beginner-friendly than SCSS/Sass and lacks its extensive community support.

Stylus is Javascript-based and run by NodeJS.

Example:

Stylus

    body
      font: 12px Helvetica, Arial, sans-serif

CSS

    body {
      font: 12px Helvetica, Arial, sans-serif;
    }

## Popular CSS Frameworks

A CSS Framework is a package of pre-structured and standardized code that supports CSS development. For example, a grid system framework will provide basic column sizes and styles that can be adapted to many different designs.

### Bootstrap

Twitter developed [Bootstrap](http://getbootstrap.com/) as a way to standardize their UI components. It was publicly released in August of 2011 and has since become the most popular front-end framework on the web. The massive community has developed countless themes and templates along with incredibly thorough support resources. Bootstrap used to be written in Less, but switched to Sass in the most recent release. This makes its styles easier to customize than in previous releases, but because components are already polished out of the box, many developers do not fight the pre-existing designs. Bootstrap is a great choice for projects that have to get off the ground quickly.

Sites built with Bootstrap:

*   [NBA.com](http://www.nba.com/)
*   [Walmart](https://www.walmart.com/)
*   [Bloomberg Business](http://www.bloomberg.com/)

### Foundation

[ZURB](http://zurb.com/), a high profile design agency, developed [Foundation](http://foundation.zurb.com/) as an internal style guide. They released it in September 2011 as an open-sourced front-end framework. Though its following is smaller than Bootstrap's, Foundation has an adequate amount of community technical support and resources. Foundation invites more customization than Bootstrap by offering minimally pre-styled components. Its grid system also supports mobile-first design, a strategy that has grown more popular with the need for responsive websites. Foundation aids projects with more designer support that aim for an original look and feel.

Sites built with Foundation:

*   [Dr Martens](http://www.drmartens.com/us/)
*   [Lamborghini](https://www.lamborghini.com/en-en/)
*   [L'Estrange London](https://lestrangelondon.com/)

## Some terms related to CSS in industry

*   UI: Short for user interface, or how a user interacts with a device or technology. CSS helps a UI design communicate how a user might use a web app. If you see a job posting for a UI Developer, that role likely includes writing a lot of HTML and CSS. Ex: "The Windows 10 UI is so confusing! I don't know how to change any settings."

*   Responsive: A web design is responsive if it adjusts to (and looks decent across) different device screen sizes. Ex: "My orthodontist's website looks okay on my laptop, but it isn't responsive. It displays weirdly on mobile and I can't find her contact information."

    *   Breakpoints: Set in a web page's styles, breakpoints are the markers at which a change will occur to improve the UI. Ex: "Please add a breakpoint so the picture grid on this page has four columns on wide screens and three columns on screens less than 1024px wide."

        *   Example: When a container element is <= 480px wide, its inner elements will stack in one column instead of two columns.
    *   Media queries: Used for device-specific breakpoints. They include an optional media type and expressions that limit the scope of their contained styles. Ex: "The app's styles include media queries for smartphone and tablet screens."

        *   Example:

                @media only screen
                and (min-device-width: 320px)
                and (max-device-width: 480px){
                  font-size: 12px;
                }

*   Pixel perfect: Replicating a mockup perfectly (down to the pixel level). Sometimes used to mean great attention to detail. Ex: "The design team gave me a mockup annotated with specifications so that my implementation can be pixel-perfect."

    *   Flat design: A minimalist UI design language characterized by simple elements, subtle typography, and flat colors. Ex: "You should make your app responsive and use flat design for a more modern look."

    *   Skeuomorphism: A design language characterized by elements that look like their counterparts in the real world. Ex: "Remember iOS6 when the icons looked really bulgy and realistic? I miss skeuomorphism."

    *   Grid system: A simple type of CSS framework that provides column systems for grid layouts, usually helpful for responsive designs Ex: "Use a grid system to ensure all the photos in your photo album app are evenly spaced."

*   [Material Design](https://material.google.com): Google's visual language inspired by paper and ink with realistic lighting. Ex: "Google apps feel intuitive and cohesive thanks to Material Design." Ex: "We don't have a UI designer, but we followed the Material Design principles so our app looks okay."

*   [Material UI](http://www.material-ui.com/): The React Components implementation of Google's design language, Material Design. Ex: "She used Material UI to make her full stack project look like a Google app."

*   [W3C](https://www.w3.org/): The group responsible for HTML and CSS standards. It is the largest standards body for Internet design and best practices. Ex: "My lifelong dream has been to join the W3C and fight browser inconsistencies!"


<br/>


# Mancala

<section class="sc-hEsumM iMcKcx">

# Mancala!

If you don't know how the game works, check out the rules below, or check out this video: [How to Play Mancala](https://youtu.be/-A-djjimCcM)!  
Even if you already know mancala, skim the rules. There are many different ways to play mancala, and the specs are written to test one particular version of the game. Read through all of the instructions before starting.

## Game Rules

*   There are two players. Each has one side of the board, and they must always _start_ a turn on their side of the board.
*   Game play always moves counter clockwise. Players pick up all of the stones in the cup they start with. They then move cup-by-cup and put one stone in each cup they pass, including their own points store. The only exception is when they pass their opponent's points store; in that case, they simply skip it.
    *   e.g. Player 2 could start on cup 7 and move to cup 8, 9, 10, etc., and, if they had enough stones, would put one in the `[player2 store]` when passing it. They could not start a turn on cups 1-6.

    player 2:             12  11  10  9  8  7
                  [player2 store]     [player1 store]
    player 1:              1   2   3  4  5  6

*   Depending on where the player ends, they will do different things. If they place the last stone in:
    *   their point store --> they get to play again, choosing a new starting cup on their side
    *   a regular cup with stones in it --> they _must_ pick up the stones in that cup and continue playing (even if it's on the opponent's side)
    *   a regular cup that's empty --> their turn is over; switch players
*   The game ends when one side is empty. At that point, the player with the most stones in their points store wins.

## Getting Started

Download the [skeleton](http://assets.aaonline.io/fullstack/ruby/homeworks/mancala/skeleton.zip).

Poke around. You will be writing the `Board` class, but first get acquainted with the code provided in the `Player` and `Mancala` classes.

The gist:

*   To play, create a new instance of `Mancala` and call `play` to kick things off.
*   `Mancala#play` calls `#take_turn` alternating players until the game is `#won?`
*   `Mancala#take_turn` encapsulates the trickier logic of the game. It relies on the **return value** of `Board#make_move` to determine whether the turn is over or not.
    *   If the player ends in their own cup, the return value should be `:prompt`, the turn is _not_ over yet, and `Mancala#take_turn` should prompt the current player for the next starting cup
    *   If the current player ends on a cup that already has stones in it, the return value should be the `ending_cup_idx` and the game automatically plays the next turn, since the rules dictate that a player must then pick up the stones in that cup.
    *   If the current player ends on an empty cup (that now has one stone in it), the return value should be `:switch`. `Mancala#take_turn` will then switch players and repeat the process until someone has won.
    *   Our `Board` class houses this logic because the next turn is determined by the board's state after interacting with the player.

**NB:**

*   Run `bundle install` to make sure you're using the correct version of RSpec!
*   Run the specs using the `--order default` option, like so: `bundle exec rspec --order default`.
*   Do not try calling `Mancala#play` until you have written the `Board` class! It won't work.

## Writing the `Board` class

Run the specs. Skim the failed spec messages, along with the outline of the `Board` class provided. These two things together should give you a sense of how a board is expected to interact with the other classes.

The specs are your instructions; let them guide you!

A few :key: things to note:

*   `player1`, `name1`, and `side1` all correspond to the same player.
*   A _cup_ is an Array of stones. The number of stones in a cup corresponds to its length. An empty cup has the length of 0.
*   Call `Board#render` to the board at the end of each move.
*   `Player#prompt` requires the input to be either `1..6` or `7..12`, but `Board#make_move` should _transpose_ the bottom half to `0..5`. This is based on the assumption that it's more user-friendly to only number the cups they can start with (i.e. not the points stores) and to start numbers at 1\. But within our `Board` class, the points stores are, of course, elements in the array, so we need to account for them.

    *   The player sees and uses:

                12  11  10  9  8  7
            [store2]            [store1]
                 1   2   3  4  5  6

    *   Our board is actually setup like this:

                12  11  10  9  8  7
            [13]                   [6]
                 0   1   2  3  4  5

    *   Make sure to account for this difference!

When you have all of your specs passing you are finished!

<br/>

### Projects:
* [Chess - Part Two]()
* [Chess - Part Three]()
* [Hack Academy]()