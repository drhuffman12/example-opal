# Overview

## Based on

*Starter* Example Conway's Game of Life in Opal:

* https://www.sitepoint.com/opal-ruby-browser-basics/

... This is a good start, but since (https://www.sitepoint.com/opal-ruby-browser-basics/) apparently didn't add a follow-up article for the actual game implementation, I added a "Custom Steps" section and will look into adding the actual implementation of the game.

Fix for Rakefile:

* https://github.com/opal/opal.github.io/issues/2

## (RE-)Build

##### manually:

```
rake build
```

##### automatially (via Guard):

```
bundle exec guard
```

(Pressing <Enter> will force a re-build.)

## (RE-)Run

Open `index.html` in browser.

# Tutorial Steps

## Initial Setup & 'Sum of Cubes':

A simple Hello World via outputting a sum of cubes to the JS console.

See files under `doc/example_steps/0_sum_of_cubes`

![Sum of Cubes](doc/example_steps/0_sum_of_cubes/screenshot.png "Sum of Cubes")

## Drawing a Blank Grid

Grid lines to cover entire growser viewport.

See files under `doc/example_steps/1_drawing_blank_grid`

![Drawing a Blank Grid](doc/example_steps/1_drawing_blank_grid/screenshot.png "Drawing a Blank Grid")

## Adding Some Interactivity

Click a cell to fill or clear it.

See files under `doc/example_steps/2_click_to_toggle`

![Drawing a Blank Grid](doc/example_steps/2_click_to_toggle/screenshot1.png "Drawing a Blank Grid")

# Custom Steps
* (... leading to an implementation of Conway's Game of Life, since (https://www.sitepoint.com/opal-ruby-browser-basics/) apparently didn't add a follow-up article for the actual game implementation ...)

## Simple Drawing Pad

Click a cell to fill or clear it.

See files under `doc/example_steps/3_draw_modes_and_colors`

![Simple Drawing Pad](doc/example_steps/3_draw_modes_and_colors/screenshot.png "Simple Drawing Pad")

--------

# See also:

* [Opal](http://opalrb.org/)
* [Wrapping JavaScript library with Opal](https://ilyabylich.svbtle.com/wrapping-javascript-library-with-opal)
* [a *tiny* Ruby implementation](https://gist.github.com/netmute/1761463)
* [a Ruby implementation](https://github.com/andersondias/conway-game-of-life-ruby)
* [a Rails implementation](https://github.com/davidesantangelo/gameoflife)
* [Fun with Ruby Enumerators](https://romaimperator.com/?p=122) and [another Ruby implementation](https://github.com/romaimperator/conways_game_of_life)
