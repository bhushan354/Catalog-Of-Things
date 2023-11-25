require_relative 'item'

class Genre
  attr_accessor :id, :name
  attr_reader :items

  def initialize(name, id = Random.rand(1..1000))
    raise ArgumentError, 'name must be a non-empty string' unless name.is_a?(String) && !name.empty?

    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    raise ArgumentError, 'item must be an instance of Item or its subclass' unless item.is_a?(Item)

    @items << item
    item.genre = self
  end
end
