# music_album.rb
require 'date'
require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(label: nil, author: nil, on_spotify: true, publish_date: Date.today, id: Random.rand(1..1000))
    raise ArgumentError, 'on_spotify must be either true or false' unless [true, false].include?(on_spotify)
    raise ArgumentError, 'publish_date must be a Date object' unless publish_date.is_a?(Date)

    super(id, publish_date)

    @on_spotify = on_spotify
    @label = label
    @author = author

    validate_on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end

  private

  def validate_on_spotify
    puts 'Warning: Album is not on Spotify' unless @on_spotify
  end
end
