require_relative 'book'
require_relative 'label'
require_relative 'author'
require 'json'
require 'date'
require_relative 'game'
require_relative 'author_service'
require_relative 'utils/util'
require_relative 'utils/unix_text.color'
require_relative 'game_service'
require_relative 'music_album_service'
require_relative 'label_service'
require_relative 'book_service'

def list_menu_option_display
  puts "\nSelect choice"
  puts '  1. To list games'
  puts '  2. To MusicAlbum (not yet available)'
  puts '  3. To list books'
  puts '  4. To list all items'
  puts '  0. Back to App menu'
  print "#{GREEN_COLOR}List Items >>#{END_COLOR} "
  gets.chomp.to_i
end

def create_item_options
  puts "\nSelect choice"
  puts '  1. To create game'
  puts '  2. To create book'
  puts '  3. To create Music Album (not yet available)'
  puts '  0. Back to App menu'
  print "#{GREEN_COLOR}Add Items >>#{END_COLOR} "
end

class App
  def initialize
    @books = []
    @labels = []
    @authors = []

    @items = []
    @music_album_creator = MusicAlbumService.new
    @author_manager = AuthorService.new
    @label_manager = LabelService.new

    @game_creator = GameService.new(@author_manager, @items)
    @book_creator = BookService.new(@items)
  end

  def create_book
    @book_creator.create_book
  end

  def list_books
    @book_creator.list_books
  end

  def create_label
    @label_manager.create_label
  end

  def display_labels
    @label_manager.display_labels
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
        author_first_name = item&.author ? "Author: \"#{item.author.first_name} #{item.author.last_name}\" " : nil
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
      create_item_options

      choice = gets.chomp.to_i
      puts "\n"

      case choice
      when 1
        create_game
      when 2
        create_book
      when 3
        "Creating MusicAlbum functionality is not yet implemented.\n"
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def list_items_menu
    loop do
      choice = list_menu_option_display
      puts "\n"

      break if choice.zero?

      case choice
      when 1
        @game_creator.list
      when 2
        puts "MusicAlbum listing functionality is not yet implemented.\n"
      when 3
        list_books
      when 4
        list_items
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def create_game
    @game_creator.create_game
  end

  def create_music_album
    @music_album_creator.create_music_album
  end

  def list_all_music_albums
    @music_album_creator.list_all_music_albums
  end

  # you can add your required def here
end
