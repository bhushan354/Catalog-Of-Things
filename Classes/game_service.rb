require 'date'
require_relative 'game'
require_relative 'utils/util'

class GameService
  def initialize(author_manager, items)
    @author_manager = author_manager
    @items = items
  end

  def create_game
    author_manager.check_and_create_author

    publish_date = get_date_input('Publish date')
    last_played_at = get_date_input('Last played date')
    multiplayer = get_boolean_input('Is it multiplayer?')

    loop do
      author_manager.list_authors

      author_id = get_non_empty_input('Select Author by ID listed above').to_i
      author = author_manager.authors.find { |i| i.id == author_id }

      if author.nil?
        puts 'Invalid author ID. Please choose a correct author ID listed above or enter "exit" to go back to the Menu.'
        break if get_non_empty_input('Enter your choice: ').downcase == 'exit'
      else
        game = Game.new(last_played_at: last_played_at, multiplayer: multiplayer,
                        publish_date: publish_date || Date.today)
        game.author = author
        @items << game
        puts 'Game added successfully!'
        break
      end
    end
  end

  private

  attr_reader :author_manager
end
