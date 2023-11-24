require_relative 'Classes/music_album'
require_relative 'Classes/genre'

genre1 = Genre.new('HipHop')
genre2 = Genre.new('Live')
music_album1 = MusicAlbum.new
music_album2 = MusicAlbum.new
music_album4 = MusicAlbum.new

puts genre1.name
puts music_album1.id

music_album3 = MusicAlbum.new(genre: genre1)
genre1.add_item(music_album1)
genre1.add_item(music_album2)
music_album4.genre = genre1
music_album4.genre = genre2

# puts music_album3.genre.name

puts '*' * 10

puts genre1.items

genre1.items.each_with_index do |element, index|
  puts "#{index + 1}. #{element.id}"
end

# puts genre1.items[0].id
# puts genre1.items[1].id
# puts genre1.items[2].id
