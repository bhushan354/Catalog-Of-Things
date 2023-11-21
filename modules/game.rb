require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(last_played_at: nil, multiplayer: false, id: Random.rand(1..1000), publish_date: nil, archived: false)
    super(id, publish_date, archived: archived)

    raise ArgumentError, 'last_played_at must be a Date or nil' unless last_played_at.is_a?(Date)
    raise ArgumentError, 'multiplayer must be a Boolean' unless [true, false].include?(multiplayer)

    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    return false if @last_played_at.nil?

    current_date = Date.today

    super && (last_played_at < (current_date - (365 * 2)))
  end
end
