require 'date'
require_relative 'music_album'
require_relative 'utils/util'

class MusicAlbumService
  DATA_DIR = 'data'.freeze

  def initialize(genre_manager, items)
    @genre_manager = genre_manager
    @items = items
    @music_albums = []

    read_from_local_storage
  end

  def create_music_album
    genre_manager.check_and_create_genre

    publish_date = get_date_input('Publish date')
    on_spotify = get_boolean_input('Is it on Spotify?')

    loop do
      genre_manager.list_genres

      genre_id = get_non_empty_input('Select Genre by ID listed above').to_i
      genre = genre_manager.genres.find { |g| g.id == genre_id }

      if genre
        music_album = MusicAlbum.new(publish_date || Date.today, on_spotify: on_spotify, genre: genre)
        @items << music_album
        @music_albums << music_album
        save_to_local_storage
        puts 'Music Album added successfully!'
        break
      end

      puts 'Invalid genre ID. Please choose a correct genre ID listed above or enter "exit" to go back to the Menu.'
      break if get_non_empty_input('Enter your choice: ').downcase == 'exit'
    end
  end

  def list
    if @music_albums.empty?
      puts "Music Album is empty\n\n"
    else
      puts "\nList of Music Albums:"
      @music_albums.each_with_index do |item, i|
        genre_name = item&.genre ? " Genre: \"#{item.genre.name}\" " : nil
        puts "  #{i} | #{genre_name}Publish Date: #{item.publish_date}. id: #{item.id}"
      end
      puts ''
    end
  end

  def save_to_local_storage
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(File.join(DATA_DIR, 'music_albums.json'), 'w') do |file|
      music_album_data = @music_albums.map do |music_album|
        {
          id: music_album.id,
          on_spotify: music_album.on_spotify,
          publish_date: music_album.publish_date,
          genre_id: music_album.genre.id
        }
      end
      file.puts(JSON.generate(music_album_data))
    end
  end

  def read_from_local_storage
    return [] unless File.exist?(File.join(DATA_DIR, 'music_albums.json'))

    begin
      music_album_json = JSON.parse(File.read(File.join(DATA_DIR, 'music_albums.json')))
    rescue JSON::ParserError
      puts 'Error parsing JSON file. Returning empty array.'
      return []
    end

    music_album_json.map do |music_album_data|
      id = music_album_data.fetch('id', -1)
      on_spotify = music_album_data.fetch('on_spotify', false)
      publish_date = music_album_data.fetch('publish_date') { Date.new(1970, 1, 1) }
      genre_id = music_album_data.fetch('genre_id', -1)

      genre = genre_manager.genres.find { |g| g.id == genre_id }

      music_album = MusicAlbum.new(Date.parse(publish_date), id, genre: genre, on_spotify: on_spotify)
      @music_albums << music_album
      @items << music_album
    end
  end

  private

  attr_reader :genre_manager
end
