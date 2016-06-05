require 'opal'
# require 'opal-jquery' # can't find file: "opal-jquery"
# Opal.append_path File.dirname(File.expand_path(`gem which opal-jquery`)).untaint
# which_opal_jquey = '~/.rvm/gems/ruby-2.3.1@opal/gems/opal-jquery-0.4.1/lib'
# Opal.append_path File.dirname(File.expand_path(which_opal_jquey)).untaint

require 'lib/jquery'
require 'lib/opal-jquery.js'

def sum_of_cubes
  x = (0..3).map do |n|
    n * n * n
  end.reduce(:+)
  puts x
end
sum_of_cubes

require 'ostruct'
class Coordinates < OpenStruct; end

class Grid
  attr_reader :height, :width, :canvas, :context, :max_x, :max_y

  CELL_HEIGHT = 15;
  CELL_WIDTH  = 15;

  def canvas_id
    'conwayCanvas'
  end

  def initialize
    @height  = `$(window).height()`
    @width   = `$(window).width()`
    @canvas  = `document.getElementById(#{canvas_id})`
    @context = `#{canvas}.getContext('2d')`
    @max_x   = (height / CELL_HEIGHT).floor
    @max_y   = (width / CELL_WIDTH).floor

    # add_mouse_event_listener
  end

  def draw_canvas
    `#{canvas}.width  = #{width}`
    `#{canvas}.height = #{height}`

    x = 0.5
    until x >= width do
      `#{context}.moveTo(#{x}, 0)`
      `#{context}.lineTo(#{x}, #{height})`
      x += CELL_WIDTH
    end

    y = 0.5
    until y >= height do
      `#{context}.moveTo(0, #{y})`
      `#{context}.lineTo(#{width}, #{y})`
      y += CELL_HEIGHT
    end

    `#{context}.strokeStyle = "lightgray"`
    `#{context}.stroke()`

    fill_cell(2,3)
  end

  def fill_cell(x, y)
    `console.log(#{ {method: 'fill_cell', x: x, y: y, status: 'start'}})`
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.fillStyle = "red"`
    `#{context}.fillRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
    `console.log(#{ {method: 'fill_cell', x: x, y: y, status: 'done'}})`
  end

  def unfill_cell(x, y)
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.clearRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
  end

  def get_cursor_position(event)
    `console.log(#{event})` # <- I cheated.
    if (event.page_x && event.page_y)
      x = event.page_x;
      y = event.page_y;
    else
      doc = Opal.Document[0]
      x = event[:clientX] + doc.scrollLeft +
        doc.documentElement.scrollLeft;
      y = event[:clientY] + doc.body.scrollTop +
        doc.documentElement.scrollTop;
    end

    x -= `#{canvas}.offsetLeft`
    y -= `#{canvas}.offsetTop`

    x = (x / CELL_WIDTH).floor
    y = (y / CELL_HEIGHT).floor

    Coordinates.new(x: x, y: y)
  end

  def add_mouse_event_listener
    Element.find("##{canvas_id}").on :click do |event|
      coords = get_cursor_position(event)
      x, y   = coords.x, coords.y
      fill_cell(x, y)
    end

    Element.find("##{canvas_id}").on :dblclick do |event|
      coords = get_cursor_position(event)
      x, y   = coords.x, coords.y
      unfill_cell(x, y)
    end
  end

end

grid = Grid.new
puts "Grid height: #{grid.height}"
puts "Grid width: #{grid.width}"
puts "Grid canvas: #{grid.canvas}"
# puts "Grid canvas.inspect: #{grid.canvas.inspect}"
# `console.log(#{grid.canvas.inspect})`
# puts grid.canvas.klass
# puts JSON.stringify(grid.canvas)
grid.draw_canvas
grid.add_mouse_event_listener
# grid.addEventListener("onclick", `alert("clicked")`, false)