require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state, :can_be_archived

  def initialize(publisher, cover_state, id = Random.rand(1..1000), publish_date = Date.today)
    @publisher = publisher
    @cover_state = cover_state
    super(id, publish_date)
  end

  def can_be_archived?
    super || cover_state.downcase == 'bad'
  end

  def to_json(*_args)
    {
      id: Random.rand(1..100),
      publisher: @publisher,
      cover_state: @cover_state,
      publish_date: @publish_date
    }
  end
end
