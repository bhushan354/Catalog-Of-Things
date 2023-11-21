require 'date'
require_relative 'item'

class MusicAlbum < Item
  def initialize(publish_date = Date.today, id = Random.rand(1..1000), on_spotify: true)
    raise ArgumentError, 'on_spotify must be either true or false' unless [true, false].include?(on_spotify)
    raise ArgumentError, 'publish_date must be a Date object' unless publish_date.is_a?(Date)

    super(id, validate_publish_date(publish_date))
    validate_on_spotify(on_spotify)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end
end
