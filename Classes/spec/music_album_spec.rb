require 'date'
require_relative '../music_album'
require_relative '../item'
require_relative '../genre'

RSpec.describe MusicAlbum do
  let(:today) { Date.today }
  let(:genre) { Genre.new('Rock') }

  describe '#initialize' do
    it 'raises an error for invalid on_spotify value' do
      expect { MusicAlbum.new(on_spotify: 'invalid') }.to raise_error(ArgumentError, 'on_spotify must be either true or false')
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if published over 10 years ago and on_spotify is true' do
      album = MusicAlbum.new(today - (11 * 365), on_spotify: true)
      expect(album.can_be_archived?).to be_truthy
    end

    it 'returns false if not on_spotify' do
      album = MusicAlbum.new(today - (11 * 365), on_spotify: false)
      expect(album.can_be_archived?).to be_falsey
    end
  end

  describe '#genre=' do
    it 'does not add the album to the genre if already present' do
      album = MusicAlbum.new(genre: genre)
      album.genre = genre
      expect(genre.items.count(album)).to eq(1)
    end
  end
end
