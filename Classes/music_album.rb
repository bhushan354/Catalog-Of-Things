require 'date'
require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify
  attr_reader :id, :genre

  def initialize(publish_date = Date.today, id = Random.rand(1..1000), genre: nil, on_spotify: false)
    raise ArgumentError, 'on_spotify must be either true or false' unless [true, false].include?(on_spotify)

    super(id, publish_date)
    @on_spotify = on_spotify
    return unless genre

    @genre = genre
    genre.items << self
  end

  def can_be_archived?
    super && @on_spotify
  end

  def genre=(new_genre)
    new_genre.items << self if new_genre && !new_genre.items.include?(self)
  end

  private

  def validate_on_spotify
    puts 'Warning: Album is not on Spotify' unless @on_spotify
  end
end
