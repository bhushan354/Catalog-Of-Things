require_relative '../item'
require_relative '../genre'

describe Genre do
  describe '#initialize' do
    context 'with valid parameters' do
      it 'creates a Genre instance' do
        genre = Genre.new('Rock')
        expect(genre).to be_a(Genre)
      end

      it 'sets the name attribute' do
        genre = Genre.new('Rock')
        expect(genre.name).to eq('Rock')
      end

      it 'sets a random id if not provided' do
        allow(Random).to receive(:rand).and_return(42)
        genre = Genre.new('Pop')
        expect(genre.id).to eq(42)
      end

      it 'raises an error if name is not a non-empty string' do
        expect { Genre.new(nil) }.to raise_error(ArgumentError)
        expect { Genre.new('') }.to raise_error(ArgumentError)
        expect { Genre.new(123) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#add_item' do
    context 'with a valid item' do
      it 'adds the item to the genre' do
        genre = Genre.new('Jazz')
        item = Item.new(1, Date.today)
        genre.add_item(item)
        expect(genre.items).to include(item)
      end

      it 'sets the genre of the item' do
        genre = Genre.new('Jazz')
        item = Item.new(1, Date.today)
        genre.add_item(item)
        expect(item.genre).to eq(genre)
      end
    end

    context 'with an invalid item' do
      it 'raises an error if item is not an instance of Item or its subclass' do
        genre = Genre.new('Hip Hop')
        expect { genre.add_item('invalid') }.to raise_error(ArgumentError)
      end
    end
  end
end
