require 'date'
require_relative 'game'
require_relative 'utils/util'

class GameService
  DATA_DIR = 'data'.freeze

  def initialize(author_manager, items)
    @author_manager = author_manager
    @items = items
    @games = []
  end

  def create_game
    author_manager.check_and_create_author

    publish_date = get_date_input('Publish date')
    last_played_at = get_date_input('Last played date')
    multiplayer = get_boolean_input('Is it multiplayer?')

    loop do
      author_manager.list_authors

      author_id = get_non_empty_input('Select Author by ID listed above').to_i
      author = author_manager.authors.find { |a| a.id == author_id }

      if author
        game = Game.new(last_played_at: last_played_at, multiplayer: multiplayer,
                        publish_date: publish_date || Date.today, author: author)
        @items << game
        @games << game
        save_games
        puts 'Game added successfully!'
        break
      end

      puts 'Invalid author ID. Please choose a correct author ID listed above or enter "exit" to go back to the Menu.'
      break if get_non_empty_input('Enter your choice: ').downcase == 'exit'
    end
  end

  def save_games
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(File.join(DATA_DIR, 'games.json'), 'w') do |file|
      game_data = @games.map do |game|
        {
          id: game.id,
          last_play_at: game.last_played_at,
          multiplayer: game.multiplayer,
          publish_date: game.publish_date,
          author_id: game.author.id
        }
      end
      file.puts(JSON.generate(game_data))
    end
  end

  private

  attr_reader :author_manager
end
