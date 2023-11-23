require_relative 'book'
require_relative 'label'
require_relative 'author'
require 'json'
require 'date'
require_relative 'game'
require_relative 'author_service'
require_relative 'utils/util'
require_relative 'game_service'

class App
  def initialize
    @books = []
    @labels = []
    @authors = []

    @all_things = []

    # All subclass of item class (Book, MusicAlbum, Movie, and Game) should be push here
    @items = []

    @author_manager = AuthorService.new
    @game_creator = GameService.new(@author_manager, @items)
  end

  def create_book
    date = get_date_input('Publishing date')

    first_name = get_non_empty_input('Publisher First Name')
    last_name = get_non_empty_input('Publisher Last Name')
    instance_author = Author.new(first_name, last_name)
    publisher = "#{first_name} #{last_name}"
    cover = get_non_empty_input('Cover state')

    book = Book.new(publisher, cover, date)
    @items << book
    @books << book
    instance_author.add_item(book)
    @authors << instance_author
    write_to_file(@authors, './dataJSON/authors.json')
    write_to_file(@books, './dataJSON/books.json')
    puts 'Book Created Successfully'
  end

  def display_books
    @books = read_from_file('./dataJSON/books.json')
    puts 'Book list is empty' if @books.empty?
    @books.each_with_index do |book, i|
      puts "#{i}) Publisher: #{book.publisher}, " \
           "Cover state: #{book.cover_state}, " \
           "Publish date: #{book.publish_date}"
    end
  end

  def create_label
    title = get_non_empty_input('Title')

    color = get_non_empty_input('Color')
    label = Label.new(title, color)
    @labels << label
    @items << label
    write_to_file(@labels, './dataJSON/labels.json')
    puts 'Label Created Successfully'
  end

  def display_labels
    @labels = read_from_file('./dataJSON/labels.json')
    puts 'Label list is empty' if @labels.empty?
    @labels.each_with_index do |label, i|
      puts "#{i}) Title: #{label.title}, Color: #{label.color}"
    end
  end

  def write_to_file(data, file_path)
    File.open(file_path, 'w') do |file|
      file.puts(JSON.generate(data))
    end
    puts "File written successfully to #{file_path}"
  rescue StandardError => e
    puts "Error writing to file #{file_path}: #{e.message}"
  end

  def read_from_file(file_path)
    JSON.parse(File.read(file_path))
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
        author_first_name = item&.author ? " Author: \"#{item.author.first_name} #{item.author.last_name}\" " : nil
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
        puts "Creating Movie functionality is not yet implemented.\n\n"
      when 4
        puts "Creating Music functionality is not yet implemented.\n\n"
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def list_items_menu
    loop do
      list_menu_option_display

      choice = gets.chomp.to_i
      puts "\n"

      case choice
      when 1
        @game_creator.list
      when 2
        puts "Music listing functionality is not yet implemented.\n\n"
      when 3
        puts "Music-Album listing functionality is not yet implemented.\n\n"
      when 4
        puts "Book listing functionality is not yet implemented.\n\n"
      when 5
        puts "Movies listing functionality is not yet implemented.\n\n"
      when 6
        list_items
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def create_game
    @game_creator.create_game
  end

  private

  def list_menu_option_display
    puts 'Select choice'
    puts '  1. To list games'
    puts '  2. To Music Album (not yet available)'
    puts '  3. To list Music-Album (not yet available)'
    puts '  4. To list books'
    puts '  5. To list movies (not yet available)'
    puts '  6. To list all items'
    puts '  0. Back to App menu'
    print 'List Items >> '
  end

  def create_item_options
    puts 'Select choice'
    puts '  1. To create game'
    puts '  2. To create book'
    puts '  3. To create Movie (not yet available)'
    puts '  4. To create Music Album (not yet available)'
    puts '  0. Back to App menu'
    print 'Add Items >> '
  end
  # you can add your required def here
end
