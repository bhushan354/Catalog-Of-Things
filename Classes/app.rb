require_relative 'book'
require_relative 'label'
require_relative 'author'
require 'json'
require 'date'
require_relative 'game'
require_relative 'author_app'
require_relative 'utils/util'

class App
  def initialize
    @books = []
    @labels = []
    @authors = []

    @all_things = []

    # All subclass of item class (Book, MusicAlbum, Movie, and Game) should be push here
    @items = []

    @author_manager = AuthorApp.new
  end

  def create_book
    print 'Date of publishing: '
    date = gets.chomp.to_s

    print 'Publisher First Name: '
    first_name = gets.chomp.to_s
    print 'Publisher Last Name: '
    last_name = gets.chomp.to_s
    instance_author = Author.new(first_name, last_name)
    publisher = "#{first_name} #{last_name}"
    print 'Cover state: '
    cover = gets.chomp.to_s

    book = Book.new(publisher, cover, date)
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
    print 'Title: '
    title = gets.chomp.to_s

    print 'Color: '
    color = gets.chomp.to_s

    @labels << Label.new(title, color)
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
end
