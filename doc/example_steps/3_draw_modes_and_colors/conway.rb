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
  attr_reader :drawing_mode

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
    @drawing_mode = :off

    `document.getElementById(#{canvas_id}).focus()`
    update_cursor_style
    draw_canvas
    draw_rnd(100)
    add_mouse_event_listener
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

    fill_cell(2,3, 'red')
  end

  def hex
    @hex ||= '0123456789abcdef'
  end

  def hex_rnd
    hex[rand(hex.length)]
  end

  def draw_rnd(qty)
    qty.times do |q|
      x = rand(@max_x)
      y = rand(@max_y)
      colors = ['red','green','blue']
      c = colors[rand(colors.length)]
      # c = "##{hex_rnd}#{hex_rnd}#{hex_rnd}#{hex_rnd}#{hex_rnd}#{hex_rnd}"
      # `console.log(#{{x: x, y: y, c: c}})`
      fill_cell(x,y,c)
    end
  end

  def fill_cell(x, y, c)
    # `console.log(#{ {method: 'fill_cell', x: x, y: y, c: c, status: 'start'}})`
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    fill_style = '#{context}.fillStyle = "#{c}"'
    # `console.log(#{ {method: 'fill_cell', fill_style: fill_style}})`
    case c
      when 'red'
        `#{context}.fillStyle = "red"`
      when 'green'
        `#{context}.fillStyle = "green"`
      when 'blue'
        `#{context}.fillStyle = "blue"`
      when 'yellow'
        `#{context}.fillStyle = "yellow"`
      else
        `#{context}.fillStyle = "gray"`
    end
    `#{context}.fillRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
  end

  def unfill_cell(x, y)
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.clearRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
  end

  def get_cursor_position(event)
    # `console.log(#{event})`
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

  def update_cursor_style
    # `console.log(#{@drawing_mode})`
    case @drawing_mode
      when :drawing
        `document.getElementById(#{canvas_id}).style.cursor = 'copy'` # cell
      when :erasing
        `document.getElementById(#{canvas_id}).style.cursor = 'no-drop'` # grab, grabbing
      when :off
        `document.getElementById(#{canvas_id}).style.cursor = 'crosshair'`
      else
        `document.getElementById(#{canvas_id}).style.cursor = 'crosshair'` # 'url(image/another-cursor.cur)'
    end
  end

  def add_mouse_event_listener
    Element.find("##{canvas_id}").on :keydown do |event|
      `console.log(#{event.key_code.chr})`
      case event.key_code.chr
        when 'D'
          @drawing_mode = :drawing
        when 'E'
          @drawing_mode = :erasing
        when 'S'
          @drawing_mode = :off

        when '1'
          @drawing_color = 'red'
        when '2'
          @drawing_color = 'yellow'
        when '3'
          @drawing_color = 'green'
        when '4'
          @drawing_color = 'blue'

        # when '0'
        #   @drawing_color = 'black'
        # when '1'
        #   @drawing_color = 'gray'
        # when '2'
        #   @drawing_color = 'white'

        else
          @drawing_color = 'white'
          @drawing_mode = :off
      end
      update_cursor_style
    end

    # Element.find("##{canvas_id}").on :click do |event|
    #   @is_mouse_erasing = false
    # end
    #
    # Element.find("##{canvas_id}").on :contextmenu do |event|
    #   event.prevent_default
    #   @is_mouse_erasing = true
    # end

    Element.find("##{canvas_id}").on :mousemove do |event|

      `console.log(#{event})`
      `console.log(#{event.current_target})`
      `console.log(#{event.current_target.class})`
      # `console.log(#{event.current_target.context.style.cursor})`
      `console.log(#{event.current_target[:style]})`
      
      coords = get_cursor_position(event)
      x, y   = coords.x, coords.y
      # !!@is_mouse_erasing ? unfill_cell(x, y) : fill_cell(x, y, 'yellow')
      case @drawing_mode
        when :drawing
          fill_cell(x, y, @drawing_color)
        when :erasing
          unfill_cell(x, y)
        when :off
          #
        else
          #
      end
    end
  end

end

grid = Grid.new
