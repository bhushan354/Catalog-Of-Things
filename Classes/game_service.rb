require 'date'
require_relative 'game'
require_relative 'utils/util'

class GameService
  DATA_DIR = 'data'.freeze

  def initialize(author_manager, items)
    @author_manager = author_manager
    @items = items
    @games = []

    read_from_local_storage
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
        save_to_local_storage
        puts 'Game added successfully!'
        break
      end

      puts 'Invalid author ID. Please choose a correct author ID listed above or enter "exit" to go back to the Menu.'
      break if get_non_empty_input('Enter your choice: ').downcase == 'exit'
    end
  end

  def list
    if @games.empty?
      puts "game is empty\n\n"
    else
      puts "\nList of games:"
      @games.each_with_index do |item, i|
        author_first_name = item&.author ? " Author: \"#{item.author.first_name} #{item.author.last_name}\" " : nil
        puts "  #{i} | #{author_first_name}Publish Date: #{item.publish_date}. id: #{item.id}"
      end
      puts ''
    end
  end

  def save_to_local_storage
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(File.join(DATA_DIR, 'games.json'), 'w') do |file|
      game_data = @games.map do |game|
        {
          id: game.id,
          last_played_at: game.last_played_at,
          multiplayer: game.multiplayer,
          publish_date: game.publish_date,
          author_id: game.author.id
        }
      end
      file.puts(JSON.generate(game_data))
    end
  end

  def read_from_local_storage
    return [] unless File.exist?(File.join(DATA_DIR, 'games.json'))

    begin
      game_json = JSON.parse(File.read(File.join(DATA_DIR, 'games.json')))
    rescue JSON::ParserError
      puts 'Error parsing JSON file. Returning empty array.'
      return []
    end

    game_json.map do |game_data|
      id = game_data.fetch('id', -1)
      last_played_at = game_data.fetch('last_played_at', nil)
      multiplayer = game_data.fetch('multiplayer', false)
      publish_date = game_data.fetch('publish_date') { Date.new(1970, 1, 1) }
      author_id = game_data.fetch('author_id', -1)

      last_played_at_obj = last_played_at ? Date.parse(last_played_at) : nil

      author = author_manager.authors.find { |a| a.id == author_id }

      game = Game.new(last_played_at: last_played_at_obj, multiplayer: multiplayer, id: id,
                      publish_date: Date.parse(publish_date), author: author)
      @games << game
      @items << game
    end
  end

  private

  attr_reader :author_manager
end
