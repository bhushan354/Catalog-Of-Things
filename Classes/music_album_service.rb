require_relative 'music_album'

class MusicAlbumService
  attr_reader :music_albums

  def initialize()
    @music_albums = []
  end

  def create_music_album
    puts 'Creating a new music album:'

    print 'Enter label: '
    label = gets.chomp

    print 'Enter author: '
    author = gets.chomp

    print 'Is the album on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    print 'Enter the publish date (YYYY-MM-DD, press Enter for today): '
    publish_date_input = gets.chomp
    publish_date = parse_publish_date(publish_date_input)

    puts "The publish date is #{publish_date}"

    music_album = MusicAlbum.new(label: label, author: author, on_spotify: on_spotify, publish_date: publish_date)
    @music_albums << music_album

    puts 'Music album created successfully!'
  end

  def list_all_music_albums
    puts 'List of all music albums:'

    @music_albums.each do |album|
      puts "[#{album.publish_date}] Label: #{album.label}, Author: #{album.author}"
    end
    puts
  end
end
