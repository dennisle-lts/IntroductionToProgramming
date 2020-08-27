# ==========================
# Author: Dennis Son Le
# ==========================

require 'rubygems'
require 'gosu'
require './circle'

# The screen has layers: Background, middle, top
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class DemoWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "P3.3 Shape Drawing"
  end

  def draw
    # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
    draw_quad(0, 0, 0xff_ffffff, 800, 0, 0xff_ffffff, 0, 600, 0xff_ffffff, 800, 600, 0xff_ffffff, ZOrder::BACKGROUND)
    sun = Gosu::Image.new(Circle.new(50))
    sun.draw(40, 20, ZOrder::TOP, 1.0, 1.0, 0xff_fff000)

    draw_line(680, 200, Gosu::Color::BLACK, 680, 500, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    sun.draw(655, 180, ZOrder::TOP, 0.5, 0.5, Gosu::Color::RED)
    draw_line(180, 200, Gosu::Color::BLACK, 180, 500, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    sun.draw(155, 180, ZOrder::TOP, 0.5, 0.5, Gosu::Color::RED)

    ground = Gosu::Image.new(Circle.new(460))
    ground.draw(-60, 400, ZOrder::TOP, 1, 0.5, 0xff_CCFFCC)

    Gosu.draw_rect(300, 340, 200, 50, Gosu::Color::BLACK, ZOrder::TOP, mode=:default)
    draw_quad(370, 310, 0xff_000000, 430, 310, 0xff_000000, 350, 340, 0xff_000000, 450, 340, 0xff_000000, ZOrder::TOP)

    tyre = Gosu::Image.new(Circle.new(20))
    tyre.draw(308, 370, ZOrder::TOP, 1.0, 1.0, 0xff_404040)
    tyre.draw(448, 370, ZOrder::TOP, 1.0, 1.0, 0xff_404040)

    

  end
end

DemoWindow.new.show
