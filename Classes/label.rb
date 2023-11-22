require_relative 'item'

class Label
  attr_reader :items
  attr_accessor :title, :color

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(new_item)
    @items << new_item
    new_item.label = self
  end

  def to_json(*_args)
    {
      id: Random.rand(1..100),
      title: @title,
      color: @color,
      items: @items
    }
  end
end