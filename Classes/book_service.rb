require 'date'
require_relative 'book'
require_relative 'utils/util'

class BookService
  DATA_DIR = 'data'.freeze
  BOOKS_FILE = File.join(DATA_DIR, 'books.json').freeze

  def initialize(items)
    @books = []
    @items = items
    load_books_from_file
  end

  def create_book
    date = get_date_input('Publishing date')

    first_name = get_non_empty_input('Publisher First Name')
    last_name = get_non_empty_input('Publisher Last Name')

    publisher = "#{first_name} #{last_name}"
    cover = get_non_empty_input('Cover state')

    book = Book.new(publisher, cover, date)
    @items << book
    @books << book
    save_books_to_file
    puts 'Book Created Successfully'
  end

  def list_books
    if @books.empty?
      puts "Book is empty\n\n"
    else
      puts "\nList of Books:"

      @books.each_with_index do |item, i|
        print "  #{i} | Publisher: #{item.publisher} - Cover_state: #{item.cover_state} "
        puts "- publish_date: #{item.publish_date} id: #{item.id}"
      end
      puts ''
    end
  end

  private

  def save_books_to_file
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(BOOKS_FILE, 'w') do |file|
      book_data = @books.map do |book|
        {
          publisher: book.publisher,
          cover_state: book.cover_state,
          publish_date: book.publish_date,
          id: book.id
        }
      end
      file.puts(JSON.generate(book_data))
    end
  end

  def load_books_from_file
    return unless File.exist?(BOOKS_FILE)

    begin
      books_json = JSON.parse(File.read(BOOKS_FILE))
    rescue JSON::ParserError
      puts 'Error parsing JSON file. Returning empty array.'
      return
    end

    books_json.each do |book_data|
      publisher = book_data.fetch('publisher', '_Unknown_Publisher')
      cover_state = book_data.fetch('cover_state', '_Unknown_Cover')
      publish_date = book_data.fetch('publish_date', Date.today)
      id = book_data.fetch('id', -1)

      book = Book.new(publisher, cover_state, publish_date, id: id)
      @books << book
      @items << book
    end
  end
end
