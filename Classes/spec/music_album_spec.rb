# spec/music_album_spec.rb
require 'date'
require_relative '../item'
require_relative '../music_album'

describe MusicAlbum do
  describe '#initialize' do
    context 'with valid parameters' do
      it 'creates a MusicAlbum instance' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1')
        expect(album).to be_a(MusicAlbum)
      end

      it 'sets the on_spotify attribute' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1', on_spotify: false)
        expect(album.on_spotify).to eq(false)
      end

      it 'raises an error if on_spotify is not a boolean' do
        expect do
          MusicAlbum.new(label: 'Album 1', author: 'Artist 1', on_spotify: 'invalid')
        end.to raise_error(ArgumentError)
      end

      it 'raises an error if publish_date is not a Date object' do
        expect do
          MusicAlbum.new(label: 'Album 1', author: 'Artist 1', publish_date: 'invalid')
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#can_be_archived?' do
    context 'when the album can be archived' do
      it 'returns true' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1')
        expect(album.can_be_archived?).to eq(true)
      end
    end

    context 'when the album cannot be archived' do
      it 'returns false if on_spotify is false' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1', on_spotify: false)
        expect(album.can_be_archived?).to eq(false)
      end

      it 'returns false if the parent class cannot be archived' do
        allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(false)
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1')
        expect(album.can_be_archived?).to eq(false)
      end
    end
  end

  describe 'private methods' do
    describe '#validate_on_spotify' do
      it 'outputs a warning if on_spotify is false' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1', on_spotify: false)
        expect { album.send(:validate_on_spotify) }.to output("Warning: Album is not on Spotify\n").to_stdout
      end

      it 'does not output a warning if on_spotify is true' do
        album = MusicAlbum.new(label: 'Album 1', author: 'Artist 1', on_spotify: true)
        expect { album.send(:validate_on_spotify) }.to_not output.to_stdout
      end
    end
  end
end
