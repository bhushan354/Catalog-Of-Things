require 'date'

class Author
  attr_accessor :first_name, :last_name
  attr_reader :id, :items

  def initialize(first_name, last_name, id = Random.rand(1..1000))
    validate_names(first_name, last_name)
    raise ArgumentError, 'id must be an integer' unless id.is_a?(Integer)

    @first_name = first_name
    @last_name = last_name
    @id = id
    @items = []
  end

  def add_item(item)
    raise ArgumentError, 'item must be an instance of the Item class' unless item.is_a?(Item)

    @items << item

    item.author = self
  end

  private

  def validate_names(first_name, last_name)
    return if first_name.is_a?(String) && last_name.is_a?(String)

    raise ArgumentError, 'first_name and last_name must be strings'
  end
end
