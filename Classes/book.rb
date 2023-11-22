require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state, :can_be_archived

  def initialize(publisher, cover_state, publish_date)
    @publisher = publisher
    @cover_state = cover_state
    super(Date.parse(publish_date))
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
