#!/usr/bin/ruby -w

require_relative 'Classes/app'

EXIT_MESSAGE = "\nThank you for using this app\n\n".freeze

app = App.new

loop do
  puts 'Main Menu:'
  puts '1. List Authors'
  puts '2. List Items'
  puts '3. Create Items'
  puts '4. Create Author'
  puts '5. Create Label'
  puts '0. Quit'

  print '>> '
  choice = gets.chomp.strip
  puts "\n"

  case choice
  when '1'
    app.list_authors
  when '2'
    app.list_items_menu
  when '3'
    app.create_item
  when '4'
    app.create_author
  when '5'
    app.create_label
  when '0'
    puts EXIT_MESSAGE
    break
  else
    puts 'Invalid choice. Please try again.'
  end
rescue Interrupt
  puts EXIT_MESSAGE
  break
end
