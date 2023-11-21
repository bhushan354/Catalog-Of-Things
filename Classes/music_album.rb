require_relative 'item'

class MusicAlbum < Item
  def initialize(on_spotify: true)
    super(publish_date: Time.new.year)
    @on_spotify = on_spotify
  end
end
