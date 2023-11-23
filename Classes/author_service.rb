require_relative 'utils/util'
require_relative 'author'
require 'json'
require 'fileutils'

class AuthorService
  DATA_DIR = 'data'.freeze

  attr_reader :authors

  def initialize
    @authors = read_from_local_storage
  end

  def create_author
    first_name = get_non_empty_input('Author first name')
    last_name = get_non_empty_input('Author last name')

    author = Author.new(first_name, last_name)
    @authors << author

    save_to_local_storage

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
    return unless @authors.empty?

    puts 'Author is empty'
    choice = get_boolean_input('Do you want to create an author?')
    puts ''
    return unless choice

    create_author
  end

  def save_to_local_storage
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(File.join(DATA_DIR, 'authors.json'), 'w') do |file|
      author_data = @authors.map do |author|
        {
          id: author.id,
          fn: author.first_name,
          ln: author.last_name
        }
      end
      file.puts(JSON.generate(author_data))
    end
  end

  def read_from_local_storage
    return [] unless File.exist?(File.join(DATA_DIR, 'authors.json'))

    begin
      authors_json = JSON.parse(File.read(File.join(DATA_DIR, 'authors.json')))
    rescue JSON::ParserError
      puts 'Error parsing JSON file. Returning empty array.'
      return []
    end

    authors_json.map do |author_data|
      first_name = author_data.fetch('fn', '_Unknown_LN')
      last_name = author_data.fetch('ln', '_Unknown_LN')
      id = author_data.fetch('id', -1)

      author = Author.new(first_name, last_name, id)
      author
    end
  end
end
