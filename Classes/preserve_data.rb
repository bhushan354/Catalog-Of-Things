require 'json'
require 'fileutils'
require_relative 'author'

class PreserveData
  DATA_DIR = 'data'.freeze

  def self.ensure_data_directory
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)
  end

  def self.save_authors(authors)
    ensure_data_directory

    File.open(File.join(DATA_DIR, 'authors.json'), 'w') do |file|
      author_data = authors.map do |author|
        {
          id: author.id,
          fn: author.first_name,
          ln: author.last_name
        }
      end
      file.puts(JSON.generate(author_data))
    end
  end

  def self.load_authors
    return [] unless File.exist?(File.join(DATA_DIR, 'authors.json'))

    authors_json = JSON.parse(File.read(File.join(DATA_DIR, 'authors.json')))

    authors_json.map do |author_data|
      first_name = author_data.fetch('fn', '_Unknown_LN')
      last_name = author_data.fetch('ln', '_Unknown_LN')
      id = author_data.fetch('id', -1)

      author = Author.new(first_name, last_name, id)
      author
    end
  end
end
