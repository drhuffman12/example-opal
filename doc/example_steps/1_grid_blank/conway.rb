require 'opal'
# require 'opal-jquery' # can't find file: "opal-jquery"

def sum_of_cubes
  x = (0..3).map do |n|
    n * n * n
  end.reduce(:+)
  puts x
end
sum_of_cubes

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

    `#{context}.strokeStyle = "#eee"`
    `#{context}.stroke()`
  end

end

grid = Grid.new
puts "Grid height: #{grid.height}"
puts "Grid width: #{grid.width}"
grid.draw_canvas
