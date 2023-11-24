require_relative 'label'
require 'json'
require 'fileutils'

class LabelService
  attr_reader :labels

  DATA_DIR = './data'.freeze
  LABELS_FILE = File.join(DATA_DIR, 'labels.json').freeze

  def initialize
    @labels = []
    load_labels_from_json
  end

  def create_label
    title = get_non_empty_input('Title')
    color = get_non_empty_input('Color')
    label = Label.new(title, color)
    @labels << label
    save_labels_to_json
    puts "Label Created Successfully\n\n"
  end

  def display_labels
    if @labels.empty?
      puts "Label is empty\n\n"
    else
      puts "\n"
      @labels.each_with_index do |label, i|
        puts "#{i}) Title: #{label.title}, Color: #{label.color}"
      end
      puts "\n"
    end
  end

  private

  def save_labels_to_json
    FileUtils.mkdir_p(DATA_DIR) unless File.directory?(DATA_DIR)

    File.open(LABELS_FILE, 'w') do |file|
      label_data = @labels.map do |label|
        {
          title: label.title,
          color: label.color,
          id: label.id
        }
      end
      file.puts(JSON.generate(label_data))
    end
  end

  def load_labels_from_json
    return unless File.exist?(LABELS_FILE)

    json_data = File.read(LABELS_FILE)
    label_data = JSON.parse(json_data)

    label_data.each do |label|
      @labels << Label.new(label['title'], label['color'], label['id'])
    end
  end
end
