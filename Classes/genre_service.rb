require_relative 'utils/util'
require_relative 'genre'
require 'json'
require 'fileutils'

class GenreService
  DATA_DIR = 'data'.freeze

  attr_reader :genres

  def initialize
    @genres = read_from_local_storage
  end

  def create_genre
    name = get_non_empty_input('Genre name')

    genre = Genre.new(name)
    @genres << genre

    save_to_local_storage

    puts "Genre: \"#{genre.name}(#{genre.id})\" created successfully!\n\n"
    genre
  end

  def list_genres
    if @genres.empty?
      check_and_create_genre
    else
      puts 'List of Genres:'
      @genres.each_with_index do |genre, i|
        puts "  #{i} | Name: #{genre.name}. id:#{genre.id}"
      end
      puts ''
    end
  end

  def check_and_create_genre
    return unless @genres.empty?

    puts 'Genre is empty'
    choice = get_boolean_input('Do you want to create a genre?')
    puts ''
    return unless choice

    create_genre
  end

  def save_to_local_storage
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(File.join(DATA_DIR, 'genres.json'), 'w') do |file|
      genre_data = @genres.map do |genre|
        {
          id: genre.id,
          name: genre.name
        }
      end
      file.puts(JSON.generate(genre_data))
    end
  end

  def read_from_local_storage
    return [] unless File.exist?(File.join(DATA_DIR, 'genres.json'))

    begin
      genres_json = JSON.parse(File.read(File.join(DATA_DIR, 'genres.json')))
    rescue JSON::ParserError
      puts 'Error parsing JSON file. Returning empty array.'
      return []
    end

    genres_json.map do |genre_data|
      name = genre_data.fetch('name', '_Unknown_Genre')
      id = genre_data.fetch('id', -1)

      genre = Genre.new(name, id)
      genre
    end
  end
end
