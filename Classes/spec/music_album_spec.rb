require 'date'
require_relative '../music_album'
require_relative '../item'
require_relative '../genre'

RSpec.describe MusicAlbum do
  let(:today) { Date.today }
  let(:genre) { Genre.new('Rock') }

  describe '#initialize' do
    it 'creates a MusicAlbum with default values' do
      album = MusicAlbum.new
      expect(album.published_date).to eq(today)
      expect(album.on_spotify).to be_falsey
      expect(album.id).to be_an(Integer)
    end

    it 'creates a MusicAlbum with specified values' do
      album = MusicAlbum.new(today, 123, genre: genre, on_spotify: true)
      expect(album.published_date).to eq(today)
      expect(album.on_spotify).to be_truthy
      expect(album.id).to eq(123)
      expect(album.genre).to eq(genre)
      expect(genre.items).to include(album)
    end

    it 'raises an error for invalid on_spotify value' do
      expect { MusicAlbum.new(on_spotify: 'invalid') }.to raise_error(ArgumentError, 'on_spotify must be either true or false')
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if published over 10 years ago and on_spotify is true' do
      album = MusicAlbum.new(today - 11 * 365, on_spotify: true)
      expect(album.can_be_archived?).to be_truthy
    end

    it 'returns false if published less than 10 years ago' do
      album = MusicAlbum.new(today - 9 * 365, on_spotify: true)
      expect(album.can_be_archived?).to be_falsey
    end

    it 'returns false if not on_spotify' do
      album = MusicAlbum.new(today - 11 * 365, on_spotify: false)
      expect(album.can_be_archived?).to be_falsey
    end
  end

  describe '#genre=' do
    it 'sets the genre and adds the album to the genre' do
      album = MusicAlbum.new
      album.genre = genre
      expect(album.genre).to eq(genre)
      expect(genre.items).to include(album)
    end

    it 'does not add the album to the genre if already present' do
      album = MusicAlbum.new(genre: genre)
      album.genre = genre
      expect(genre.items.count(album)).to eq(1)
    end
  end
end
