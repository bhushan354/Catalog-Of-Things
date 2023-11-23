require 'date'
require_relative 'game'
require_relative 'author_app'
require_relative 'utils/util'
require_relative 'music_album'

class App
  def initialize
    @all_things = []

    # All subclass of item class (Book, MusicAlbum, Movie, and Game) should be push here
    @items = []
    @music_albums = []
    @author_manager = AuthorApp.new
  end

  def create_book
    print 'Date of publishing: '
    date = gets.chomp

    book = Book.new(date)
    @all_things << book
    puts 'Item Created Successfully'
  end

  def list_authors
    @author_manager.list_authors
  end

  def list_items
    if @items.empty?
      puts "Item is empty\n\n"
    else
      puts "\nList of Items:"
      @items.each_with_index do |item, i|
        author_first_name = item.author ? " Author: \"#{item.author.first_name} #{item.author.last_name}\" " : nil
        puts "  #{i} | [#{item.class.name}] -#{author_first_name}Publish Date: #{item.publish_date}. id: #{item.id}"
      end
      puts ''
    end
  end

  def create_author
    @author_manager.create_author
  end

  def create_item
    loop do
      puts 'Select choice'
      puts '  1. To create game'
      puts '  0. Back to menu'
      print 'Add Items >> '
      choice = gets.chomp.to_i
      puts "\n"

      case choice
      when 1
        create_game
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def create_game
    return unless @author_manager.check_and_create_author

    publish_date = get_date_input('Publish date')
    last_played_at = get_date_input('Last played date')
    multiplayer = get_boolean_input('Is it multiplayer?')

    loop do
      list_authors

      author_id = get_non_empty_input('Select Author by ID listed above').to_i
      author = @author_manager.authors.find { |i| i.id == author_id }

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
  # you can add your required def here

  def create_music_album
    puts 'Creating a new music album:'

    print 'Enter label: '
    label = gets.chomp

    print 'Enter author: '
    author = gets.chomp

    print 'Is the album on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    print 'Enter the publish date (YYYY-MM-DD, press Enter for today): '
    publish_date_input = gets.chomp
    publish_date = parse_publish_date(publish_date_input)

    puts "The publish date is #{publish_date}"

    music_album = MusicAlbum.new(label: label, author: author, on_spotify: on_spotify, publish_date: publish_date)
    @music_albums << music_album

    puts 'Music album created successfully!'
  end

  def list_all_music_albums
    puts 'List of all music albums:'

    @music_albums.each do |album|
      puts "[#{album.publish_date}] Label: #{album.label}, Author: #{album.author}"
    end
    puts
  end

  private

  def parse_publish_date(input)
    return Date.today if input.empty?

    begin
      Date.parse(input)
    rescue ArgumentError
      puts 'Invalid date format. Using today\'s date.'
      Date.today
    end
  end
end
