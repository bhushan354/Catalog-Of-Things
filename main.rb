#!/usr/bin/env ruby

require_relative 'Classes/app'
require_relative 'Classes/utils/unix_text.color'

EXIT_MESSAGE = "\nThank you for using this app\n\n".freeze

app = App.new
def memu_options
  puts "#{BLUE_COLOR}Main Menu#{END_COLOR} - select an option by number."
  puts "1. List Items#{BLUE_COLOR}(+)#{END_COLOR}"
  puts '2. List Authors'
  puts '3. List Label'
  puts '4. List Genre'
  puts "\t#{BLACK_COLOR}-#{END_COLOR}"
  puts "5. Create Items#{BLUE_COLOR}(+)#{END_COLOR}"
  puts '6. Create Author'
  puts '7. Create Label'
  puts '8. Create Genre'
  puts "\t#{BLACK_COLOR}-#{END_COLOR}"
  puts '0. Quit'

  print "#{GREEN_COLOR}>>#{END_COLOR} "
  gets.chomp.to_i
end

loop do
  choice = memu_options

  if choice.zero?
    puts EXIT_MESSAGE
    break
  end

  case choice
  when 1
    app.list_items_menu
  when 2
    app.list_authors
  when 3
    app.display_labels
  when 4
    app.list_genres
  when 5
    app.create_item
  when 6
    app.create_author
  when 7
    app.create_label
  when 8
    app.create_genre
  else
    puts 'Invalid choice. Please try again.'
  end
rescue Interrupt
  puts EXIT_MESSAGE
  break
end
