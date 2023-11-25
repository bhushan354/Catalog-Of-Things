require_relative '../genre'
require_relative '../music_album'
require 'rspec'

describe Genre do
  let(:genre_name) { 'Pop' }
  let(:genre_id) { 123 }

  let(:music_album) { MusicAlbum.new }
  let(:non_item) { double('NonItem', is_a?: false) }

  subject(:genre) { Genre.new(genre_name, genre_id) }

  describe '#initialize' do
    it 'initializes a genre with a name and id' do
      expect(genre.name).to eq(genre_name)
      expect(genre.id).to eq(genre_id)
    end

    it 'raises an error if the name is not a non-empty string' do
      expect { Genre.new(nil) }.to raise_error(ArgumentError)
      expect { Genre.new('') }.to raise_error(ArgumentError)
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      genre.add_item(music_album)
      expect(genre.items.size).to eq(1)
    end

    it 'raises an error if the item is not an instance of Item or its subclass' do
      expect { genre.add_item(non_item) }.to raise_error(ArgumentError)
    end
  end
end
