require 'gosu'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

SCREEN_WIDTH = 600  # needs to be COUNT * COLUMN_WIDTH
SCREEN_HEIGHT = 200 # Should be multiple of 100
MAX_VALUE = 100 # the range of the data 1 to 100
COUNT = 30 # Number of items
COL_WIDTH = 20  # suggested at least 10

class Column
  # have a pointer to the neighbouring cells
  attr_accessor :height, :value

  # take in a value up to MAX_VALUE and calculate from
  # this and the SCREEN_HEIGHT the height of the bar
  # to be displayed.
  def initialize(value)
    @value = value
    @height = (SCREEN_HEIGHT/MAX_VALUE) * value
  end
end

class GameWindow < Gosu::Window
  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "Sort Visualiser"
    @path = nil
    @do_insert = false
    @do_bubble = false

    @columns = Array.new(COUNT)

    # Create the columns and initialise each with a random value
    column_index = 0
    while (column_index < COUNT)
      col = Column.new(rand(MAX_VALUE + 1))
      @columns[column_index] = col
      column_index += 1
    end

    # Create a text font to display the value at the bottom of each bar
    @text_font = Gosu::Font.new(10)
  end

  # this is called by Gosu to see if should show the cursor (or mouse)
  def needs_cursor?
    true
  end

  def insertion_sort(loop)
     j = loop
     done = false
     while ((j > 0) and (!done))
       if (@columns[j].value < @columns[j - 1].value)
         temp = @columns[j - 1]
         @columns[j - 1] = @columns[j]
         @columns[j] = temp
       else
         done = true
       end
       j = j - 1
     end
  end

  def bubble_sort(loop)
    for j in ((loop+1)..COUNT-1)
      if (@columns[loop].value > @columns[j].value)
        temp = @columns[j]
        @columns[j] = @columns[loop]
        @columns[loop] = temp
      end
    end
  end

  def button_down(id)
    case id
      when Gosu::MsLeft
        @do_insert = true
        @loop = 0
      when Gosu::MsRight
        @do_bubble = true
        @loop = 0
      end
  end

  def update
    if (@do_insert)
      puts "Doing insert #{@loop}"
      if @loop < (COUNT)
        insertion_sort(@loop)
        @loop += 1
        sleep(0.5)
      else
        @do_insert = false
      end
    end

    if (@do_bubble)
      puts "Doing bubble #{@loop}" 
      if @loop < (COUNT)
        bubble_sort(@loop)
        @loop += 1
        sleep(0.5)
      else
        @do_bubble = false
      end

    end
  end

  def draw
    column_index = 0
    while (column_index < @columns.length)
      color = Gosu::Color::GREEN
      Gosu.draw_rect((column_index * COL_WIDTH), SCREEN_HEIGHT - @columns[column_index].height, COL_WIDTH, @columns[column_index].height, color, ZOrder::MIDDLE, mode=:default)
      @text_font.draw("#{@columns[column_index].value}", (column_index * COL_WIDTH) + 5, SCREEN_HEIGHT - 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color::RED)
      column_index += 1
    end
  end
end

window = GameWindow.new
window.show
