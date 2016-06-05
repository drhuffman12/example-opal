# require 'opal'
# # # Opal.append_path File.dirname(File.expand_path(`gem which opal-jquery`)).untaint
# # # Opal.use_gem('opal-jquery')
# # # require 'opal-jquery'
# #
# # if RUBY_ENGINE == 'opal'
# #   # require 'opal/jquery/window'
# #   # require 'opal/jquery/document'
# #   # require 'opal/jquery/element'
# #   # require 'opal/jquery/event'
# #   # require 'opal/jquery/http'
# #   # require 'opal/jquery/kernel'
# #   require 'opal'
# #   which_opal_jquey = '~/.rvm/gems/ruby-2.3.1@opal/gems/opal-jquery-0.4.1/lib'
# #   Opal.append_path File.dirname(File.expand_path(which_opal_jquey)).untaint
# # else
# #   require 'opal'
# #   require 'opal/jquery/version'
# #
# #   # Opal.append_path File.expand_path('../..', __FILE__).untaint
# #   require 'opal-jquery'
# # end
#
# require 'opal'
# require 'lib/jquery'
# # require 'opal-jquery'
# require '/home/drhuffman/.rvm/gems/ruby-2.3.1@opal/gems/opal-jquery-0.4.1/lib/opal-jquery.rb'

class Grid
  attr_reader :height, :width, :canvas, :context, :max_x, :max_y

  CELL_HEIGHT = 15;
  CELL_WIDTH  = 15;

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

  def canvas_id
    'conwayCanvas'
  end

end

grid = Grid.new
grid.draw_canvas
