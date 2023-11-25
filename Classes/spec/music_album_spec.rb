require_relative '../music_album'
require_relative '../genre'
require 'rspec'

describe MusicAlbum do
  let(:publish_date) { Date.today }
  let(:id) { Random.rand(1..1000) }
  let(:genre) { Genre.new('Pop') }

  subject(:album) { MusicAlbum.new(publish_date, id, genre: genre, on_spotify: true) }

  describe '#initialize' do
    it 'initializes a music album with a publish date, id, genre, and on_spotify flag' do
      expect(album.publish_date).to eq(publish_date)
      expect(album.id).to eq(id)
      expect(album.genre).to eq(genre)
      expect(album.on_spotify).to be_truthy
    end

    it 'raises an error if the on_spotify flag is not true or false' do
      expect { MusicAlbum.new(on_spotify: 'invalid_value') }.to raise_error(ArgumentError)
    end
  end

  describe '#can_be_archived?' do
    it 'returns false if the album is not on Spotify' do
      album = MusicAlbum.new(publish_date, id, genre: genre)
      expect(album.can_be_archived?).to be_falsy
    end
  end

  describe '#genre=' do
    it 'does nothing if the new genre is the same as the old genre' do
      album.genre = genre
      expect(album.genre).to eq(genre)
    end
  end
end
