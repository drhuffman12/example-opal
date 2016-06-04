# Overview

## Based on

Example Conway's Game of Life in Opal:
* https://www.sitepoint.com/opal-ruby-browser-basics/

Fix for Rakefile:
* https://github.com/opal/opal.github.io/issues/2

## (RE-)Build

```
rake build
```


# Tutorial Steps

## Initial Setup

### Sum of Cubes

* `app/conway.com`

```
require 'opal'

x = (0..3).map do |n|
  n * n * n
end.reduce(:+)
puts x
```
