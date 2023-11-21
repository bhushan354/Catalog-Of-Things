# genre.rb
require_relative 'item'

class Genre
  attr_accessor :id, :name, :items

  def initialize(name)
    @id = generate_id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  private

  def generate_id
    Random.rand(1..1000)
  end
end

# Example usage

# Creating a genre
rock_genre = Genre.new('Rock')

# Creating an item
item = Item.new(Time.new(2010, 1, 1))

# Adding the item to the genre
rock_genre.add_item(item)

# Checking the association
puts item.genre.name # Output: Rock
puts rock_genre.items # Output: [item]
