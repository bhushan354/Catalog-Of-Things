#!/usr/bin/ruby -w

require_relative 'Classes/game'
require_relative 'Classes/author'

author = Author.new('Stanley', 'Osagie')

game1 = Game.new(
  last_played_at: DateTime.new(2010, 1, 1),
  multiplayer: true,
  publish_date: DateTime.new(2023, 1, 1)
)

game2 = Game.new(
  last_played_at: DateTime.new(2023, 1, 1),
  multiplayer: true,
  publish_date: DateTime.new(2023, 1, 1)
)

author.add_item(game1)
author.add_item(game2)

puts "Author: #{author.first_name} #{author.last_name}, ID: #{author.id}"
puts "Items by #{author.first_name}:"

author.items.each do |item|
  puts "  - #{item.class}: ID #{item.id}, Published on #{item.publish_date}"
  next unless item.is_a?(Game)

  puts "\t- Multiplayer: #{item.multiplayer ? 'Yes' : 'No'}"
  puts "\t- Last Played At: #{item.last_played_at}"
  puts "\t- Can be archived? #{item.can_be_archived? ? 'Yes' : 'No'}"
  puts "\t- Game archived? #{item.archived ? 'Yes' : 'No'}"
end

game1.move_to_archive
puts "\nMoving game1 to archive..."
puts "Game1 archived? #{game1.archived ? 'Yes' : 'No'}"

game2.move_to_archive
puts "\nMoving game2 to archive..."
puts "Game2 archived? #{game2.archived ? 'Yes' : 'No'}"

puts game1.class.name

game1.author = author

puts author.items[0].publish_date
puts game1.author.first_name
