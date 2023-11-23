# main.rb
require_relative 'app'

class Menu
  def display_option
    puts 'Please choose an option by typing a number:'
    puts '1 - List books'
    puts '2 - List labels'
    puts '3 - Create book'
    puts '4 - Create label'
    puts '5 - List music albums'
    puts '6 - Create movie'
    puts '7 - Create music album'
    puts '8 - Create game'
    puts '9 - EXIT TERMINAL APP'
  end

  def choice
    print ' => '
    gets.chomp
  end
end

class Main
  def initialize(app)
    @app = app
  end
  # rubocop:disable Metrics/CyclomaticComplexity

  def run
    main_menu = Menu.new
    loop do
      main_menu.display_option
      choice = main_menu.choice

      case choice
      # hello teammates as this is group task this 1)display_option_books and 4)create_book these are my methods
      # and I have given random method name to your methods
      # eg 3)display_option_games for the sake of this file to run in terminal you can edit the names of your method
      when '1' then @app.display_books
      when '2' then @app.display_labels
      when '3' then @app.create_book
      when '4' then @app.create_label

      when '5' then @app.display_option_games
      when '6' then @app.create_game
      when '7' then break
      else
        puts ' Please select a valid option.'
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

main = Main.new(App.new)
main.run
