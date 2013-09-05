require 'curses'

module IFRuby
  class Display
    attr_accessor :prompt_string

    def initialize
      @prompt_string = '> '
    end
  end

  class CursesDisplay < Display
    attr_reader :width
    attr_reader :height

    def initialize
      super()
      Curses.init_screen()

      @width = Curses.cols
      @height = Curses.lines

      Curses.crmode()
      @text_window = Curses::Window.new(@height - 2, @width, 1, 0)
      @input_window = Curses::Window.new(1, @width, @height - 1, 0)
      Curses.refresh()
    end

    def close
      @text_window.close()
      @input_window.close()
      Curses.close_screen()
    end

    def write(str)
      str = str.to_s

      @text_window.addstr(str)
      @text_window.refresh()
    end

    def puts(str)
      str = str.to_s

      @text_window.addstr(str)
      @text_window.addch(?\n)
      @text_window.refresh()
    end

    def gets
      @input_window.setpos(0, 0)
      @input_window.addstr(prompt_string)
      @input_window.refresh()
      str = @input_window.getstr()
      @input_window.clear()

      write "\n#{prompt_string}#{str}\n"

      str
    end
  end
end

