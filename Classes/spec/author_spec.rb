require 'date'
require_relative '../author'
require_relative '../item'

RSpec.describe Author do
  describe '#initialize' do
    it 'raises an error if id is not an integer' do
      expect { Author.new('John', 'Doe', id: 'invalid') }.to raise_error(ArgumentError)
    end

    it 'raises an error if first_name or last_name is not a string' do
      expect { Author.new(123, 'Doe') }.to raise_error(ArgumentError)
    end
  end

  describe '#add_item' do
    it 'raises an error if the item is not an instance of the Item class' do
      author = Author.new('John', 'Doe')
      expect { author.add_item('invalid') }.to raise_error(ArgumentError)
    end

    it 'adds the item to the author\'s items' do
      author = Author.new('John', 'Doe')
      item = Item.new
      author.add_item(item)
      expect(author.items).to include(item)
    end
  end
end
