require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at
  attr_reader :author

  def initialize(last_played_at: nil, multiplayer: false, id: Random.rand(1..1000), publish_date: Date.today,
                 author: nil)
    super(id, publish_date)

    raise ArgumentError, 'multiplayer must be a Boolean' unless [true, false].include?(multiplayer)

    @multiplayer = multiplayer
    @last_played_at = last_played_at

    return unless author

    @author = author
    author.items << self
  end

  def can_be_archived?
    return false if @last_played_at.nil?

    current_date = Date.today

    super && (@last_played_at < (current_date << 2))
  end

  def author=(new_author)
    new_author.items << self if new_author && !new_author.items.include?(self)
  end
end
