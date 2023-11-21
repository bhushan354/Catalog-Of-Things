require 'date'
require_relative 'author'
require_relative 'game'

class App
  def initialize
    @all_things = []
    @items = []
    @authors = []
  end

  def create_book
    print 'Date of publishing: '
    date = gets.chomp

    book = Book.new(date)
    @all_things << book
    puts 'Item Created Successfully'
  end

  def list_authors
    if @authors.empty?
      check_and_create_author
    else
      puts "\nList of Authors:"
      @authors.each_with_index do |author, i|
        puts "  #{i} | Name: #{author.first_name} #{author.last_name}. id:#{author.id}"
      end
      puts ''
    end
  end

  def list_items
    if @items.empty?
      puts 'Items is empty'
    else
      puts "\nList of Items:"
      @items.each_with_index do |item, i|
        puts "  #{i} | [#{item.class.name}] Publish Date: #{item.publish_date}. id: #{item.id}"
      end
      puts ''
    end
  end

  def create_author
    first_name = get_non_empty_input('Author first name')
    last_name = get_non_empty_input('Author last name')

    author = Author.new(first_name, last_name)
    @authors << author

    puts "Author #{author.first_name}#{author.id} created successfully!"
    author
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
    last_played_at = get_date_input('Last played date')
    multiplayer = get_boolean_input('Is it multiplayer?')
    publish_date = get_date_input('Publish date')

    loop do
      check_and_create_author

      list_authors
      author_id = get_non_empty_input('Select Author by ID listed above').to_i
      author = @authors.find { |i| i.id == author_id }

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

  def get_non_empty_input(prompt)
    input = nil
    loop do
      print "#{prompt}: "
      input = gets.chomp.strip
      break unless input.empty?

      puts "\"#{prompt}\" cannot be empty. Please try again."
    end
    input
  end

  def get_date_input(prompt)
    loop do
      print "#{prompt} (YYYY-MM-DD): "
      input = gets.chomp.strip

      case
      when /^\d{4}-\d{2}-\d{2}$/.match?(input)
        return input
      when input.casecmp('now').zero? || input.casecmp('today').zero?
        return Date.today
      when input.empty? || input.casecmp('nil').zero? || input.casecmp('null').zero?
        return nil
      else
        puts 'Invalid date format. Please enter a date in the format YYYY-MM-DD.'
      end
    end
  end

  def get_boolean_input(prompt)
    loop do
      print "#{prompt} (Y/N): "
      input = gets.chomp.strip.downcase

      case input
      when 'y'
        return true
      when 'n'
        return false
      else
        puts 'Invalid input. Please enter Y/N.'
      end
    end
  end

  def check_and_create_author
    return unless @authors.empty?

    puts 'No author is currently in the list'
    choice = get_boolean_input('Do you want to create an author?')
    return unless choice

    create_author
  end

  # you can add your required def here
end
