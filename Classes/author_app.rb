require_relative 'utils/util'
require_relative 'author'
require_relative 'preserve_data'

class AuthorApp
  attr_reader :authors

  def initialize
    @authors = PreserveData.load_authors
  end

  def create_author
    first_name = get_non_empty_input('Author first name')
    last_name = get_non_empty_input('Author last name')

    author = Author.new(first_name, last_name)
    @authors << author
    PreserveData.save_authors(@authors)

    puts "Author #{author.first_name}#{author.id} created successfully!"
    author
  end

  def list_authors
    if @authors.empty?
      check_and_create_author
    else
      puts 'List of Authors:'
      @authors.each_with_index do |author, i|
        puts "  #{i} | Name: \"#{author.first_name} #{author.last_name}\". id:#{author.id}"
      end
      puts ''
    end
  end

  def check_and_create_author
    return false unless @authors.empty?

    puts 'Author is empty'
    choice = get_boolean_input('Do you want to create an author?')
    puts ''
    return choice unless choice

    create_author
    choice
  end
end
